package com.ghayoun.ezjobs.t.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.domain.UserBean;


public interface WorksUserService extends Serializable{

	public UserBean dGetUserLogin(Map map) throws Exception;
	
	public CommonBean dGetUserListCnt(Map map);
	public List<UserBean> dGetUserList(Map map);
	public List<UserBean> dGetFolderUserList(Map map);
	public List<UserBean> dGetUserHistoryList(Map map);
	public List<UserBean> dGetUserBatchList(Map map);
	public List<UserBean> dGetLoginHistoryList(Map map);
	
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
	public Map dPrcUser(Map map) throws Exception;
	public Map dPrcUserAuth(Map map) throws Exception;
	public Map dPrcUserInit(Map map) throws Exception;
	public Map dPrcUserPwChange(Map map) throws Exception;
	public Map dPrcUserExcel(Map map) throws Exception;
	public Map dPrcJobMapper(Map map) throws Exception;
	public List dGetSmsAdminList(Map map);
	public CommonBean dGetJobUserInfo(Map map);
	public List dGetApprovalGroupUserList(Map map);
	public List dGetApprovalUserList(Map map);
	public List dGetApprovalAdminUserList(Map map);
	public List dGetSendLogList(Map map);
	public Map dPrcAllUser(Map map) throws Exception;
	public CommonBean dGetDocUserInfo(Map map);
	public JobMapperBean dGetSrJobOrderInfo(Map map);
	public List<UserBean> dGetWorkGroup(Map map);
	public List<UserBean> dGetAlarmInfo(Map map);
	public Map dPrcAlarmInfo(Map map) throws Exception;
	public Map dPrcCreateTempPassword(Map map) throws Exception;
}
