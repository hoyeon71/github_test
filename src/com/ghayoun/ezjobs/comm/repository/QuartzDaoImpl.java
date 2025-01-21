package com.ghayoun.ezjobs.comm.repository;

import java.time.Duration;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;
import com.ghayoun.ezjobs.a.domain.AlertBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.BatchResultTotalBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.UserBean;

public class QuartzDaoImpl extends SqlMapClientDaoSupport implements QuartzDao {
	
    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());

	public List<CommonBean> aJobList(Map map) {

		List<CommonBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.aJobList",map);		
		return beanList;
	}
	
	public CommonBean EZ_HISTORY_CNT(Map map) {
		
		CommonBean bean = (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.EZ_HISTORY_CNT",map);
		
		return bean;
		
	}
	
	public Map dPrcQuartz(Map map){
		
		String strFlag 			= CommonUtil.isNull(map.get("flag"));
		String strActiveNetName	= CommonUtil.isNull(map.get("active_net_name"));
		String strCmDbGubun		= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"));
		
		// 오라클일 경우에만 권한 부여 (2023.12.11 강명준)
		if ( strCmDbGubun.equals("ORACLE") ) { 
		
			//히스토리 쿼츠 최초 동작시 ajob에 select권한 부여
			if(strFlag.equals("EZ_HISTORY")) {
				getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.aJobGrantAuth",map);
	
				// 선행 테이블 select 권한 부여 (2023.10.05 강명준)
				map.put("in_name", strActiveNetName.replace("JOB", "LNKI_P"));
				getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.aInGrantAuth",map);
	
				// 후행 테이블 select 권한 부여 (2023.10.05 강명준)
				map.put("out_name", strActiveNetName.replace("JOB", "LNKO_P"));
				getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.aOutGrantAuth",map);
				
				// 변수 테이블 select 권한 부여 (2023.12.11 강명준)
				map.put("setvar", strActiveNetName.replace("JOB", "SETVAR"));
				getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.aSetVarAuth",map);
			}
		}
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spQuartzPrc",map);
		
		return map;
	}
	
	//오라클에서 select 권한을 부여하기 위해 ez_alarm 쿼츠 동작시 조건에 맞을 경우 권한 부여하도록 로직 개선
	public Map dPrcQuartzSms(Map map){
		
		String strCmDbGubun		= CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"));

		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		String dataCenterList		= CommonUtil.isNull(map.get("DATA_CENTER_LIST"));
		String activeNetNameList	= CommonUtil.isNull(map.get("ACTIVE_NET_NAME_LIST"));

		String ctmDailyTimeList 	= CommonUtil.isNull(map.get("CTM_DAILY_TIME"));
		String serverCheckTimeList 	= CommonUtil.isNull(map.get("CHECK_TIME"));

		String ctmDailyTime		= "";
		String serverCheckTime	= "";
		String dataCenter		= "";
		String activeNetName	= "";

		for(int i=0;i<dataCenterList.split(",").length;i++) {

			dataCenter		= dataCenterList.split(",")[i];
			activeNetName	= activeNetNameList.split(",")[i];
			activeNetName	= activeNetName + "JOB";

			map.put("data_center", dataCenter);
			map.put("active_net_name", activeNetName);
			// 오라클일 경우에만 권한 부여 (2023.12.11 강명준)
			if ( strCmDbGubun.equals("ORACLE") ) {
				getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN")) + "_" + "Common.aJobGrantAuth", map);
			}
			getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.spQuartzPrc",map);
		}

		return map;
	}
	
	public CommonBean eaiUserCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.eaiUserCnt",map);
		return bean;
	}
	
	public List<AlertBean> smsAlarmList(Map map) {

		List<AlertBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.smsAlarmList",map);		
		return beanList;
	}
	
	public List<AlertBean> deletedJobAlarmList(Map map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.deletedJobAlarmList", map);
	}
	
	public CommonBean aJobCheckCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.aJobCheckCnt",map);
		return bean;
	}
	
	public List<DocInfoBean> apiCallJobList(Map map) {

		List<DocInfoBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.apiCallJobList",map);		
		return beanList;
	}
	
	public List<DocInfoBean> preDateBatchJobList(Map map) {

		List<DocInfoBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.preDateBatchJobList",map);		
		return beanList;
	}
	
	public List<DocInfoBean> susiApiCallJobList(Map map) {

		List<DocInfoBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.susiApiCallJobList",map);		
		return beanList;
	}

	@Override
	public void insertEzAlram(AlertBean alertBean) {
		getSqlMapClientTemplate().insert(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.insertEzAlram", alertBean);
	}
	
	public CommonBean getDataCenterInfo(Map map){  
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dataCenterInfo",map);
		return bean;
	}
	
	public List<BatchResultTotalBean> dGetDailyReportList(Map map){
		List<BatchResultTotalBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dailyReportList",map);
        return beanList;
	}
	
	public List<UserBean> dGetDailyReportSendUserList(Map map) {

		List<UserBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dailyReportSendUserList",map);		
		return beanList;
	}
	
	public List<UserBean> dGetDailyReportSendAdminList(Map map) {

		List<UserBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.dailyReportSendAdminList",map);		
		return beanList;
	}

	@SuppressWarnings("unchecked")
	public List<Doc06Bean> dGetExcelBatchList(Map<String, Object> map){
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.excelBatchList",map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Doc06Bean> dGetExcelBatchVeriList(Map<String, Object> map){
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.excelBatchVeriList",map);
	}
	
	@Override
	public int dPrcExcelBatchApplyUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.excelBatchApplyUpdate",map);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Doc06Bean> dGetExcelBatchExecuteGroup(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.excelBatchExcuteGroup",map);
	}   
	@SuppressWarnings("unchecked")
	@Override
	public List<Doc06Bean> dGetExcelVerifyBatchExecuteGroup(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.excelVerifyBatchExcuteGroup",map);
	}   
	
	public int dGetExcelBatchErrMsgUpdate(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.excelBatchErrMsgUpdate",map);		
	}
	
	@Override
	public CommonBean dGetExcelBatchDelTable(Map<String, Object> map) {
		
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.excelBatchDelTable",map);
	
		return bean;
	}
	
	public Map dPrcUser(Map map){
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spUserPrc",map);
		
		return map;
	}
	
	public Map dPrcDept(Map map){
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDeptPrc",map);
		
		return map;
	}	
	
	public Map dPrcDuty(Map map){
		
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spDutyPrc",map);
		
		return map;
	}
	
	@SuppressWarnings("unchecked")
    @Override
    public List<Doc06Bean> dGetTableUploadList(Map<String, Object> map) {
      
       return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.tableUploadList",map);
    }
	
	public List<JobDefineInfoBean> defJobList(Map map) {

		List<JobDefineInfoBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.defJobList",map);		
		return beanList;
	}

	@Override
	public List<UserBean> dGetDeptRelay(Map<String, Object> map) {
		List<UserBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.getDeptRelay", map);
		return beanList;
	}

	@Override
	public List<UserBean> dGetUserReplay(Map<String, Object> map) {
		List<UserBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.getUserRelay", map);
		return beanList;
	}

	@Override
	public List<UserBean> dGetDutyRelay(Map<String, Object> map) {
		List<UserBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.getDutyRelay", map);
		return beanList;
	}
	
	public List<CommonBean> emExcutingJobList(Map map) {

		List<CommonBean> beanList = new ArrayList();		
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.emExcutingJobList",map);		
		return beanList;
	}
	
	@Override
	public int dPrcUpdateStatusHistory(Map<String, Object> map) {
		
		return getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"Common.updateStatusHistory",map);
	}
}



