package com.ghayoun.ezjobs.m.service;

import java.util.List;
import java.util.Map;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.domain.JobOpBean;
import com.ghayoun.ezjobs.m.domain.TotalJobStatus;
import com.ghayoun.ezjobs.m.repository.EmJobLogDao;

public class EmJobLogServiceImpl implements EmJobLogService {
	

	private CommonDao commonDao;
	private EmJobLogDao emJobLogDao;

	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	
    public void setEmJobLogDao(EmJobLogDao emJobLogDao) {
        this.emJobLogDao = emJobLogDao;
    }
	
    public JobLogBean dGetJobLogListCnt(Map map){
    	return emJobLogDao.dGetJobLogListCnt(map);
    }
	public List<JobLogBean> dGetJobLogList(Map map){ return emJobLogDao.dGetJobLogList(map); }

	public JobLogBean dGetJobLogHistoryListCnt(Map map){
    	return emJobLogDao.dGetJobLogHistoryListCnt(map);
    }
	public List<JobLogBean> dGetJobLogHistoryList(Map map){
		return emJobLogDao.dGetJobLogHistoryList(map);
	}
	
    public CommonBean dGetJobOpListCnt(Map map){
    	return emJobLogDao.dGetJobOpListCnt(map);
    }
	public List<JobOpBean> dGetJobOpList(Map map){
		return emJobLogDao.dGetJobOpList(map);
	}
	public List<TotalJobStatus> dGetJobOpListReport(Map map){
		return emJobLogDao.dGetJobOpListReport(map);
	}
	public List<JobLogBean> dGetJobOpReportList(Map map){
		return emJobLogDao.dGetJobOpReportList(map);
	}
	
	public CommonBean dGetHistoryDayCnt(Map map){
    	return emJobLogDao.dGetHistoryDayCnt(map);
    }
	
	public CommonBean dGetTimeOverJobLogListCnt(Map map){
    	return emJobLogDao.dGetTimeOverJobLogListCnt(map);
    }
	public List<JobLogBean> dGetTimeOverJobLogList(Map map){
		return emJobLogDao.dGetTimeOverJobLogList(map);
	}
		
	public CommonBean dGetJobGroupListCnt(Map map){
    	return emJobLogDao.dGetJobGroupListCnt(map);
    }
	public List<JobLogBean> dGetJobGroupList(Map map){
		return emJobLogDao.dGetJobGroupList(map);
	}
	
	public List<JobLogBean> dGetJobGroupInfoList(Map map){
		return emJobLogDao.dGetJobGroupInfoList(map);
	}
	
	public List<JobLogBean> dGetJobOpStatsReportList(Map map){
		return emJobLogDao.dGetJobOpStatsReportList(map);
	}
	
	public JobLogBean dGetJobOpReportInfo(Map map){ return emJobLogDao.dGetJobOpReportInfo(map); }

	public JobLogBean dGetJobSysout(Map map){ return emJobLogDao.dGetJobSysout(map); }
}