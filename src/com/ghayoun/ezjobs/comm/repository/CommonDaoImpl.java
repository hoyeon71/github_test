package com.ghayoun.ezjobs.comm.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ghayoun.ezjobs.comm.domain.AppGrpBean;
import com.ghayoun.ezjobs.comm.domain.BoardBean;
import com.ghayoun.ezjobs.comm.domain.CalCodeBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.domain.DgbFwaBean;
import com.ghayoun.ezjobs.comm.domain.HolidayBean;
import com.ghayoun.ezjobs.common.axis.ConnectionManager;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;

public class CommonDaoImpl extends SqlMapClientDaoSupport implements CommonDao { 
	
	

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	public List<CommonBean> dGetSearchItemList(Map map) {
		
    	String searchType = (String)map.get("searchType");
    	
		List<CommonBean> beanList = null;

		if("odateList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.odateList",map);
		}if("odatePostList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.odatePostList",map);
		}else if("dataCenterList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dataCenterList",map);
		}else if("applicationList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.applicationList",map);
		}else if("group_nameList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupNameList",map);
		}else if("monthApplicationList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.monthApplicationList",map);
		}else if("monthGroup_nameList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.monthGroupNameList",map);
		}else if("sched_tableList".equals(searchType)){
			//beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.schedTableList",map);
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.parentSchedTableList",map);
		}else if("application_of_defList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.applicationOfDefList",map);
		}else if("group_name_of_defList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupNameOfDefList",map);
		}else if("calendarList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calendarList",map);
		}else if("nodeIdList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.nodeIdList",map);
		}else if("job_nameList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.jobNameList",map);
		}else if("user_daily_of_defList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userDailyList",map);
		}else if("days_calList".equals(searchType)){
			//map.put("year", CommonUtil.getCurDate("Y"));
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calendarList",map);
		}else if("weeks_calList".equals(searchType)){
			//map.put("year", CommonUtil.getCurDate("Y"));
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calendarList",map);
		}else if("hostList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.hostList",map);
		}else if("databaseList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.databaseList",map);
		}else if("SearchHostList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.SearchHostList",map);
		}else if("host_pathList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.hostInfo",map);		
		}else if("applicationFromToList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.applicationFromToList",map);
		}else if("group_nameFromToList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupNameFromToList",map);
		}else if("sub_table_of_defList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.subSchedTableList",map);		
		}else if("ctmOdateList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.commOdateInfo",map);
		}else if("jobNameAutoList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.jobNameAutoList",map);
		}else if("conf_calList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calendarList",map);
		}else if("sched_tableList2".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dGetFolderList",map);
		}else if("sched_tableList3".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dGetAllFolderList",map);
		}else if("sched_user_tableList".equals(searchType)){
			beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dGetUserFolderList",map);
		}
		
        return beanList;
    }
	
	public List<CommonBean> getCategoryList(Map map, String type){
		
		List<CommonBean> beanList = new ArrayList();
		
		String sTmp = CommonUtil.getMessage(type);
		String aTmp[] = sTmp.split(",");
		for( int i=0,len=aTmp.length; i<len; i++){
			String aTmp1[] = aTmp[i].split("[|]");
			
			CommonBean bean =new CommonBean();
			bean.setCategoryCode(aTmp1[0]);
			bean.setCategoryName(aTmp1[1]);
			
			beanList.add(bean);
		}
		
		return beanList;
	}
	
	public CommonBean dGetCalendarDetail(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calendarDetail",map);
		return bean;
	}
	
	public List<CommonBean> dGetCalendarYearList(Map map) {
		List<CommonBean> beanList = new ArrayList();
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calendarYearList",map);
		
		return beanList;
	}
	
	public Map emLogin(Map map){
		ConnectionManager cm = new ConnectionManager();
		map = cm.login(map);
        return map;
    }
	
	
	public List<CommonBean> dGetsCodeList(Map map) {
		List<CommonBean> beanList = new ArrayList();
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.sCodeList",map);
		
		return beanList;
	}
	
	public List<CommonBean> dGetAvgTimeOverJobList(Map map){

		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.avgTimeOverJobList", map);
	}

	public CommonBean dGetHostInfo(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.hostInfo",map);
		return bean;
	}
	
	public CommonBean dGetServerInfo(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.serverInfo",map);
		return bean;
	}
	
	public CommonBean dGetSearchHostInfo(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.SearcHostInfo",map);
		return bean;
	}
	
	//procedure
	public Map dPrcHost(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spHostPrc",map);
		return map;
	}
	
	public Map dPrcDatabase(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spDatabasePrc",map);
		return map;
	}
	
	
	//dgb-----------------------------------------
	public CommonBean dGetDgbFwaShListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbFwaShListCnt",map);
		return bean;
	}
	public List<DgbFwaBean> dGetDgbFwaShList(Map map){
		List<DgbFwaBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbFwaShList",map);
		return beanList;
	}
	
	public CommonBean dGetDgbFwaListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbFwaListCnt",map);
		return bean;
	}
	public List<DgbFwaBean> dGetDgbFwaList(Map map){
		List<DgbFwaBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbFwaList",map);
		return beanList;
	}
	
	public DgbFwaBean dGetDgbJobInfo(Map map){
		DgbFwaBean bean =  (DgbFwaBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbJobInfo",map);
		return bean;
	}
	
	public DgbFwaBean dGetDgbShellInfo(Map map){
		DgbFwaBean bean =  (DgbFwaBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbShellInfo",map);
		return bean;
	}
	

	public CommonBean dGetDgbDefJobListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbDefJobListCnt",map);
		return bean;
	}
	public List<DgbFwaBean> dGetDgbDefJobList(Map map){
		List<DgbFwaBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbDefJobList",map);
		return beanList;
	}
	public CommonBean dGetDgbDocJobListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbDocJobListCnt",map);
		return bean;
	}
	public List<DgbFwaBean> dGetDgbDocJobList(Map map){
		List<DgbFwaBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbDocJobList",map);
		return beanList;
	}
	
	
	public CommonBean dGetDgbHostInfo(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dgbHostInfo",map);
		return bean;
	}
	
	//procedure
	public Map dPrcDgbDoc(Map map){
		map.put("rqst_title",CommonUtil.toKorHex(CommonUtil.E2K(CommonUtil.isNull(map.get("title")))));
		map.put("rqstr_nm",CommonUtil.toKorHex(CommonUtil.E2K(CommonUtil.isNull(map.get("rqstr_nm")))));
		map.put("dcs_stt",CommonUtil.toKorHex(CommonUtil.E2K(CommonUtil.isNull(map.get("dcs_stt")))));
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spDgbDocPrc",map);
		return map;
	}
	
	public CommonBean dGetDefJobCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.defJobCnt",map);
		return bean;
	}
	
	public CommonBean dGetSearchItemValue(Map map){
		
        String searchType = (String)map.get("searchType");
        
        CommonBean bean = null;
       
        if("confirm_number_check".equals(searchType))
            bean = (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.confirmNumberCheck", map);
        else
        if("confirm_number_check_master".equals(searchType))
            bean = (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.confirmNumberCheckMaster", map);
        else
        if("master_check".equals(searchType))
            bean = (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.masterCheck", map);
        
        return bean;
    }
	
	public Map dPrcLog(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spLogPrc",map);
		return map;
	}
	
	public List<CommonBean> dGetJobNameList(Map map){
		List<CommonBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.m_status_hisList",map);
        return beanList;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<BoardBean> dGetBoardList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardList", map);
	}
	
	@Override
	public List<BoardBean> dGetBoardInfo(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardInfo", map);
	}
	
	@Override
	public Map<String, Object> dPrcBoard(Map<String, Object> map) {
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spBoardPrc", map);
		
		return map;
	}
	
	@Override
	public CommonBean dGetBoardListCnt(Map<String, Object> map) {
		
		return (CommonBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardListCnt", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<BoardBean> dGetBoardNoti(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardNotice", map);
	}
	
	@Override
	public int dGetBoardCd(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardCd", map);
	}
	
	@Override
	public int dPrcBoardInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardInsert", map);
	}
	
	@Override
	public int dPrcBoardUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardUpdate", map);
	}
	
	@Override
	public int dPrcBoardDelete(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.boardDelete", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HolidayBean> dGetHolidayList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.holidayList", map);
	}
	
	@Override
	public CommonBean dGetHolidayListCnt(Map<String, Object> map) {
		
		return (CommonBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.holidayListCnt", map);
	}
	
	@Override
	public Map<String, Object> dPrcHoliday(Map<String, Object> map) {
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spHolidayPrc", map);
		
		return map;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<HolidayBean> dGetHolidayDayList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.holidayDayList", map);
	}

	@Override
	public String dGetMcodeCd(Map<String, Object> map) {
		
		return (String) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mcodeCd", map);
	}

	@Override
	public String dGetScodeCd(Map<String, Object> map) {
		
		return (String) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.scodeCd", map);
	}

	@Override
	public int dGetMcodeDupChk(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mcodeDupChk", map);
	}
	
	@Override
	public int dGetScodeDupChk(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.scodeDupChk", map);
	}
	
	@Override
	public int dPrcMcodeInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mcodeInsert", map);
	}

	@Override
	public int dPrcMcodeUpdate(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mcodeUpdate", map);
	}

	@Override
	public int dPrcScodeInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.scodeInsert", map);
	}

	@Override
	public int dPrcScodeUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.scodeUpdate", map);
	}
	
	@Override
	public int dPrcScodeDelete(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.scodeDelete", map);
	}
	
	@Override
	public int dGetAppGrpDupChk(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpDupChk", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AppGrpBean> dGetAppGrpList(Map<String, Object> map) {

		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AppGrpBean> dGetAppGrp2List(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpList2", map);
	}
	
	@Override
	public int dPrcAppGrpInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpInsert", map);
	}
	
	@Override
	public int dPrcAppGrpUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpUpdate", map);
	}
	
	@Override
	public int dPrcAppGrpDelete(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpDelete", map);
	}
	
	@Override
	public int dPrcUserFloderDelete(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("CM_DB_GUBUN"))+"_"+"Common.userFloderDelete", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetScodeList(Map<String, Object> map) {
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		HttpSession	session			= request.getSession(true);
		map.put("server_gb", 	CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB")));
		map.put("s_user_gb", 	CommonUtil.isNull(session.getAttribute("USER_GB")));
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.scodeList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetWorkGroupItemList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.workgroupItemList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AppGrpBean> dGetAppGrpCodeList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpCodeList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AppGrpBean> dGetAppGrpCodeList2(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpCodeList2", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<AppGrpBean> dGetSearchAppGrpCodeList(Map<String, Object> map) {   
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.searchAppGrpCodeList", map);
	}
	
	@Override	
	public AppGrpBean dGetAppGrpCodeInfo(Map<String, Object> map) {
		return (AppGrpBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpCodeInfo", map);
	}
	
	@Override
	public CommonBean dGetHostInfoChk(Map<String, Object> map) {
		
		return (CommonBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.hostInfoChk", map);
	}
	@Override
	public int dGetTableMpngHostChk(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mpngHostChk", map);
	}
	@Override	
	public AppGrpBean dGetAppParentCd(Map<String, Object> map) {
		return (AppGrpBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appParentCd", map);
	}
	
	
	@Override
	public AppGrpBean dGetGrpParentCd(Map<String, Object> map) {
		
		return (AppGrpBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.grpParentCd", map);
	}
	@Override
	public int dGetAppGrpCd(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.appGrpCd", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CalCodeBean> dGetCalCodeList2(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calCodeList2", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CalCodeBean> dGetCalCodeList3(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calCodeList3", map);
	}
	
	@Override
	public String dGetCalCodeCd(Map<String, Object> map) {
		
		return (String) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calCodeCd", map);
	}
	
	@Override
	public int dGetCalCodeDupChk(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.calCodeDupChk", map);
	}
	
	@Override
	public JobMapperBean dGetDocFileInfo(Map<String, Object> map) {
		
		return (JobMapperBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.myDocFileInfo", map);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetMyWorksInfoList(Map<String, Object> map) {		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.myWorksInfoList", map);
	}
	
	public List<CommonBean> dGetMyDocInfoCntList(Map<String, Object> map) {		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.myDocInfoCntList", map);
	}
	
	public List<CommonBean> dGetMyAlarmDocInfoCntList(Map<String, Object> map) {		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.myAlarmDocInfoCntList", map);
	}
	
	public List<CommonBean> dGetMyApprovalDocInfoList(Map<String, Object> map) {		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.myApprovalDocInfoList", map);
	}
	public List<CommonBean> dGetExecDocInfoList(Map<String, Object> map) {		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.execDocInfoList", map);
	}
	
	public List<CommonBean> dGetMyWorkList(Map<String, Object> map) {		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.myWorkList", map);
	}

	@Override
	public String dGetCtmActiveNetName(Map<String, Object> map) {
		
		return (String) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmActiveNetName", map);
	}
	
	@Override
	public String dGetMainAllDocInfoCnt(Map<String, Object> map) {
		
		return (String) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mainAllDocInfoListCnt", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<DocInfoBean> dGetMainAllDocInfoList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mainAllDocInfoList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetCtmLogList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmLogList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetCtmIoalog(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmIoalogList", map);
	}
	
	@Override
	public int dPrcCtmIoalogInsert(Map<String, Object> map) {
		
		// INSERT 하기 전에 DELETE 먼저 진행.
		getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmIoaLogDelete", map);
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmIoaLogInsert", map);
	}
	
	@Override
	public int dPrcCtmIoalogPartitionCreate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmIoaLogPartitionCreate", map);
	}
	
	@Override
	public int dGetCtmLogPartChk(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmLogPartChk", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetUserApprovalGroup(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalGroupList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetUserApprovalLine(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineList", map);
	}
	
	@Override
	public int dPrcUserApprovalGroupInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalGroupInsert", map);
	}
	
	@Override
	public int dPrcUserApprovalGroupUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalGroupUpdate", map);
	}
	
	@Override
	public int dPrcUserApprovalGroupDelete(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalGroupDelete", map);
	}
	
	@Override
	public int dPrcUserApprovalLineInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineInsert", map);
	}
	
	@Override
	public int dPrcUserApprovalLineUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineUpdate", map);
	}
	
	@Override
	public int dPrcUserApprovalLineDelete(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineDelete", map);
	}
	
	@Override
	public int dGetUserApprovalGroupSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalGroupSeq", map);
	}
	
	@Override
	public int dGetUserApprovalLineSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineSeq", map);
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetWorkGroupList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.workGroupList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetAdminApprovalGroup(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalGroupList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetAdminApprovalLine(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetAdminApprovalLine_u(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineList_u", map);
	}
	
	@Override
	public List<CommonBean> dGetApproavlGroupCnt(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.approavlGroupCnt", map);
	}
	
	@Override
	public int dPrcAdminApprovalGroupInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalGroupInsert", map);
	}
	
	@Override
	public int dPrcAdminApprovalGroupUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalGroupUpdate", map);
	}
	
	@Override
	public int dPrcAdminApprovalGroupDelete(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalGroupDelete", map);
	}
	
	@Override
	public int dPrcAdminApprovalLineInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineInsert", map);
	}
	
	@Override
	public int dPrcAdminApprovalLineUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineUpdate", map);
	}
	
	@Override
	public int dPrcAdminApprovalLineDelete(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineDelete", map);
	}
	
	@Override
	public int dGetAdminApprovalGroupSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalGroupSeq", map);
	}
	
	@Override
	public int dGetAdminApprovalLineSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineSeq", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetGroupApprovalGroup(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalGroupList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetGroupApprovalLine(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalLineList", map);
	}
	
	@Override
	public int dPrcGroupApprovalGroupInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalGroupInsert", map);
	}
	
	@Override
	public int dPrcGroupApprovalGroupUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalGroupUpdate", map);
	}
	
	@Override
	public int dPrcGroupApprovalGroupDelete(Map<String, Object> map) {
	
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalGroupDelete", map);
	}
	
	@Override
	public int dPrcGroupApprovalLineInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalLineInsert", map);
	}
	
	@Override
	public int dPrcGroupApprovalLineUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalLineUpdate", map);
	}
	
	@Override
	public int dPrcGroupApprovalLineDelete(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalLineDelete", map);
	}
	
	@Override
	public int dGetGroupApprovalGroupSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalGroupSeq", map);
	}
	
	@Override
	public int dGetGroupApprovalLineSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalLineSeq", map);
	}
	
	@Override
	public int dGetDefTableCnt(Map<String, Object> map) {
	
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.defTableCnt", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetCtmAgentList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmAgentList", map);
	}
	
	@Override
	public int dPrcCtmAgentInfoUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.ctmAgentInfoUpdate", map);
	}
	
	@Override
	public Doc06Bean dGetDoc06FileInfo(Map<String, Object> map) {
		
		return (Doc06Bean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.myDoc06FileInfo", map);
	}
	
	@Override
	public int dPrcGrpHostInsert(Map<String, Object> map) {
		
//		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.grpHostInsert", map);
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spHostPrc", map);
	}
	
	@Override
	public int dPrcGrpHostDelete(Map<String, Object> map) {

//		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.grpHostDelete", map);
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spHostPrc", map);
	}
	
	@Override
	public int dPrcGrpHostExcelInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.grpHostInsert", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetMHostList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.mHostList", map);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetHostInfoList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.hostInfo", map);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetEzHostList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.EzHostList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetEmOwnerList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.EmOwnerList", map);
	}
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetEzOwnerList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.EzOwnerList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	
	public List<CommonBean> dGetArgumentList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.argumentList", map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CommonBean> dGetInCondNameList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.inCondNameList", map);
	}
	
	public CommonBean dGetChkUserApprovalUseCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalUseCnt",map);
		return bean;
	}
	public CommonBean dGetChkAdminApprovalUseCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalUseCnt",map);
		return bean;
	}
	
	@Override
	public int dGetAdminApprovalGroupChkCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalGroupChkCnt", map);
	}
	@Override
	public int dGetUserApprovalLineApprovalSeqCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineApprovalSeqCnt", map);
	}
	@Override
	public int dGetUserApprovalLineApprovalGbCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineApprovalGbCnt", map);
	}
	@Override
	public int dGetUserApprovalLineApprovalUserCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userApprovalLineApprovalUserCnt", map);
	}
	
	
	@Override
	public int dGetGroupApprovalLineApprovalSeqCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupApprovalLineApprovalSeqCnt", map);
	}
	
	@Override
	public int dGetAdminApprovalLineApprovalSeqCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineApprovalSeqCnt", map);
	}
	@Override
	public int dGetAdminApprovalLineApprovalGbCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineApprovalGbCnt", map);
	}
	@Override
	public int dGetAdminApprovalLineApprovalCdCnt(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineApprovalCdCnt", map);
	}

	public List<CommonBean> dGetCmsNodGrpList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.cmsNodGrpList", map);
	}
	
	public List<CommonBean> dGetCmsNodGrpNodeList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.cmsNodGrpNodeList", map);
	}
	
	public List<CommonBean> dGetCheckSmartTableCnt(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.checkSmartTableCnt", map);
	}
	
	public List<CommonBean> dGetUserDailyNameList(Map map) {
		
		List<CommonBean> beanList = new ArrayList();
		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.userDailyNameList",map);
		
		return beanList;
	}
	
	
	public CommonBean dGetHolidayCheck(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.holiday_check",map);
		return bean;
	}

	
	//dblink
	public void dblinkConnect() {
		String strParam1 = CommonUtil.getMessage("DBLINK.PARAM1");
		String strParam2 = CommonUtil.getMessage("DBLINK.PARAM2");
		String strParam3 = CommonUtil.getMessage("DBLINK.PARAM3");
		String strParam4 = CommonUtil.getMessage("DBLINK.PARAM4");
		String strParam5 = CommonUtil.getMessage("DBLINK.PARAM5");
		String strParam6 = CommonUtil.getMessage("DBLINK.PARAM6");
		Map<String, Object> map = new HashMap<>();
		
		map.put("dblink",		strParam1);
		map.put("hostaddr", 	strParam2);
		map.put("user",			strParam3);
		map.put("password",	 	strParam4);
		map.put("dbname", 		strParam5);
		map.put("port", 		strParam6);
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dblinkConnect",map);
		
	}
	
	public void dblinkdisConnect() {
		String strParam1 = CommonUtil.getMessage("DBLINK.PARAM1");
		
		Map<String, Object> map = new HashMap<>();
		map.put("dblink", strParam1);
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dblinkDisconnect",map);
	}
	
	public List<CtmInfoBean> dGetJobCondList(Map map){
		List<CtmInfoBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.jobCondList",map);
        return beanList;
	}
	
	//smartforder
	public List<CommonBean> dGetsForderList(Map map) {
		
		List<CommonBean> beanList = new ArrayList();
		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.sForderList",map);
		
		return beanList;
	}

	@Override
	public List<AppGrpBean> dGetChildAppGrpCodeList(Map<String, Object> map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.childAppGrpCodeList",map);
	}

	@Override
	public String dGetNodeInfo(Map<String, Object> map) {
		return (String) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.getNodeInfo", map);
	}

	@Override
	public List dGetBatchTotal(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.batchTotal",map);
	}

	@Override
	public List dGetDocApprovalTotal(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.docApprovalTotal",map);
	}

	@Override
	public List dGetJobCondTotal(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.jobCondTotal",map);
	}

	@Override
	public List dGetErrorLogTotal(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.errorLogTotal",map);
	}
	
	@Override
	public List dGetErrorLogTotalCnt(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.errorLogTotalCnt",map);
	}
	
	@Override
	public List dGetDefJobExceptMapper(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.defJobExceptMapper",map);
	}
	
	@Override
	public List dGetCmTable(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.cmTable",map);
	}

	@Override
	public List dGetCmApplication(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.cmApplication",map);
	}

	@Override
	public List dGetCmGroup(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.cmGroup",map);
	}
	
	@Override
	public List dGetQuartzList(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.quartzList",map);
	}

	@Override
	public List dGetPopupQuartzList(Map map) {
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.popupQuartzList",map);
	}
	
	@Override
	public List<CommonBean> dGetGroupUserGroup(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserGroup", map);
	}
	
	@Override
	public int dGetGroupUserGroupSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserGroupSeq", map);
	}
	
	@Override
	public int dPrcGroupUserGroupInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserGroupInsert", map);
	}
	
	@Override
	public int dPrcGroupUserGroupUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserGroupUpdate", map);
	}
	
	@Override
	public int dPrcGroupUserGroupDelete(Map<String, Object> map) {
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserGroupDelete", map);
	}
	
	@Override
	public List<CommonBean> dGetGroupUserLine(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserLineList", map);
	}
	
	@Override
	public List<CommonBean> dGetAdminApprovalLineCd(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.adminApprovalLineCd", map);
	}
	
	@Override
	public List<CommonBean> dGetAdminApprovalLineList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.getApprovalLine", map);
	}
	
	@Override
	public int dGetGroupUserLineSeq(Map<String, Object> map) {
		
		return (int) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserLineSeq", map);
	}
	
	@Override
	public int dPrcGroupUserLineInsert(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserLineInsert", map);
	}
	
	@Override
	public int dPrcGroupUserLineUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserLineUpdate", map);
	}
	
	@Override
	public int dPrcGroupUserLineDelete(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().delete(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.groupUserLineDelete", map);
	}
	
	public List<CommonBean> dGetAlarmInfo(Map map) {
	
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.alarmInfo", map);
	}
	
	//작업 이력조회 팝업창
	public List<CommonBean> dGetJobHistoryInfo(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.jobHistoryInfo", map);
	}
	
	public CommonBean dGetSmartTableChk(Map map) {
		
		return (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.smartTableChk",map);
	}
	
	public CommonBean dGetSubTableChk(Map map) {
		
		return (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.subTableChk",map);
	}
	
	public List<AppGrpBean> dGetSubTableList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.subTableList", map);
	}
	
	//setvar table 조회
	public List<CommonBean> dGetSetvarList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.setvarList", map);
	}
	
	public List<CommonBean> dGetSmartTreeList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.smartTreeList", map);
	}
	
	public List<CommonBean> dGetSmartTreeInfoList(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.smartTreeInfoList", map);
	}
	
	@Override
	public int delSmsUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.delSmsUpdate", map);
	}
}
