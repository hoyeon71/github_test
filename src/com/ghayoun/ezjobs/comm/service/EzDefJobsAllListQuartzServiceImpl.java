package com.ghayoun.ezjobs.comm.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.FileUtil;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.repository.EmDefJobsDao;
import com.ghayoun.ezjobs.m.service.EmDefJobsService;

public class EzDefJobsAllListQuartzServiceImpl extends QuartzJobBean{

	private static final Log logger = LogFactory.getLog(CtmIoaLogQuartzServiceImpl.class);
	private static final Lock QLOCK = new ReentrantLock();
	
	private EmDefJobsDao emDefJobsDao;
	public void setEmDefJobsDao(EmDefJobsDao emDefJobsDao) {
		this.emDefJobsDao = emDefJobsDao;
	}
	private CommonDao commonDao;
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
	@Override
	protected void executeInternal(JobExecutionContext arg0) throws JobExecutionException {
		
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
		
		logger.info("#EzDefJobsAllListQuartzServiceImpl | Start~~~");
		

		if(QLOCK.tryLock()){
			try{
				
				Map<String, Object> paramMap = new HashMap<>();
				paramMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				paramMap.put("user_gb", "01");
				paramMap.put("admin", "N");
				paramMap.put("mcode_cd", CommonUtil.getMessage("COMCODE.APPGRP.CODE"));
				
				String scode_cd 	= "";
				String scode_eng_nm	= "";
				String data_center 	= "";
				
				List<CommonBean> datacenterList = commonDao.dGetScodeList(paramMap);
				for(int i=0;i<datacenterList.size();i++){
					CommonBean bean = datacenterList.get(i);
					
					scode_cd 		= CommonUtil.isNull(bean.getScode_cd());
					scode_eng_nm 	= CommonUtil.isNull(bean.getScode_eng_nm());
					
					data_center		= scode_cd + "," + scode_eng_nm;
					
					paramMap.put("data_center", data_center);
					
					Date dt = new Date();
					SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
					String ymd = sf.format(dt);
					
					String file_nm = "activejoblist_"+data_center+"_"+ymd+".txt";
					String file_path = CommonUtil.getWebRootPath()+"/"+CommonUtil.getMessage("MENUAL_FILE.PATH")+"joblist";
					
					logger.info("#EzDefJobsAllListQuartzServiceImpl | file_nm :::"+file_nm);
					logger.info("#EzDefJobsAllListQuartzServiceImpl | file_path :::"+file_path);
					
					File file = new File(file_path);
					if(!file.exists()){
						file.mkdirs();
					}
					
					List<DefJobBean> defJobList = emDefJobsDao.dGetDefJobExcelList(paramMap);
					
					String full_path = file_path+"/"+file_nm;
					
					logger.info("#EzDefJobsAllListQuartzServiceImpl | Write Start");
					
					FileUtil.defJobListWrite(full_path, defJobList);
				
					logger.info("#EzDefJobsAllListQuartzServiceImpl | Write End");					
				}
				
			}catch(Exception e){
				logger.info("#EzDefJobsAllListQuartzServiceImpl | Error :::"+e.getMessage());
				e.printStackTrace();
			}finally{
				QLOCK.unlock();
			}
		
		}	
	
		logger.info("#EzDefJobsAllListQuartzServiceImpl | End~~~");
		
	}
	
}
