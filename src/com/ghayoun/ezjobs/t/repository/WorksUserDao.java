package com.ghayoun.ezjobs.t.repository;

import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.t.domain.*;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.m.domain.*;

public interface WorksUserDao {
	
	public UserBean dGetUserLogin(Map map);
	
	public CommonBean dGetUserListCnt(Map map);
	public List<UserBean> dGetUserList(Map map);
	public List<UserBean> dGetFolderUserList(Map map);
	public List<UserBean> dGetUserHistoryList(Map map);
	public List<UserBean> dGetUserBatchList(Map map);
	public List<UserBean> dGetLoginHistoryList(Map map);
	//담당자정보
	public JobMapperBean dGetJobMapperInfo(Map map);
	public JobMapperBean dGetJobMapperOriInfo(Map map);
	public JobMapperBean dGetJobMapperDocInfo(Map map);
	
	public JobMapperBean dGetJobMapperDocNowInfo(Map map);
	public JobMapperBean dGetJobMapperDocPrevInfo(Map map);
	public JobMapperBean dGetPrevDocInfo(Map map);
	public JobMapperBean dGetNowDocInfo(Map map);
	
	//폴더권한(이기준)
	public List<UserBean> dGetUserAuthList(Map map);
	
	//폴더권한복사(김은희)
	public List<CommonBean> dGetUserFolAuthList(Map map);
		
	//procedure
	public Map dPrcUser(Map map);
	
	public Map dPrcJobMapper(Map map);
	
	public abstract List dGetSmsAdminList(Map map);
	
	public CommonBean dGetJobUserInfo(Map map);
	public List<CommonBean> dGetApprovalGroupUserList(Map map);
	public List<CommonBean> dGetApprovalUserList(Map map);
	public List<CommonBean> dGetApprovalAdminUserList(Map map);
	
	public List<CommonBean> dGetSendLogList(Map map);
	
	public CommonBean dGetUserPwChk(Map map);
	
	public UserBean dGetUserPwInfo(Map map);
	
	public CommonBean dGetUserBeforePwChk(Map map);
	
	public CommonBean dGetDocUserInfo(Map map);
	
	public JobMapperBean dGetSrJobOrderInfo(Map map);
	
	public List<UserBean> dGetWorkGroup(Map map);
	public List<UserBean> dGetAlarmInfo(Map map);
	public Map dPrcAlarmInfo(Map map);

	public Map dDelUserJobMapper(Map map);

	public List<JobMapperMFTBean> dGetJobMapperMFTInfo(Map map);
	
}