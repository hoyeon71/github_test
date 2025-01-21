package com.ghayoun.ezjobs.comm.service;

import java.io.File;
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
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;

public class EzAvgInfoDelJobServiceImpl extends QuartzJobBean{
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	private QuartzDao quartzDao;
	
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		
		String strServerGb = CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		
		// 로그 경로 가져오기.
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
	
		Map<String, Object> map 	= new HashMap<String, Object>();
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		
		try {			
			map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			List defJobList = quartzDao.defJobList(map);
			
			if(defJobList != null){
				for(int i=0; i<defJobList.size(); i++){
					JobDefineInfoBean bean = (JobDefineInfoBean) defJobList.get(i);
					String strJobName = CommonUtil.isNull(bean.getJob_name());
					
					map.put("flag", "EZ_AVG_DEL");
					map.put("job_name", strJobName);
					
					rMap = quartzDao.dPrcQuartz(map);
					
					TraceLogUtil.TraceLog("DELETE 대상 작업명 : " + strJobName, strLogPath, strClassName);
				}
			}
			
		} catch (Exception e) {
			TraceLogUtil.TraceLog(e.toString(), strLogPath, strClassName);
			logger.error("[" + strClassName+ "Exception] : " + e);
		}
	}
}
