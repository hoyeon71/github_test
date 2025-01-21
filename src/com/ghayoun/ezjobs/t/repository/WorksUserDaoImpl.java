package com.ghayoun.ezjobs.t.repository;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.springframework.orm.ibatis.support.SqlMapClientDaoSupport;

import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.common.axis.*;

public class WorksUserDaoImpl extends SqlMapClientDaoSupport implements WorksUserDao {

    /** Logger for this class and subclasses */
	protected final Log logger = LogFactory.getLog(getClass());
	
	
	public UserBean dGetUserLogin(Map map){

		UserBean bean = (UserBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userLogin",map);
	    return bean;
	}
	
	public CommonBean dGetUserListCnt(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userListCnt",map);
		return bean;
	}
	public List<UserBean> dGetUserList(Map map){ 
		List<UserBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userList",map);
		return beanList;
	}
	public List<UserBean> dGetFolderUserList(Map map){ 
		List<UserBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.folderUserList",map);
		return beanList;
	}
	public List<UserBean> dGetUserHistoryList(Map map){ 
		List<UserBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userHistoryList",map);
		return beanList;
	}
	public List<UserBean> dGetLoginHistoryList(Map map){ 
		List<UserBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userLoginHistoryList",map);
		return beanList;
	}
	public List<UserBean> dGetUserBatchList(Map map){ 
		List<UserBean> beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userBatchList",map);
		return beanList;
	}
	
	public JobMapperBean dGetJobMapperInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobMapperInfo",map);
		
		if ( bean == null ) {
			bean = new JobMapperBean();
		}
		
		List<JobDefineInfoBean> beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoStep",map);
		for(int i=0; null!=beans && i<beans.size(); i++){
			if(i==0){
				System.out.println("bean.getT_steps : " + bean.getT_steps());
				System.out.println("beans.get(i).getT_steps() : " + beans.get(i).getT_steps());
				bean.setT_steps(beans.get(i).getT_steps());
			}else{
				bean.setT_steps(bean.getT_steps()+"|"+beans.get(i).getT_steps());
			}
		}
		beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoSetVar",map);
		System.out.println("beans.size() : " + beans.size());
		for(int j=0; null!=beans && j<beans.size(); j++){
			System.out.println("j : " + j);
			if(j==0){
				System.out.println("beans.get(j).getT_set() : " + beans.get(j).getT_set());
				bean.setT_set(beans.get(j).getT_set());
			}else{
				bean.setT_set(bean.getT_set()+"|"+beans.get(j).getT_set());
			}
		}
		return bean;
	}
	
	public JobMapperBean dGetJobMapperOriInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobMapperOriInfo",map);
		
		if ( bean == null ) {
			bean = new JobMapperBean();
		}
		
