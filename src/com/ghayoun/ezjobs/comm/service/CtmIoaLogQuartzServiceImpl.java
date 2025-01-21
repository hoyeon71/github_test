package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;

/*
 *  CTM 로그를 가져와 Jobs DB에 넣는다.
 */
public class CtmIoaLogQuartzServiceImpl extends QuartzJobBean{

	private static final Log logger = LogFactory.getLog(CtmIoaLogQuartzServiceImpl.class);
	private static final Lock QLOCK = new ReentrantLock();
	
	private CommonDao commonDao;
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
	@Override
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {
		
		String strServerGubun 	= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
		String strQuartzLogPath = CommonUtil.isNull(CommonUtil.getMessage("QUARTZ_LOG.PATH"));
		
		System.out.println("START");
		
		// 로그 경로 가져오기.
		String strClassName	= this.getClass().getName().split("\\.")[this.getClass().getName().split("\\.").length-1];
		String strLogPath	= CommonUtil.getWebRootPath() + "/" + strQuartzLogPath + strClassName + "/";
		
		// 해당 폴더 없으면 생성.
		if ( !new File(strLogPath).exists() ) {
			new File(strLogPath).mkdirs();
		}
		
		String strCode_001 = "001";
		String strCode_002 = "002";
		String strCode_003 = "003";
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("data_center_code", strCode_001);
		map.put("SCHEMA", 			CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		if ( !strServerGubun.equals("P") ) {
			map.put("CTMSVR_SCHEMA", 	CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
		} else {
			map.put("CTMSVR_SCHEMA", 	CommonUtil.getMessage("DB.CTMSVR1.SCHEMA"));
		}
		
		int result = 0;
		
		// 월별로 파티션 테이블을 생성한다.
		//map.put("DT", CommonUtil.toPrevDate());
		//int dt_result = commonDao.dPrcCtmIoalogPartitionCreate(map);
		
		//TraceLogUtil.TraceLog("[파티션 테이블 생성] : " + dt_result, strLogPath, "CtmIoaLogQuartzService");
		
		result = commonDao.dPrcCtmIoalogInsert(map);
		
		TraceLogUtil.TraceLog("[파티션 테이블 저장] : " + result, strLogPath, "CtmIoaLogQuartzService");
		
		
		if ( strServerGubun.equals("P") ) {			
			
			// 002
			map.put("data_center_code", strCode_002);
			map.put("CTMSVR_SCHEMA", 	CommonUtil.getMessage("DB.CTMSVR2.SCHEMA"));
				
			result = 0;
			
			// 월별로 파티션 테이블을 생성한다.
			//map.put("DT", CommonUtil.toPrevDate());
			//dt_result = commonDao.dPrcCtmIoalogPartitionCreate(map);
			
			//TraceLogUtil.TraceLog("[파티션 테이블 생성] : " + dt_result, strLogPath, "CtmIoaLogQuartzService");
			
			result = commonDao.dPrcCtmIoalogInsert(map);
			
			TraceLogUtil.TraceLog("[파티션 테이블 저장] : " + result, strLogPath, "CtmIoaLogQuartzService");
			
			// 003
			map.put("data_center_code", strCode_003);
			map.put("CTMSVR_SCHEMA", 	CommonUtil.getMessage("DB.CTMSVR3.SCHEMA"));
			
			result = 0;
			
			// 월별로 파티션 테이블을 생성한다.
			//map.put("DT", CommonUtil.toPrevDate());
			//dt_result = commonDao.dPrcCtmIoalogPartitionCreate(map);
			
			//TraceLogUtil.TraceLog("[파티션 테이블 생성] : " + dt_result, strLogPath, "CtmIoaLogQuartzService");
			
			result = commonDao.dPrcCtmIoalogInsert(map);
			
			TraceLogUtil.TraceLog("[파티션 테이블 저장] : " + result, strLogPath, "CtmIoaLogQuartzService");			
		}
		
	}

}
