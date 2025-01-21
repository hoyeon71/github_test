package com.ghayoun.ezjobs.comm.service;						
						
import java.util.HashMap;						
import java.util.List;						
import java.util.Map;						
						
import org.apache.commons.logging.Log;						
import org.apache.commons.logging.LogFactory;						
import org.quartz.JobExecutionContext;						
import org.quartz.JobExecutionException;						
import org.springframework.scheduling.quartz.QuartzJobBean;						
						
import com.bmc.ctmem.schema900.ResponseUserRegistrationType;						
import com.ghayoun.ezjobs.comm.repository.QuartzDao;						
import com.ghayoun.ezjobs.common.axis.ConnectionManager;						
import com.ghayoun.ezjobs.common.util.CommonUtil;						
import com.ghayoun.ezjobs.t.axis.T_Manager5;						
import com.ghayoun.ezjobs.t.domain.Doc06Bean;						
						
public class EzTableUploadServiceImpl extends QuartzJobBean{						
						
	private static final Log logger = LogFactory.getLog(CtmIoaLogQuartzServiceImpl.class);					
						
	private QuartzDao quartzDao;					
						
	public void setQuartzDao(QuartzDao quartzDao) {					
        this.quartzDao = quartzDao;						
    }						
						
	@SuppressWarnings("unchecked")					
	@Override					
	protected void executeInternal(JobExecutionContext jobExecutionContext) throws JobExecutionException {					
						
		Map<String, Object> map = new HashMap<String, Object>();				
		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));				
						
		logger.info("#EzTableUploadServiceImpl | Start~~~");				
						
		Map<String, Object> rMap = new HashMap<>();				
		Map<String, Object> rTokenMap 	= new HashMap<String, Object>();			
						
		try{				
						
			// Data Center + Table name(application+from_time) 테이블별로 처리			
			List<Doc06Bean> dt_list = quartzDao.dGetTableUploadList(map);			
			if(dt_list.size() > 0){			
						
				ConnectionManager cm = new ConnectionManager();		
				rTokenMap = cm.login(map);		
						
				String rLoginCode = CommonUtil.isNull(rTokenMap.get("rCode"));		
				String rToken = "";		
						
				if("1".equals(rLoginCode)){		
					ResponseUserRegistrationType t = (ResponseUserRegistrationType)rTokenMap.get("rObject");	
					rToken = t.getUserToken();	
						
					map.put("userToken",CommonUtil.isNull(rToken));	
				}		
						
				logger.info("#EzTableUploadServiceImpl | userToken ::"+CommonUtil.isNull(rToken));		
						
				T_Manager5 t = new T_Manager5();
						
				for(int h=0;h<dt_list.size();h++){		
					Doc06Bean dt_bean = dt_list.get(h);	
						
					//그룹별로 처리 대상 데이터를 읽어 온다.	
					map.put("data_center", 	dt_bean.getData_center());
					map.put("table_name", 	dt_bean.getTable_name());
						
					// 실제 업로드 수행	
					t.defUploadjobs(map);	
				}		
			}			
						
		}catch(Exception e){				
			logger.info("#EzExcelBatchQuartzServiceImpl | Error :::"+e.getMessage());			
		}finally{				
		}				
						
		logger.info("#EzExcelBatchQuartzServiceImpl | End~~~");				
						
	}					
}						