		List<JobDefineInfoBean> beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoStep",map);
		for(int i=0; null!=beans && i<beans.size(); i++){
			if(i==0){
				System.out.println("bean.getT_steps : " + bean.getT_steps());
				System.out.println("beans.get(i).getT_steps() : " + beans.get(i).getT_steps());
				bean.setT_steps(beans.get(i).getT_steps());
			}else{
				bean.setT_steps(bean.getT_steps()+"|"+beans.get(i).getT_steps());
			}
		}
		beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoSetVar",map);
		System.out.println("beans.size() : " + beans.size());
		for(int j=0; null!=beans && j<beans.size(); j++){
			System.out.println("j : " + j);
			if(j==0){
				System.out.println("beans.get(j).getT_set() : " + beans.get(j).getT_set());
				bean.setT_set(beans.get(j).getT_set());
			}else{
				bean.setT_set(bean.getT_set()+"|"+beans.get(j).getT_set());
			}
		}
		return bean;
	}
	
	public JobMapperBean dGetJobMapperDocInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobMapperDocInfo",map);
		List<JobDefineInfoBean> beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoStep",map);
		if(bean != null){
			for(int i=0; null!=beans && i<beans.size(); i++){
				if(i==0){
					System.out.println("bean.getT_steps : " + bean.getT_steps());
					System.out.println("beans.get(i).getT_steps() : " + beans.get(i).getT_steps());
					bean.setT_steps(beans.get(i).getT_steps());
				}else{
					bean.setT_steps(bean.getT_steps()+"|"+beans.get(i).getT_steps());
				}
			}
			beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoSetVar",map);
			System.out.println("beans.size() : " + beans.size());
			for(int j=0; null!=beans && j<beans.size(); j++){
				System.out.println("j : " + j);
				if(j==0){
					System.out.println("beans.get(j).getT_set() : " + beans.get(j).getT_set());
					bean.setT_set(beans.get(j).getT_set());
				}else{
					bean.setT_set(bean.getT_set()+"|"+beans.get(j).getT_set());
				}
			}
		}
		return bean;
	}
	
	public JobMapperBean dGetJobMapperDocNowInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobMapperDocNowInfo",map);
		List<JobDefineInfoBean> beans =  null;
		beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoStep",map);
		for(int i=0; null!=beans && i<beans.size(); i++){
			if(i==0){
				bean.setT_steps(beans.get(i).getT_steps());
			}else{
				bean.setT_steps(bean.getT_steps()+"|"+beans.get(i).getT_steps());
			}
		}
		beans = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"M.jobDefineInfoSetVar",map);
		for(int i=0; null!=beans && i<beans.size(); i++){
			if(i==0){
				bean.setT_set(beans.get(i).getT_set());
			}else{
				bean.setT_set(bean.getT_set()+"|"+beans.get(i).getT_set());
			}
		}
		return bean;
	}
	
	public JobMapperBean dGetJobMapperDocPrevInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobMapperDocPrevInfo",map);
		return bean;
	}
	
	public JobMapperBean dGetPrevDocInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.prevDocInfo",map);
		return bean;
	}
	
	public JobMapperBean dGetNowDocInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.nowDocInfo",map);
		return bean;
	}
	
	//폴더권한(이기준)
	public List<UserBean> dGetUserAuthList(Map map){ 
		List<UserBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userAuthList",map);
		return beanList;
	}
	
	//폴더권한복사(김은희)
	@Override
	public List<CommonBean> dGetUserFolAuthList(Map map){
		return getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userFolAuthList",map);
	}
	
	//procedure
	public Map dPrcUser(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spUserPrc",map);
		return map;
	}
	
	public Map dPrcJobMapper(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spJobMapperPrc",map);
		return map;
	}

	public List dGetSmsAdminList(Map map) {
        List beanList = null;
        beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.smsAdminList", map);
        return beanList;
    }
	
	public List<CommonBean> dGetApprovalGroupUserList(Map map){
		List<CommonBean> beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalGroupUserList",map);
		return beanList;
	}
	
	public CommonBean dGetJobUserInfo(Map map){
		CommonBean bean=  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.jobUserInfo",map);
		return bean;
	}
	
	public List<CommonBean> dGetApprovalUserList(Map map){
		List<CommonBean> beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalUserList",map);
		return beanList;
	}
	
	public List<CommonBean> dGetApprovalAdminUserList(Map map){
		List<CommonBean> beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.approvalAdminUserList",map);
		return beanList;
	}
	
	public List<CommonBean> dGetSendLogList(Map map){
		List<CommonBean> beanList =  getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.sendLogList",map);
		return beanList;
	}
	
	public CommonBean dGetUserPwChk(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userPwChk",map);
		return bean;
	}
	
	public UserBean dGetUserPwInfo(Map map){

		UserBean bean = (UserBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userPwInfo",map);
	    return bean;
	}
	
	public CommonBean dGetUserBeforePwChk(Map map){
		CommonBean bean =  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.userBeforePwChk",map);
		return bean;
	}
	public CommonBean dGetDocUserInfo(Map map){
		CommonBean bean=  (CommonBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.docUserInfo",map);
		return bean;
	}
	
	public JobMapperBean dGetSrJobOrderInfo(Map map){
		JobMapperBean bean =  (JobMapperBean)getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.srJobOrderInfo",map);
		return bean;
	}
	
	public List<UserBean> dGetWorkGroup(Map map){ 
		List<UserBean> beanList = null;
    	
		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.workGroup",map);
		return beanList;
	}
	public List<UserBean> dGetAlarmInfo(Map map){
		List<UserBean> beanList = null;

		beanList = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.alarmInfo",map);
		return beanList;
	}
	
	public Map dPrcAlarmInfo(Map map){
		getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN"))+"_"+"T.spAlarmInfoPrc",map);
		return map;
	}

	public Map dDelUserJobMapper(Map map) {
	    UserBean userBean = (UserBean) getSqlMapClientTemplate().queryForObject(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN")) + "_" + "T.dDelUserJobMapper", map);

	    if (userBean != null && userBean.getUser_cd() != null) {
	    	
	    	map.put("user_cd", CommonUtil.isNull(userBean.getUser_cd()));
	    	
	        getSqlMapClientTemplate().update(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN")) + "_" + "T.dUpdateJobMapper", map);
	    }
	    
	    return map;
	}
	
	public List<JobMapperMFTBean> dGetJobMapperMFTInfo(Map map){
		List<JobMapperMFTBean> bean = getSqlMapClientTemplate().queryForList(CommonUtil.isNull(CommonUtil.getMessage("DB_GUBUN")) + "_" + "T.jobMapperMFTInfo",map);
		return bean;
	}

}
