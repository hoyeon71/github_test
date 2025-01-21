package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.*;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.m.repository.EmJobLogDao;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.common.util.Ssh3Util;
import org.springframework.scheduling.quartz.QuartzJobBean;

public class EzJobSysServiceImpl extends QuartzJobBean {

	protected final Log logger = LogFactory.getLog(getClass());
	private static final Lock QLOCK = new ReentrantLock();

	private QuartzDao quartzDao;
	private CommonDao commonDao;
	private EmJobLogDao emJobLogDao;
	private CommonService commonService;

	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {

		Map chkHostMap = CommonUtil.checkHost();

		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");

		logger.debug("OS 호스트명 : " + strHostName + "| 코드관리 호스트명 : " + strHost + "| 호스트 체크 결과 : " + chkHost);

		if(chkHost) {
			try {
				ezJobSysServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	public Map<String, Object> ezJobSysServiceImplCall() {

		logger.info("ezJobSysServiceImplCall START");

		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		commonDao = (CommonDao) CommonUtil.getSpringBean("commonDao");
		emJobLogDao = (EmJobLogDao) CommonUtil.getSpringBean("emJobLogDao");
		commonService = (CommonService) CommonUtil.getSpringBean("commonService");

		// 로그 경로 가져오기.
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";

		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}

		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();

		String rCode 	= "";
		String rMsg 	= "";
		String r_msg 	= "";

		if(QLOCK.tryLock()) {
			try {

				map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

				Map<String, Object> logMap 	= new HashMap<String, Object>();
				Map<String, Object> sysMap 	= new HashMap<String, Object>();


				List dataCenterList = CommonUtil.getDataCenterList();

				//SYSOUT 조회하는 로직 추가
				for(int i=0; i<dataCenterList.size(); i++){
					CommonBean bean = (CommonBean)dataCenterList.get(i);
					String dataCenter = CommonUtil.isNull(bean.getData_center());
					String scode_cd = CommonUtil.isNull(bean.getScode_cd());


					Map<String, Object> hostMap = new HashMap<String, Object>();
					hostMap.put("data_center"	, scode_cd+","+dataCenter);
					hostMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

					String strHost 			= "";
					String strSysout 			= "";
					String dis_yn	 			= "N";

					//1.호스트를 조회한다. >> 각 호스트별로 ssh 통신 예정
					List<CommonBean> hostList = commonDao.dGetHostInfoList(hostMap);

					for( int j=0; null!=hostList && j<hostList.size(); j++ ){
						CommonBean hostList2 			= (CommonBean)hostList.get(j);
						strHost 						= CommonUtil.isNull(hostList2.getNode_id());

						map.put("node_id", strHost);

						List<JobLogBean> jobLogList = emJobLogDao.dGetJobLogInfoList(map);

						if (jobLogList.size() != 0) {

						logger.info("jobLogList.size() ::::: " +jobLogList.size());

							for( int z=0; jobLogList != null && z<jobLogList.size(); z++ ){

								JobLogBean bean2 			= (JobLogBean)jobLogList.get(z);

								//마지막 작업의 경우 ssh 통신 disconnect하기 위한 파라미터
								if(z != jobLogList.size() - 1){
									dis_yn = "N";
								}else{
									dis_yn = "Y";
								}

								logMap.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								logMap.put("node_id",			CommonUtil.isNull(bean2.getNode_id()));
								logMap.put("memname",			CommonUtil.isNull(bean2.getMemname(),"*"));
								logMap.put("order_id",			CommonUtil.isNull(bean2.getOrder_id()));
								logMap.put("rerun_count",		CommonUtil.isNull(bean2.getRerun_counter()));
								logMap.put("appl_type",			CommonUtil.isNull(bean2.getAppl_type()));
								logMap.put("dis_yn",			dis_yn);

								//sysout 조회한다.
								strSysout = CommonUtil.isNull(sysout(logMap));

								//sytSysout 저장하는 로직
								strSysout = strSysout.replace("'", "''");


								sysMap.put("flag",				"sysout");
								sysMap.put("node_id", 			strHost);
								sysMap.put("sysout",			strSysout);
								sysMap.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
								sysMap.put("order_id",			CommonUtil.isNull(bean2.getOrder_id()));
								sysMap.put("rerun_counter",		CommonUtil.isNull(bean2.getRerun_counter()));

								Map<String, Object> rMap2 = new HashMap<String, Object>();
								try {
									rMap2= 	commonDao.dPrcLog(sysMap);

									rCode 	= CommonUtil.isNull(rMap.get("r_code"));
									rMsg 	= CommonUtil.isNull(rMap.get("r_msg"));

								}catch (Exception e) {
									rCode = "-2";
									rMsg = e.getMessage();

									logger.info("EzJobSysServiceImpl dPrcLog Exception========"+e.getMessage());
								}

							}
						}else{
							//sysout 저장할 Job이 없을 경우 끝
							rCode = "1";
							rMsg = "처리완료";

							logger.info("EzJobSysServiceImpl Null==========================");
						}
					}
				}
			} catch(Exception e) {
				TraceLogUtil.TraceLog(e.toString(), strLogPath, "EzJobSysServiceImpl");
				logger.error("[EzJobSysServiceImpl Exception] : " + e);

				rCode = "-2";
				rMsg = e.getMessage();

			} finally {
				QLOCK.unlock();
			}
		}

		if ( rCode.equals("-2") ) {
			r_msg 	= CommonUtil.isNull(rMsg);
		} else {
			r_msg 	= CommonUtil.getMessage(CommonUtil.isNull(rMsg));
			if(r_msg.equals("")){
				r_msg 	= CommonUtil.isNull(rMsg);
			}
		}

		TraceLogUtil.TraceLog("[" + rCode + "] : " + rMsg, strLogPath, "EzJobSysServiceImpl");

		map.put("flag"			, "EZ_QUARTZ_LOG");
		map.put("SCHEMA"		, CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		map.put("quartz_name"	, "EZ_SYS_UDT");
		map.put("trace_log_path", strLogPath);
		map.put("status_cd"		, rCode);
		map.put("status_log"	, r_msg);

		quartzDao.dPrcQuartz(map);

		return rMap;
	}

	// SYSOUT 조회 ssh 통신 > 부산은행
	private String sysout(Map map) throws Exception {

		String data_center 		= CommonUtil.isNull(map.get("data_center"));
		String strNodeId	 		= CommonUtil.isNull(map.get("node_id"));

		String strMemName	 		= CommonUtil.isNull(map.get("memname"));
		String order_id 			= CommonUtil.isNull(map.get("order_id"));
		String rerun_count 		= CommonUtil.isNull(map.get("rerun_count"),"0");
		String appl_type 		= CommonUtil.isNull(map.get("appl_type"));
		String strFileName		= "";
		List sCodeList 			= null;

		//appl_type에 따라 sysout 파일명 변경
		if(appl_type.equals("KBN062023")) {
			strFileName = order_id.toUpperCase() + "_" + rerun_count;
			
		} else if (appl_type.equals("FILE_TRANS")){
			strFileName = order_id.toUpperCase() + "_" + rerun_count;
		} else {
			strFileName	= strMemName + ".LOG_" + "0"+order_id + "_" + String.format("%05d",Integer.parseInt(rerun_count));
		}

		Map<String, Object> hostMap = new HashMap<String, Object>();
		hostMap.put("data_center"	, data_center);
		hostMap.put("host"			, strNodeId);
		hostMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		//kubernetes의 경우 host를 C-M 서버를 잡아줘야하기에 host 및 node_id 변경
		if(appl_type.equals("KBN062023")) {
			hostMap.put("mcode_cd", "M2");

			sCodeList 				= commonService.dGetsCodeList(hostMap);
			CommonBean sCodeBean 	= (CommonBean) sCodeList.get(0);
			String ctmServer 		= CommonUtil.isNull(sCodeBean.getScode_eng_nm());

			hostMap.put("host"			, ctmServer);
			hostMap.put("node_id"		, ctmServer);
		}

		String accessGubun			= "SSH";
		int iPort 					= 22;
		String strHost 				= "";
		String strUserId 			= "";
		String strUserPw 			= "";
		String strRemoteFilePath 	= "";
		String sysout				= "";
		String dis_yn				= CommonUtil.isNull(map.get("dis_yn"));

		CommonBean bean = commonDao.dGetHostInfo(hostMap);

		if ( bean != null ) {
			strHost 			= bean.getNode_id();
			strUserId 			= bean.getAgent_id();
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			strRemoteFilePath   = CommonUtil.isNull(bean.getFile_path());
		}

		//kubernetes의 작업일 경우 sysout 경로를 C-M magager 서버의 공통경로로 설정
		if(appl_type.equals("KBN062023")) {
			hostMap.put("mcode_cd", "M97");
			sCodeList = commonService.dGetsCodeList(hostMap);
			CommonBean sCodeBean = (CommonBean) sCodeList.get(0);
			strRemoteFilePath = CommonUtil.isNull(sCodeBean.getScode_nm()) + "/" + strNodeId + "/sysout";
		}

		String cmd = "tail -1000 "+strRemoteFilePath+"/"+strFileName;

		logger.debug("EzJobSysServiceImpl cmd : ========= " + cmd);

		if(!"".equals(strHost)){
			if( "SSH".equals(accessGubun)){
				Ssh3Util su = new Ssh3Util(strHost, iPort, strUserId, strUserPw, cmd, "EUC-KR", dis_yn);
				sysout = su.getOutput();

				logger.debug("Ssh2Util END === " + sysout);

			}else{
				TelnetUtil tu = new TelnetUtil(strHost,iPort,strUserId,strUserPw,cmd);
				sysout = tu.getOutput();

				logger.debug("TelnetUtil END === " + sysout);
			}
		}else{
			sysout = CommonUtil.getMessage("ERROR.09");
		}

		return sysout;
	}

}
