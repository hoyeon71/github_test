package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;

public class EzLogDeleteJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		Map chkHostMap = CommonUtil.checkHost();
		
		String strHost 		= CommonUtil.isNull(chkHostMap.get("scode_host"));
		String strHostName 	= CommonUtil.isNull(chkHostMap.get("server_host"));
		Boolean chkHost 	= (Boolean) chkHostMap.get("chkHost");
		
		//logger.debug("OS 호스트명 : " + strHostName);
		//logger.debug("코드관리 호스트명 : " + strHost);
		//logger.debug("호스트 체크 결과 : " + chkHost);
		
		// 로그 삭제는 1번, 2번 서버 모두 진행해야 하기 때문에 Host 체크 예외처리 (2023.10.18 강명준)
		//if(chkHost) {
			try {
				ezLogDeleteJobServiceImplCall();
			} catch (Exception e) {
				e.printStackTrace();
			}
		//}
	}
	
	public Map<String, Object> ezLogDeleteJobServiceImplCall() {
		
		logger.info("EzLogDeleteJobServiceImpl START");
		
		quartzDao = (QuartzDao) CommonUtil.getSpringBean("quartzDao");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		
		String strQuartzLogPath 	= CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		String strLog4jLogPath		= CommonUtil.isNull(CommonUtil.getMessage("LOG4J.LOG.PATH"));
		String strLog4jLogDelCnt	= CommonUtil.isNull(CommonUtil.getMessage("LOG4J.LOG.DEL.CNT"));
		
		// 로그 경로 가져오기.
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		logger.info("strLogPath : " + strLogPath);
		logger.info("strLog4jLogPath : " + strLog4jLogPath);
		logger.info("strLog4jLogDelCnt : " + strLog4jLogDelCnt);
		TraceLogUtil.TraceLog("EzLogDeleteJobServiceImpl START", strLogPath, strClassName);
		TraceLogUtil.TraceLog("strLogPath : " + strLogPath, strLogPath, strClassName);
		TraceLogUtil.TraceLog("strLog4jLogPath : " + strLog4jLogPath, strLogPath, strClassName);
		TraceLogUtil.TraceLog("strLog4jLogDelCnt : " + strLog4jLogDelCnt, strLogPath, strClassName);
				
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
	
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		try {
		
			Calendar fileCal 	= Calendar.getInstance();
			Date fileDate		= null;
			
			Calendar nowCal 	= Calendar.getInstance();
			long todayTimeMil	= nowCal.getTimeInMillis();
			
			long oneDayMil 		= 24 * 60 * 60 * 1000;
			
			// 콤마로 설정하면 여러 경로의 파일을 삭제 가능하게 개선 (2023.10.18 강명준)
			String arrLog4jLogPath[] = CommonUtil.isNull(strLog4jLogPath).split(",");
			String strRealLog4jLogPath = "";
			
			for ( int j = 0; j < arrLog4jLogPath.length; j++ ) {
				
				strRealLog4jLogPath = CommonUtil.isNull(arrLog4jLogPath[j]);
				
				logger.info("file path => " + strRealLog4jLogPath);
				TraceLogUtil.TraceLog("file path => " + strRealLog4jLogPath, strLogPath, strClassName);
			
				File path = new File(strRealLog4jLogPath);
				File[] list = path.listFiles();	// 파일 리스트 가져오기
		
				if ( list != null ) {
					
					for ( int i = 0; i < list.length; i++ ) {
						
						if ( list[i].isFile() ) {
							
							// 파일의 마지막 수정시간 가져오기
							fileDate	= new Date(list[i].lastModified());
							fileCal.setTime(fileDate);					
							long fileTimeMil = fileCal.getTimeInMillis();
							
							// 파일 시간 차이 계산 후 일 수로 치환
							long diffTimeMil 	= todayTimeMil - fileTimeMil;
							int diffDayCnt 		= (int) (diffTimeMil / oneDayMil);
							
							// 설정 파일의 로그 파일 보관 주기와 비교 후 파일 삭제
							if ( Integer.parseInt(strLog4jLogDelCnt) <= diffDayCnt ) {
							    list[i].delete();
								logger.info("file delete => " + list[i].getName());
								TraceLogUtil.TraceLog("file delete => " + list[i].getName(), strLogPath, strClassName);
							}
						}
					}
					
				} else {
					logger.info("file is null");
					TraceLogUtil.TraceLog("file is null", strLogPath, strClassName);
				}
			}
			
			map.put("status_cd"		, "1");
			map.put("status_log"	, CommonUtil.getMessage("DEBUG.01"));
			
		} catch (Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			e.printStackTrace();
			
			map.put("status_cd"		, "-1");
			map.put("status_log"	, e.toString());
		} 
		
		map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		map.put("flag"			, "EZ_QUARTZ_LOG");
		map.put("quartz_name"	, "EZ_LOG_DEL");
		map.put("trace_log_path", strLogPath);
		
		quartzDao.dPrcQuartz(map);
		
		logger.info("EzLogDeleteJobServiceImpl END");
		TraceLogUtil.TraceLog("EzLogDeleteJobServiceImpl END", strLogPath, strClassName);
		
		return rMap;
	}
}
