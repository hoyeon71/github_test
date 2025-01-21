package com.ghayoun.ezjobs.comm.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.util.SystemOutLogger;
import org.omg.CORBA.exception_type;
import org.omg.PortableInterceptor.SYSTEM_EXCEPTION;
import org.springframework.web.multipart.MultipartFile;
import com.ghayoun.ezjobs.a.service.EmAlertService;
import com.ghayoun.ezjobs.comm.domain.AppGrpBean;
import com.ghayoun.ezjobs.comm.domain.BoardBean;
import com.ghayoun.ezjobs.comm.domain.CalCodeBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.domain.DgbFwaBean;
import com.ghayoun.ezjobs.comm.domain.HolidayBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DbUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.ExcelUtil;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.SendIfCheck;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.TraceLogUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.repository.CtmInfoDao;
import com.ghayoun.ezjobs.m.service.CtmInfoService;
import com.ghayoun.ezjobs.m.service.EmBatchResultTotalService;
import com.ghayoun.ezjobs.m.service.EmCtmInfoService;
import com.ghayoun.ezjobs.m.service.EmDefJobsService;
import com.ghayoun.ezjobs.m.service.EmJobLogService;
import com.ghayoun.ezjobs.m.service.EmPreDateBatchScheduleService;
import com.ghayoun.ezjobs.m.service.EmPreJobMissMatchService;
import com.ghayoun.ezjobs.m.service.PopupTimeInfoService;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.ApprovalLineBean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.repository.EmJobOrderDao;
import com.ghayoun.ezjobs.t.service.PopupDefJobService;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksApprovalLineService;
import com.ghayoun.ezjobs.t.service.WorksCompanyService;
import com.ghayoun.ezjobs.t.service.WorksUserService;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class CommonServiceImpl implements CommonService {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
    private CommonDao commonDao;

    public void setCommonDao(CommonDao commonDao) {   
        this.commonDao = commonDao;   
    }
    private CtmInfoDao ctmInfoDao;
    
    public void setCtmInfoDao(CtmInfoDao ctmInfoDao) {   
    	this.ctmInfoDao = ctmInfoDao;   
    }
    
	public List<CommonBean> getCategoryList(Map map, String type){
		return commonDao.getCategoryList(map, type);
	}
	
	public List<CommonBean> dGetSearchItemList(Map map){
		return commonDao.dGetSearchItemList(map);
	}
	
	public CommonBean dGetCalendarDetail(Map map){
		return commonDao.dGetCalendarDetail(map);
	}
	
	public List<CommonBean> dGetCalendarYearList(Map map){
		return commonDao.dGetCalendarYearList(map);
	}
	
	public Map emLogin(Map map){
		return commonDao.emLogin(map);
	}
	
	public List<CommonBean> dGetResourceList(Map map){
		return ctmInfoDao.dGetResourceList(map);
	}
	
	public List<CommonBean> dGetAlarmInfo(Map map){
		return commonDao.dGetAlarmInfo(map);
	}
	
	public List<CommonBean> dGetsCodeList(Map map){
		return commonDao.dGetsCodeList(map);
	}
	
	public CommonBean dGetHostInfo(Map map){
		return commonDao.dGetHostInfo(map);
	}
	
	public CommonBean dGetServerInfo(Map map){
		return commonDao.dGetServerInfo(map);
	}
	
	public CommonBean dGetSearchHostInfo(Map map){
		return commonDao.dGetSearchHostInfo(map);
	}
	
	public List<CommonBean> dGetUsedJobList(Map map){
		return ctmInfoDao.dGetUsedJobList(map);
	}
	
	//procedure
	public Map dPrcHost(Map map) throws Exception{
		
		String strFlag = CommonUtil.isNull(map.get("flag"));
		
		Map rMap = null;
		
		//호스트이관
		if (strFlag.equals("host_takeOver")) {
			map.put("data_center", 	CommonUtil.isNull(map.get("job_data_center")));
			String[] hostname_arr 		= CommonUtil.isNull(map.get("hostname_arr")).split(",");
			String[] description_arr 	= CommonUtil.isNull(map.get("description_arr")).split(",");
			String[] server_gubun_arr 	= CommonUtil.isNull(map.get("server_gubun_arr")).split(",");
			String[] agent_id_arr 		= CommonUtil.isNull(map.get("agent_id_arr")).split(",");
			String[] agent_pw_arr 		= CommonUtil.isNull(map.get("agent_pw_arr")).split(",");
			String[] access_gubun_arr 	= CommonUtil.isNull(map.get("access_gubun_arr")).split(",");
			String[] access_port_arr 	= CommonUtil.isNull(map.get("access_port_arr")).split(",");
			String[] file_path_arr 		= CommonUtil.isNull(map.get("file_path_arr")).split(",");
			String[] server_lang_arr 	= CommonUtil.isNull(map.get("server_lang_arr")).split(",");
			String[] certify_gubun_arr 	= CommonUtil.isNull(map.get("certify_gubun_arr")).split(",");
			
			for (int i = 0; i < hostname_arr.length; i++) {
				map.put("agent", hostname_arr[i]);
				map.put("agent_nm", description_arr[i]);
				map.put("agent_id", agent_id_arr[i]);
				map.put("agent_pw", SeedUtil.encodeStr(agent_pw_arr[i]));
				map.put("file_path", file_path_arr[i]);
				map.put("access_gubun", access_gubun_arr[i]);
				map.put("access_port", access_port_arr[i]);
				map.put("server_gubun", server_gubun_arr[i]);
				map.put("server_lang", server_lang_arr[i]);
				map.put("certify_gubun", certify_gubun_arr[i]);
				
				rMap = commonDao.dPrcHost(map);
				
			}
		//계정이관
		}else if (strFlag.equals("owner_takeOver")) {
			map.put("data_center", 	CommonUtil.isNull(map.get("job_data_center")));
			
			String[] owner_arr 		= CommonUtil.isNull(map.get("owner_arr")).split(",");
			String[] host_cd_arr 	= CommonUtil.isNull(map.get("host_cd_arr")).split(",");
			
			for (int i = 0; i < owner_arr.length; i++) {
				map.put("owner", owner_arr[i]);
				map.put("host_cd", host_cd_arr[i]);
				rMap = commonDao.dPrcHost(map);
			}
		}else {
			rMap = commonDao.dPrcHost(map);
		}
		return rMap;
	}
	
	//procedure
		public Map dPrcDatabase(Map map) throws Exception{
			
			String strFlag = CommonUtil.isNull(map.get("flag"));
			
			Map rMap = null;
			
			// DB이관
			if (strFlag.equals("database_takeOver")) {
				map.put("data_center", 	CommonUtil.isNull(map.get("job_data_center")));
				
				String[] profile_name_arr 		= CommonUtil.isNull(map.get("profile_name_arr")).split(",", -1);
				String[] database_type_arr 		= CommonUtil.isNull(map.get("database_type_arr")).split(",", -1);
				String[] database_version_arr 	= CommonUtil.isNull(map.get("database_version_arr")).split(",", -1);
				String[] type_arr 				= CommonUtil.isNull(map.get("type_arr")).split(",", -1);
				String[] user_arr 				= CommonUtil.isNull(map.get("user_arr")).split(",", -1);
				String[] port_arr 				= CommonUtil.isNull(map.get("port_arr")).split(",", -1);
				String[] sid_arr 				= CommonUtil.isNull(map.get("sid_arr")).split(",", -1);
				String[] service_name_arr 		= CommonUtil.isNull(map.get("service_name_arr")).split(",", -1);
				String[] database_name_arr 		= CommonUtil.isNull(map.get("database_name_arr")).split(",", -1);
				String[] host_arr 				= CommonUtil.isNull(map.get("host_arr")).split(",", -1);
				String[] target_ctm_arr 		= CommonUtil.isNull(map.get("target_ctm_arr")).split("[|]", -1);
				String[] target_agent_arr 		= CommonUtil.isNull(map.get("target_agent_arr")).split(",", -1);
				
				for (int i = 0; i < profile_name_arr.length; i++) {
					map.put("profile_name", profile_name_arr[i]);
					map.put("database_type", database_type_arr[i]);
					map.put("database_version", database_version_arr[i]);
					map.put("type", type_arr[i]);
					map.put("user_nm", user_arr[i]);
					map.put("sid", sid_arr[i]);
					map.put("service_name", service_name_arr[i]);
					map.put("database_name", database_name_arr[i]);
					map.put("host", host_arr[i]);
					map.put("data_center", target_ctm_arr[i]);
					map.put("target_agent", target_agent_arr[i]);
					// 포트가 없을경우 DB 기본 포트 저장
					if(port_arr[i].equals("")) {
						String postgre_port = "5432";
						String oracle_port = "1521";
						
						if(database_type_arr[i].equals("PostgreSQL")) {
							port_arr[i] = postgre_port;
						}else if(database_type_arr[i].equals("Oracle")){
							port_arr[i] = oracle_port;
						}
					}
					map.put("port", port_arr[i]);
					
					rMap = commonDao.dPrcDatabase(map);
					
				}
			}else {
				rMap = commonDao.dPrcDatabase(map);
			}
			return rMap;
		}
	
	//dgb--------------------------------------
	public CommonBean dGetDgbFwaShListCnt(Map map){
    	return commonDao.dGetDgbFwaShListCnt(map);
    }
	public List<DgbFwaBean> dGetDgbFwaShList(Map map){
		return commonDao.dGetDgbFwaShList(map);
	}
	
	public CommonBean dGetDgbFwaListCnt(Map map){
    	return commonDao.dGetDgbFwaListCnt(map);
    }
	public List<DgbFwaBean> dGetDgbFwaList(Map map){
		return commonDao.dGetDgbFwaList(map);
	}
	
	public DgbFwaBean dGetDgbJobInfo(Map map){
    	return commonDao.dGetDgbJobInfo(map);
    }
	
	public DgbFwaBean dGetDgbShellInfo(Map map){
    	return commonDao.dGetDgbShellInfo(map);
    }
	
	public CommonBean dGetDgbDefJobListCnt(Map map){
    	return commonDao.dGetDgbDefJobListCnt(map);
    }
	public List<DgbFwaBean> dGetDgbDefJobList(Map map){
		return commonDao.dGetDgbDefJobList(map);
	}
	public CommonBean dGetDgbDocJobListCnt(Map map){
    	return commonDao.dGetDgbDocJobListCnt(map);
    }
	public List<DgbFwaBean> dGetDgbDocJobList(Map map){
		return commonDao.dGetDgbDocJobList(map);
	}
	
	public CommonBean dGetDgbHostInfo(Map map){
    	return commonDao.dGetDgbHostInfo(map);
    }
	
	public CommonBean dGetDefJobCnt(Map map){
		return commonDao.dGetDefJobCnt(map);
	}
	
	public CommonBean dGetSearchItemValue(Map map){
        return commonDao.dGetSearchItemValue(map);
    }
	
	public Map dPrcLog(Map map) throws Exception{
		return commonDao.dPrcLog(map);
	}

	public List<CommonBean> dGetJobNameList(Map map){
        return commonDao.dGetJobNameList(map);
    }
	
	public List<CommonBean> dGetQuartzList(Map map){
		return commonDao.dGetQuartzList(map);
	}
	
	//작업 이력조회 팝업창
	public List<CommonBean> dGetJobHistoryInfo(Map map){
		return commonDao.dGetJobHistoryInfo(map);
	}

	//setvar table 조회
	public List<CommonBean> dGetSetvarList(Map map){
		return commonDao.dGetSetvarList(map);
	}
	
	@Override
	public List<BoardBean> dGetBoardList(Map<String, Object> map) {
		
		return commonDao.dGetBoardList(map);
	}
	
	@Override
	public List<BoardBean> dGetBoardInfo(Map<String, Object> map) {
		List<BoardBean> boardList = commonDao.dGetBoardInfo(map);
		for (BoardBean board : boardList) {
			board.setTitle(CommonUtil.replaceStrHtml(board.getTitle()));
			board.setContent(CommonUtil.replaceStrHtml(board.getContent()));
		}
		return boardList;
	}
	
	@Override
	public Map<String, Object> dPrcBoard(Map<String, Object> map, HttpServletRequest req, BoardBean board) throws Exception {
		
		String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH"))+"/board_file";
		
		logger.info("#CommonServiceImpl|dPrcBoard|file_path:"+file_path);
		
		Date dt = new Date();
		SimpleDateFormat sf = new SimpleDateFormat("yyyyMMddHHmm");
		String ymdh = sf.format(dt);
		String sp_file_nm = "";
		Map<String, Object> rMap = new HashMap<>();
		
		try{						
			
			String flag = CommonUtil.isNull(map.get("flag"));
			
			File f = new File(file_path);
			if(!f.exists()){
				f.mkdir();
			}
			
			if(flag.equals("ins")){
				List<MultipartFile> attach = board.getFiles();
				for(MultipartFile multifile : attach){
					if(multifile.isEmpty() == false){
						String ori_file_nm = multifile.getOriginalFilename();
										
						//파일명 변경
						if(ori_file_nm.lastIndexOf(".") > -1){
							sp_file_nm = ori_file_nm.substring(0,ori_file_nm.lastIndexOf("."))+"_"+ymdh+ori_file_nm.substring(ori_file_nm.lastIndexOf("."),ori_file_nm.length());
						}else{
							sp_file_nm = ori_file_nm+"_"+ymdh;
						}
						
						logger.info("#CommonServiceImpl | dPrcBoard | file_name :"+sp_file_nm);
						
						multifile.transferTo(new File(file_path, sp_file_nm));				
						
					}
				}
				
				map.put("file_nm", sp_file_nm);
				
				int rtn = 0;
				int board_cd = commonDao.dGetBoardCd(map);
				map.put("board_cd", board_cd);
							
				rtn = commonDao.dPrcBoardInsert(map);
				if(rtn > 0){
					rMap.put("r_code", "1");
					rMap.put("r_msg", "DEBUG.01");
				}else{
					rMap.put("r_code", "-1");
					rMap.put("r_msg", "ERROR.01");
				}
			}else if(flag.equals("udt")){
				
				String file_nm = "";
				String file_tmp = "";
				List<BoardBean> bean = commonDao.dGetBoardInfo(map);	
				file_nm = CommonUtil.isNull(bean.get(0).getFile_nm());
				file_tmp = CommonUtil.isNull(map.get("file_nm"));
				sp_file_nm = file_tmp;
								
				List<MultipartFile> attach = board.getFiles();
				for(MultipartFile multifile : attach){
					if(multifile.isEmpty() == false){
						String ori_file_nm = multifile.getOriginalFilename();
										
						//파일명 변경
						if(ori_file_nm.lastIndexOf(".") > -1){
							sp_file_nm = ori_file_nm.substring(0,ori_file_nm.lastIndexOf("."))+"_"+ymdh+ori_file_nm.substring(ori_file_nm.lastIndexOf("."),ori_file_nm.length());
						}else{
							sp_file_nm = ori_file_nm+"_"+ymdh;
						}
						
						logger.info("#CommonServiceImpl | dPrcBoard | file_name :"+sp_file_nm);
						
						multifile.transferTo(new File(file_path, sp_file_nm));				
						
					}
				}
				
				map.put("file_nm", sp_file_nm);
				
				int rtn = 0;		
				rtn = commonDao.dPrcBoardUpdate(map);
				
				if(rtn > 0){
					
					if(!file_nm.equals("") && !file_tmp.equals(file_nm)){
						File file = new File(file_path+"/"+file_nm);
						file.delete();
					}
					
					if(!file_nm.equals("")){
						File file = new File(file_path+"/"+CommonUtil.isNull(map.get("del_file")));
						file.delete();						
					}
					
					rMap.put("r_code", "1");
					rMap.put("r_msg", "DEBUG.01");
				}else{
					rMap.put("r_code", "-1");
					rMap.put("r_msg", "ERROR.01");
				}
				
			}else if(flag.equals("del")){
			
				String board_cd = CommonUtil.isNull(map.get("board_cd"));
				
				try{
					
					StringTokenizer st = new StringTokenizer(board_cd, "[|]");
					while(st.hasMoreTokens()){
						
						map.put("board_cd", st.nextToken());
						List<BoardBean> bean = commonDao.dGetBoardInfo(map);
						String file_nm =  CommonUtil.isNull(bean.get(0).getFile_nm());
						
						commonDao.dPrcBoardDelete(map);
						
						if(!file_nm.equals("")){
							try{
								File file = new File(file_path+"/"+file_nm);
								file.delete();
							}catch(Exception e){
								e.getMessage();
							}
						}
					}
					
					rMap.put("r_code", "1");
					rMap.put("r_msg", "DEBUG.01");
					
				}catch(Exception e){
					rMap.put("r_code", "-1");
					rMap.put("r_msg", "ERROR.01");
				}				
								
			}			
			
		}catch(Exception e){
			rMap.put("r_code", "-1");
			rMap.put("r_msg", "ERROR.01");
			e.getMessage();
		}
		
		return rMap;
	}	
	
	@Override
	public CommonBean dGetBoardListCnt(Map<String, Object> map) {
		
		return commonDao.dGetBoardListCnt(map);
	}
	
	@Override
	public List<BoardBean> dGetBoardNoti(Map<String, Object> map) {
		
		return commonDao.dGetBoardNoti(map);
	}
		
	@Override
	public List<HolidayBean> dGetHolidayList(Map<String, Object> map) {
		
		return commonDao.dGetHolidayList(map);
	}
	
	@Override
	public CommonBean dGetHolidayListCnt(Map<String, Object> map) {
		
		return commonDao.dGetHolidayListCnt(map);
	}
	
	@Override
	public Map<String, Object> dPrcHoliday(Map<String, Object> map, HttpServletRequest req) throws Exception {
		
		Map<String, Object> rMap = new HashMap<>();
		
		try{	
			
			rMap = commonDao.dPrcHoliday(map);	
			//rMap.put("r_msg", "DEBUG.03");
			
		}catch(Exception e){
			rMap.put("r_code", "-1");
			rMap.put("r_msg", "DEBUG.08");
			e.getMessage();
		}
		
		return rMap;
	}
	
	@Override
	public List<HolidayBean> dGetHolidayDayList(Map<String, Object> map) {
		
		return commonDao.dGetHolidayDayList(map);
	}
	
	@Override
	public List<CommonBean> dGetScodeList(Map<String, Object> map) {
		
		return commonDao.dGetScodeList(map);
	}
	
	@Override
	public List<CommonBean> dGetWorkGroupItemList(Map<String, Object> map) {
		
		return commonDao.dGetWorkGroupItemList(map);
	}
	
	@Override
	public List<AppGrpBean> dGetAppGrpCodeList(Map<String, Object> map) {
		
		return commonDao.dGetAppGrpCodeList(map);
	}
	
	@Override
	public List<AppGrpBean> dGetAppGrpCodeList2(Map<String, Object> map) {
		
		return commonDao.dGetAppGrpCodeList2(map);
	}
	
	@Override
	public List<AppGrpBean> dGetSearchAppGrpCodeList(Map<String, Object> map) {
		
		return commonDao.dGetSearchAppGrpCodeList(map); 
	}
	
	@Override
	public List dGetErrorLogTotalCnt(Map map) {
		return commonDao.dGetErrorLogTotalCnt(map);
	}
	
	@Override
	public CommonBean dGetSmartTableChk(Map map) {
		return commonDao.dGetSmartTableChk(map);
	}
	
	@Override
	public List<AppGrpBean> dGetSubTableList(Map<String, Object> map) {
		
		return commonDao.dGetSubTableList(map);
	}
	@Override
	public List<CommonBean> dGetSmartTreeList(Map<String, Object> map) {
		return commonDao.dGetSmartTreeList(map);
	}
	@Override
	public List<CommonBean> dGetSmartTreeInfoList(Map<String, Object> map) {
		return commonDao.dGetSmartTreeInfoList(map);
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked", "deprecation" })
	public List dGetItemList(Map map, HttpServletRequest req) throws Exception {
		
		List l = new ArrayList();
    	String itemGb = CommonUtil.isNull(map.get("itemGb"));
    	
    	try{
    		
    		EmDefJobsService emDefJobsService = (EmDefJobsService)CommonUtil.getSpringBean("mEmDefJobsService");
    		CommonService commonService = (CommonService)CommonUtil.getSpringBean("commonService");
    		EmPreJobMissMatchService emPreJobMissMatchService = (EmPreJobMissMatchService)CommonUtil.getSpringBean("mEmPreJobMissMatchService");
    		EmPreDateBatchScheduleService emPreDateBatchScheduleService = (EmPreDateBatchScheduleService)CommonUtil.getSpringBean("mEmPreDateBatchScheduleService");
    		EmJobLogService emJobLogService = (EmJobLogService)CommonUtil.getSpringBean("mEmJobLogService");
    		WorksApprovalDocService worksApprovalDocService = (WorksApprovalDocService)CommonUtil.getSpringBean("tWorksApprovalDocService");
    		CtmInfoService ctmInfoService = (CtmInfoService)CommonUtil.getSpringBean("mCtmInfoService");
    		WorksUserService worksUserService = (WorksUserService)CommonUtil.getSpringBean("tWorksUserService");
    		WorksCompanyService worksCompanyService = (WorksCompanyService)CommonUtil.getSpringBean("tWorksCompanyService");
    		EmAlertService emAlertService = (EmAlertService)CommonUtil.getSpringBean("aEmAlertService");
    		EmBatchResultTotalService emBatchResultTotalService = (EmBatchResultTotalService)CommonUtil.getSpringBean("mEmBatchResultTotalService");
    		WorksApprovalLineService worksApprovalLineService = (WorksApprovalLineService)CommonUtil.getSpringBean("tWorksApprovalLineService");
    		PopupDefJobService popupDefJobService = (PopupDefJobService)CommonUtil.getSpringBean("tPopupDefJobService");
    		PopupTimeInfoService popupTimeInfoService = (PopupTimeInfoService)CommonUtil.getSpringBean("mPopupTimeInfoService");
    		EmCtmInfoService emCtmInfoService = (EmCtmInfoService)CommonUtil.getSpringBean("mEmCtmInfoService");
    		
    		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
    		map.put("user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    		
    		if(itemGb.equals("emDefJobs")){					//배치등록정보
    			l = emDefJobsService.dGetDefJobList(map);
    		}else if(itemGb.equals("searchItemList")){		//검색항목
    			l = commonService.dGetSearchItemList(map);
    		}else if(itemGb.equals("preJobMissMatch")){		//선행작업불일치
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			
    			String active_net_names = "";
    			for(int i=0; i<dataCenterList.size(); i++){
    				CommonBean bean = dataCenterList.get(i);
    				if( "".equals(active_net_names) ) active_net_names = bean.getActive_net_name();
    				else active_net_names += (","+bean.getActive_net_name());
    			}
    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			map.put("active_net_names",active_net_names.split(",") );
    			
    			l = emPreJobMissMatchService.dGetPreJobMissMatchList(map);
    		}else if(itemGb.equals("preDateBatchScheduleList")){
    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			l = emPreDateBatchScheduleService.dGetPreDateBatchScheduleList(map);
    		}else if(itemGb.equals("preDateBatchScheduleOrder2")){
    			l = emPreDateBatchScheduleService.dGetPreDateBatchScheduleOrderList(map);
    			
    		} else if(itemGb.equals("jobLogList")) {			//과거수행현황
    			
    			map.put("active_net_name", 		CommonUtil.getCtmActiveNetName(map));
    			map.put("s_user_cd", 			CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 			CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			System.out.println("s_user_cd : " + map.get("s_user_cd"));
    			
    			l = emJobLogService.dGetJobLogList(map);
    			
    		} else if(itemGb.equals("activeJobList")) {		//실시간수행현황
    			
    			map.put("active_net_name", 		CommonUtil.getCtmActiveNetName(map));
    			map.put("p_sched_table", 		CommonUtil.isNull(map.get("p_sched_table")).replaceAll("&apos;","\'"));
//    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			map.put("p_scode_nm", 			CommonUtil.isNull(map.get("p_scode_nm")).replaceAll("&apos;","\'"));
    			map.put("s_user_cd", 			CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 			CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			// 멀티 상태 선택
    			String p_status = CommonUtil.isNull(map.get("p_status"));
    			if(p_status.indexOf("Held") > -1) {
    				p_status = p_status.replaceAll("Held,", "");
    				map.put("Held", "Held");
    			}
    			ArrayList<String> statusList = new ArrayList<>(Arrays.asList(p_status.split("\\s*,\\s*")));
    			map.put("statusList", statusList);
    			
    			l = worksApprovalDocService.dGetActiveJobList(map);
    			
    			ActiveJobBean activeJobListCnt = worksApprovalDocService.dGetActiveJobListCnt(map);
    			String total_cnt = String.valueOf(activeJobListCnt.getTotal_cnt());
    			l.add(total_cnt);
    		}else if(itemGb.equals("jobGroupList")) {      // 그룹job등록 리스트 조회
    			l = worksApprovalDocService.dGetJobGroupList(map);
    		}else if(itemGb.equals("detailGrpList")) {
    			l = worksApprovalDocService.dGetJobGroupDetailList(map);
    		}else if(itemGb.equals("jobCondList")){			//발행컨디션조회
    			
    			String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
    			String data_center 		= CommonUtil.isNull(map.get("p_data_center"));
    	
    			map.put("CTM_SCHEMA", CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
    			
    			l = ctmInfoService.dGetJobCondList(map);
    			
    		}else if(itemGb.equals("jobCondHistoryList")){			//삭제컨디션 이력조회
    			l = emCtmInfoService.dGetJobCondHistoryList(map);
    		}else if(itemGb.equals("userList")){			//관리자 사용자 내역
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = worksUserService.dGetUserList(map);
    			
    			//페이징 처리를 위한 total_count 조회
    			CommonBean userListCnt = worksUserService.dGetUserListCnt(map);
    			String total_cnt 	   = String.valueOf(userListCnt.getTotal_count());
    			l.add(total_cnt);
    		}else if(itemGb.equals("sendLogList")){			//관리자 사용자 내역	
    			l = worksUserService.dGetSendLogList(map);
    		}else if(itemGb.equals("deptList")){			//부서관리
    			l = worksCompanyService.dGetDeptList(map);
    		}else if(itemGb.equals("dutyList")){			//직책관리
    			l = worksCompanyService.dGetDutyList(map);
    		}else if(itemGb.equals("hostList")){			//호스트관리
    			map.put("searchType", "hostList");
    			l = commonService.dGetSearchItemList(map);
    		}else if(itemGb.equals("databaseList")){		//DB관리
    			map.put("searchType", "databaseList");
    			l = commonService.dGetSearchItemList(map);
    		}else if(itemGb.equals("sched_tableList2")){
    			map.put("searchType", "sched_tableList2");
    			l = commonService.dGetSearchItemList(map);
    			
    		}else if(itemGb.equals("sched_tableList3")){			//일괄폴더권한
    			map.put("searchType", "sched_tableList3");
    			l = commonService.dGetSearchItemList(map);

    		}else if(itemGb.equals("sched_user_tableList")) {
    			map.put("searchType", "sched_user_tableList");
    			l = commonService.dGetSearchItemList(map);
    		}else if(itemGb.equals("hostGrpList")){			//호스트 그룹 목록
    			
    			String data_center 	= CommonUtil.isNull(map.get("data_center"));
    			String serverGb 	= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
    			
    			if(serverGb.equals("D") || serverGb.equals("T")){
    				map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
    			}
    			//오라클
//    			l = commonService.dGetCmsNodGrpList(map);
    			//포스트그리
    			l = ctmInfoService.dGetCmsNodGrpList(map);
    			
    		}else if(itemGb.equals("grpNodeList")){			//그룹안의 호스트 목록
    			
    			String data_center 	= CommonUtil.isNull(map.get("data_center"));
    			String serverGb 	= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
    			
    			if(serverGb.equals("D") || serverGb.equals("T")){
    				map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
    			}
    			//오라클
//    			l = commonService.dGetCmsNodGrpNodeList(map);
    			//포스트그리
    			l = ctmInfoService.dGetCmsNodGrpNodeList(map);
    			
    		}else if(itemGb.equals("allDocInfoList")){				//전체결재현황
    			l = worksApprovalDocService.dGetAllDocInfoList(map);
    		}else if(itemGb.equals("alertList")){					//Alert Monitor
    			String severity = CommonUtil.isNull(map.get("p_severity"));
    			String[] arr_severity = severity.split("_");
//    			map.put("p_sched_table", CommonUtil.isNull(map.get("p_sched_table")).replaceAll("&apos;","\'"));
    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			if(arr_severity.length > 1 ) {
    				for(int i = 0; i < arr_severity.length; i++) {
        				map.put("p_severity", arr_severity[i]);
        				l.addAll(emAlertService.dGetAlertList(map));
        			}
    			}else {
    				l = emAlertService.dGetAlertList(map);
    			}
    			
    		} else if(itemGb.equals("alertErrorList")) {				//일배치오류관리
    			
    			map.put("p_sched_table", CommonUtil.isNull(map.get("p_sched_table")).replaceAll("&apos;","\'"));
//    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			System.out.println("map : " + map);
    			
    			String s_user_gb = CommonUtil.isNull(req.getSession().getAttribute("USER_GB"));
    			
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			map.put("s_user_id", 		CommonUtil.isNull(req.getSession().getAttribute("USER_ID")));
    			
    			if(!s_user_gb.equals("99")) {
    				map.put("user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			}
    			l = emAlertService.dGetAlertErrorList(map);
    			
    			//페이징 처리를 위한 total_count 조회
				CommonBean alertErrorListCnt = emAlertService.dGetAlertErrorListCnt(map);
				String total_cnt 			= String.valueOf(alertErrorListCnt.getTotal_cnt());
    			l.add(total_cnt);
    		}else if(itemGb.equals("mCodeList")){					//코드관리 - 대메뉴
    			l = worksCompanyService.dGetMCodeList(map);
    		}else if(itemGb.equals("sCodeList")){					//코드관리 - 소메뉴
    			List scodeDeptNmList 		= null;
    			Map<String, Object> map2 = new HashMap<String, Object>();
    			map2.put("mcode_cd", "M67");
    			map2.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
    			scodeDeptNmList = commonService.dGetsCodeList(map2);
    			String dept_nm = "";
    			String scode_nm = "";
    			String s_dept_nm = CommonUtil.isNull(req.getSession().getAttribute("DEPT_NM"));
    			map.put("s_dept_nm", 	s_dept_nm);
    			for(int i=0; i<scodeDeptNmList.size(); i++){
    				CommonBean bean = (CommonBean)scodeDeptNmList.get(i);
    				
    				scode_nm = CommonUtil.isNull(bean.getScode_nm());
    				if(scode_nm.equals(s_dept_nm)){
    					map.put("s_dept_nm", "카드ICT개발센터");
    					continue;
    				}
    			}
    			
    			l = worksCompanyService.dGetSCodeList(map);
    			
    		}else if(itemGb.equals("myDocInfoList")){				//요청서류함
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			map.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
    			
    			String strTaskNm = CommonUtil.isNull(map.get("p_task_nm"));
    			String strPsText = CommonUtil.isNull(map.get("p_s_text"));
    			
	            logger.debug("strTaskNm ::: " + strTaskNm);
	            logger.debug("strPsText ::: " + strPsText);
	            
	            String strStartRowNum = CommonUtil.isNull(map.get("startRowNum"));
	            
    			if(!strPsText.equals("")) {
    				map.put("startRowNum", null);
    				
    				logger.debug(":::::1.전체문서 조회");
    				l = worksApprovalDocService.dGetMainDocInfoList2(map);
    				ArrayList<String> p_doc_cd_list = new ArrayList<String>();
    				
    				for(int i=0;i<l.size();i++) {
    					DocInfoBean bean = (DocInfoBean)l.get(i);
    					p_doc_cd_list.add(
    							CommonUtil.isNull(bean.getMain_doc_cd()).equals("") ? CommonUtil.isNull(bean.getDoc_cd()) : CommonUtil.isNull(bean.getMain_doc_cd())
    							);
    				}
    				
    				logger.debug(":::::2.엑셀일괄 조회");
					l = worksApprovalDocService.dGetDoc06DetailList2(map);
    				
    				for(int j=0;j<l.size();j++) {
    					Doc06Bean bean = (Doc06Bean)l.get(j);
    					p_doc_cd_list.add(bean.getDoc_cd());
    				}
    				
    				HashSet<String> set = new HashSet<>(p_doc_cd_list);
    		        p_doc_cd_list = new ArrayList<>(set);
    				
    				map.put("p_doc_cd_list", p_doc_cd_list);
    			}
    			
    			map.put("startRowNum", strStartRowNum);
    			logger.debug("p_doc_cd_list 포함된 map :::: " + map);
    			logger.debug(":::::모은 doc_cd 리스트로 요청문서함에서 검색");
    			l = worksApprovalDocService.dGetMyDocInfoList(map);

				//페이징 처리를 위한 total_count 조회
				CommonBean myDocInfoListCnt = worksApprovalDocService.dGetMyDocInfoListCnt(map);
				String total_cnt 			= String.valueOf(myDocInfoListCnt.getTotal_cnt());
				l.add(total_cnt);

    		}else if(itemGb.equals("mainDocInfoList")){				//DOC05 일괄승인
    			l = worksApprovalDocService.dGetMainDocInfoList(map);
    		}else if(itemGb.equals("approvalDocInfoList")){						//결재서류함
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			String strTaskNm = CommonUtil.isNull(map.get("p_task_nm"));
    			String strPsText = CommonUtil.isNull(map.get("p_s_text"));
	            System.out.println("strTaskNm1 : " + strTaskNm);
	            String strStartRowNum = CommonUtil.isNull(map.get("startRowNum"));
    			if(!strPsText.equals("")) {
    				map.put("startRowNum", null);
    				l = worksApprovalDocService.dGetMainDocInfoList2(map);
    				ArrayList<String> p_doc_cd_list = new ArrayList<String>();
    				for(int i=0;i<l.size();i++) {
    					DocInfoBean bean = (DocInfoBean)l.get(i);
    					p_doc_cd_list.add(
    							CommonUtil.isNull(bean.getMain_doc_cd()).equals("") ? CommonUtil.isNull(bean.getDoc_cd()) : CommonUtil.isNull(bean.getMain_doc_cd())
    							);
    				}
					l = worksApprovalDocService.dGetDoc06DetailList2(map);
    				
    				for(int j=0;j<l.size();j++) {
    					Doc06Bean bean = (Doc06Bean)l.get(j);
    					p_doc_cd_list.add(bean.getDoc_cd());
    				}
    				map.put("p_doc_cd_list", p_doc_cd_list);
    			}
    			
    			map.put("startRowNum", strStartRowNum);
    			
    			l = worksApprovalDocService.dGetApprovalDocInfoList(map);
    			
    			//페이징 처리를 위한 total_count 조회
				CommonBean approvalDocInfoListCnt = worksApprovalDocService.dGetApprovalDocInfoListCnt(map);
				String total_cnt = String.valueOf(approvalDocInfoListCnt.getTotal_count());
				l.add(total_cnt);
				
    		}else if(itemGb.equals("scodeList")){					//공통코드 - 소분류 내역 (selectbox 용)
    			
    			List scodeDeptNmList 		= null;
    			Map<String, Object> map2 = new HashMap<String, Object>();
    			map2.put("mcode_cd", "M67");
    			map2.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
    			scodeDeptNmList = commonService.dGetsCodeList(map2);
    			String dept_nm = "";
    			String scode_nm = "";
    			String s_dept_nm = CommonUtil.isNull(req.getSession().getAttribute("DEPT_NM"));
    			map.put("s_dept_nm", 	s_dept_nm);
    			for(int i=0; i<scodeDeptNmList.size(); i++){
    				CommonBean bean = (CommonBean)scodeDeptNmList.get(i);
    				
    				scode_nm = CommonUtil.isNull(bean.getScode_nm());
    				if(scode_nm.equals(s_dept_nm)){
    					map.put("s_dept_nm", "카드ICT개발센터");
    					continue;
    				}
    			}
    			l = commonService.dGetScodeList(map);
    			
    		} else if(itemGb.equals("appGrpCodeList")) {				//공통코드 - app/group 내역 (selectbox 용)
    			
    			map.put("app_nm", 			CommonUtil.isNull(map.get("p_app_nm")));    			
    			map.put("app_eng_nm", 		CommonUtil.isNull(map.get("p_app_eng_nm")));
    			map.put("scode_cd", 		CommonUtil.isNull(map.get("p_scode_cd")));
    			map.put("grp_cd", 			CommonUtil.isNull(map.get("p_grp_cd")));
    			map.put("grp_depth", 		CommonUtil.isNull(map.get("p_grp_depth")));
    			map.put("app_search_gubun", CommonUtil.isNull(map.get("p_app_search_gubun")));
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			l = commonService.dGetAppGrpCodeList(map);
    			
			} else if(itemGb.equals("appGrpCodeList2")) {				//공통코드 - app/group 내역 (selectbox 용)
    			List sCodeList = null;
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("mcode_cd", "M95"); // 사용자의 폴더권한 사용 여부
				map2.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				sCodeList = commonService.dGetsCodeList(map2);
				String scode_nm = "";
				for(int i = 0; i < sCodeList.size(); i++) {
					CommonBean bean = (CommonBean)sCodeList.get(i);
					scode_nm = CommonUtil.isNull(bean.getScode_nm());
				}
				
    			map.put("app_nm", 			CommonUtil.isNull(map.get("p_app_nm")));    			
    			map.put("app_eng_nm", 		CommonUtil.isNull(map.get("p_app_eng_nm")));
    			map.put("scode_cd", 		CommonUtil.isNull(map.get("p_scode_cd")));
    			map.put("grp_cd", 			CommonUtil.isNull(map.get("p_grp_cd")));
    			map.put("grp_depth", 		CommonUtil.isNull(map.get("p_grp_depth")));
    			map.put("app_search_gubun", CommonUtil.isNull(map.get("p_app_search_gubun")));
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			if(scode_nm.equals("N")) {
    				map.put("s_user_gb", "99"); // 사용자의 폴더권한 사용 여부 'N' - 모든 폴더 노출 
    			}else {
    				map.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			}
    			
    			l = commonService.dGetAppGrpCodeList2(map);
    			
    		} else if(itemGb.equals("searchAppGrpCodeList")) {				//공통코드 - app/group 내역 (selectbox 용)
    			
    			map.put("app_nm", 			CommonUtil.isNull(map.get("p_app_nm")));    			
    			map.put("app_eng_nm", 		CommonUtil.isNull(map.get("p_app_eng_nm")).replaceAll("&apos;","\'"));
    			map.put("scode_cd", 		CommonUtil.isNull(map.get("p_scode_cd")));
    			map.put("grp_depth", 		CommonUtil.isNull(map.get("p_grp_depth")));
    			map.put("app_search_gubun", CommonUtil.isNull(map.get("p_app_search_gubun")));
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			l = commonService.dGetSearchAppGrpCodeList(map);    			
    			
    		} else if(itemGb.equals("appGrpList")) {
    			
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			l = commonService.dGetAppGrpList(map);
    			
    		}else if(itemGb.equals("popDefJobList")){				//선.후행 검색 시 잡 
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			String data_center = CommonUtil.isNull(map.get("data_center"));
    			String application = CommonUtil.isNull(map.get("p_application")).replaceAll("&apos;","\'");
    			if(data_center.equals("")) map.put("data_center", CommonUtil.isNull(map.get("p_data_center")));
    			if(!application.equals("")) map.put("p_application_of_def", application);
    			
    			l = popupDefJobService.dGetDefJobList(map);
    		}else if(itemGb.equals("calCodeList2")){					//스케즐 관리
    			l = commonService.dGetCalCodeList2(map);
    		}else if(itemGb.equals("activeStartTimeList")){			// 수행시간 별 정보
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				if(CommonUtil.isNull(map.get("data_center")).equals(bean.getData_center())){
    					map.put("active_net_name", bean.getActive_net_name());
    					map.put("data_center_code", bean.getData_center_code());
    					
    					break;
    				}    				
    			}
    			
    			l = popupTimeInfoService.dGetAtiveStartTimeList(map);
			}else if(itemGb.equals("timeInfoList")){			// 수행시간 별 정보
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				if(CommonUtil.isNull(map.get("data_center")).equals(bean.getData_center())){
    					map.put("active_net_name", bean.getActive_net_name());
    					map.put("data_center_code", bean.getData_center_code());
    					
    					break;
    				}    				
    			}
    			
    			l = popupTimeInfoService.dGetTimeInfoList(map);
			}else if(itemGb.equals("endTimeInfoList")){		// 최종 상태 정보
				List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();

				for(int i=0;i<dataCenterList.size();i++){
					CommonBean bean = dataCenterList.get(i);

					if(CommonUtil.isNull(map.get("data_center")).equals(bean.getData_center())){
						map.put("active_net_name", bean.getActive_net_name());
						map.put("data_center_code", bean.getData_center_code());

						break;
					}
				}

				l = popupTimeInfoService.dGetEndTimeInfoList(map);
    		}else if(itemGb.equals("noticeList")){
    			map.put("board_gb", "01");
    			l = commonService.dGetBoardList(map);
    		}else if(itemGb.equals("noticeDetail")){
    			map.put("board_gb", "01");
    			l = commonService.dGetBoardInfo(map);
    			
    		}else if(itemGb.equals("defJobList")){					//비정기작업 의뢰
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			map.put("p_sched_table", CommonUtil.isNull(map.get("p_sched_table")).replaceAll("&apos;","\'"));
//    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			
    			l = worksApprovalDocService.dGetDefJobList(map);

    			com.ghayoun.ezjobs.t.domain.DefJobBean defJobListCnt = worksApprovalDocService.dGetDefJobListCnt(map);
    			String defJobCnt = String.valueOf(defJobListCnt.getTotal_cnt());
    			l.add(defJobCnt);
    			
    		}else if(itemGb.equals("doc06DetailList")){
    			l = worksApprovalDocService.dGetDoc06DetailList(map);
    		}else if(itemGb.equals("mainErrorList")){				//메인페이지 에러리스트
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			
    			l = emCtmInfoService.dGetDashBoard_errList(map);
    		}else if(itemGb.equals("mainAllDocInfoList")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			l = commonService.dGetMainAllDocInfoList(map);
    		}else if(itemGb.equals("ctmLogList")){
    			    			
    			String data_center = CommonUtil.isNull(map.get("data_center"));
    			String odate = CommonUtil.isNull(map.get("odate"));
    			String curDate = CommonUtil.toDate();
    			
    			if(odate.equals(curDate)) map.put("odate", "");    			
    			odate = CommonUtil.isNull(map.get("odate"));    			
    			
    			if ( data_center.indexOf(",") > -1 ) {
					data_center = data_center.split(",")[1];
				}
    			
    			logger.info("data_center===============>"+data_center);
    			
    			String serverGb 	= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
    			if(serverGb.equals("D") || serverGb.equals("T")){
    				map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
    			}else{
    				if(data_center.equals("WINI")){
    					map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR1.SCHEMA"));
    				}else if(data_center.equals("CARD")){
    					map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR3.SCHEMA"));
    				}else if(data_center.equals("EXPERT")){
    					map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR2.SCHEMA"));
    				}
    			}
    			
    			logger.info("odate===============>"+odate);
    			if(!odate.equals("")){
    				try{
    					commonDao.dGetCtmLogPartChk(map);
    					map.put("odate", odate);
    					logger.info("odate============>true");
    				}catch(Exception e){
    					logger.info("odate============>false");
    					map.put("odate", "");
    				}
    			}
    			
    			try {

        			// DB링크 접속
    				CommonUtil.dblinkConnect();
    			
    				l = commonService.dGetCtmLogList(map);
	    			
    			}catch (Exception e) {
    				
					logger.error("DB LINK 오류로 재 호출");
					
					try {
					
						// DB링크 접속
	    				CommonUtil.dblinkConnect();
	    				
					}catch (Exception ee) {
						
					}
    			
    				l = commonService.dGetCtmLogList(map);
					
				} finally {
					
					// DB링크 접속
    				CommonUtil.dblinkConnect();
					
					l = commonService.dGetCtmLogList(map);
					
					// DB링크 접속 해제 
	    			CommonUtil.dblinkDisconnect();
    			}
    			
    		}else if(itemGb.equals("susiExcelLoad")){
    		
    			String file_nm = CommonUtil.isNull(map.get("file_nm"));
    			
    			logger.info("# CommonServiceImpl | susiExcelLoad | file_nm :::"+file_nm);
    			
    			ExcelUtil excel = new ExcelUtil();
    			String file_path = req.getRealPath(CommonUtil.getMessage("MENUAL_FILE.PATH"))+"/excel_tmp";
    			
    			l = excel.getExcelRead(file_path, file_nm);
    			
    			if ( l.size() <= 0 ) {
    				
    				Map rMap3 = new HashMap();
    				//rMap3.put("r_code","-2");
    				//rMap3.put("r_msg", "ERROR : 엑셀파일을 확인해 주세요. (0건, DRM해제 등)");
    				throw new DefaultServiceException(rMap3);
    			}
    			
    			ArrayList<String[]> al = excel.getExcelRead(file_path, file_nm);
    			
    			for(int i=1; null!=al&&i<al.size(); i++){
    				
					String[] items = al.get(i);
					
					if (items.length != 12) {
						
						//String strAddField  = "";
						//strAddField			= 	"2018.04.19 정리\\n\\n1.서버명\\n2.수행계정\\n3.작업명\\n4.작업내용\\n5.프로그램 위치\\n6.프로그램 명\\n7.작업수행명령\\n";
						//strAddField			+= 	"8.실행구분\\n9.실행시간\\n10.선행작업\\n11.DB UPDATE\\n12.후행컨디션\\n";
						
						Map rMap3 = new HashMap();
	    				//rMap3.put("r_code","-2");
	    				//rMap3.put("r_msg", "엑셀양식이 다릅니다. \\n엑셀샘플을 다시 받아 주세요.\\n\\n" + strAddField);
	    				throw new DefaultServiceException(rMap3);						
					}
    			}
    			
    			//엑셀데이터를 읽고 업로드된 파일을 삭제한다.
    			try{
	    			File file = new File(file_path, file_nm);
	    			file.delete();
	    			
	    			logger.info("# CommonServiceImpl | susiExcelLoad | file delete ::: Success");
    			}catch(Exception e){
    				logger.info("# CommonServiceImpl | susiExcelLoad | file delete ::: Fail");
    				e.getMessage();
    			}
    		}else if(itemGb.equals("userApprovalGroup")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetUserApprovalGroup(map);
    		}else if(itemGb.equals("workGroupList")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetWorkGroupList(map);
    		}else if(itemGb.equals("adminApprovalGroup")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetAdminApprovalGroup(map);
    		}else if(itemGb.equals("groupApprovalGroup")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetGroupApprovalGroup(map);
    		}else if(itemGb.equals("userApprovalLine")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetUserApprovalLine(map);
    		}else if(itemGb.equals("adminApprovalLine")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetAdminApprovalLine(map);
    		}else if(itemGb.equals("adminApprovalLine_u")){ //결재선조회 (2020.05.11 추가, 김수정)
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			List<CommonBean> ApprovalList = new ArrayList<>();
    			
    			// 필수결재선의 결재구분이 개인결재인 경우 사용자결재선으로 변경해서 보여준다. (2022.06.14 강명준)
    			List<ApprovalLineBean> userApprovalList 	= worksApprovalLineService.dGetUserApprovalLineList(map);
    			List<CommonBean> adminApprovalList 			= commonService.dGetAdminApprovalLine_u(map);
    			
    			int i = 0;
    			
    			for (CommonBean reMap:adminApprovalList) {
    				
    				i++;
    				
    				CommonBean bean = new CommonBean();
    				
    				String strAdmin_line_cd 		= CommonUtil.isNull(reMap.getAdmin_line_cd());
    				String strAdmin_line_grp_cd 	= CommonUtil.isNull(reMap.getAdmin_line_grp_cd());
    				String strApproval_user_id 		= CommonUtil.isNull(reMap.getApproval_user_id());
    				String strApproval_cd 			= CommonUtil.isNull(reMap.getApproval_cd());
    				String strApproval_nm			= CommonUtil.isNull(reMap.getApproval_nm());
    				String strApproval_gb 			= CommonUtil.isNull(reMap.getApproval_gb());
    				String strApproval_type			= CommonUtil.isNull(reMap.getApproval_type());
    				String strDuty_nm				= CommonUtil.isNull(reMap.getDuty_nm());
    				String strDept_nm 				= CommonUtil.isNull(reMap.getDept_nm());
    				String strGroup_line_grp_cd		= CommonUtil.isNull(reMap.getGroup_line_grp_cd());
    				String strGroup_line_grp_nm 	= CommonUtil.isNull(reMap.getGroup_line_grp_nm());
    				String strUser_id 				= CommonUtil.isNull(reMap.getUser_id());
    				
    				if ( strApproval_cd.equals("") && strGroup_line_grp_nm.equals("") ) {
    					
    					i--;
    					
    					for (ApprovalLineBean reMap2:userApprovalList) {
    						
    						i++;
    						
    						CommonBean bean2 = new CommonBean();
    						
    						strUser_id 		= CommonUtil.isNull(reMap2.getUser_id());
    						strApproval_nm 	= CommonUtil.isNull(reMap2.getUser_nm());
    						strDuty_nm 		= CommonUtil.isNull(reMap2.getDuty_nm());
    						strDept_nm		= CommonUtil.isNull(reMap2.getDept_nm());
    						
    						bean2.setAdmin_line_cd(strAdmin_line_cd);
    						bean2.setAdmin_line_grp_cd(strAdmin_line_grp_cd);
    						bean2.setApproval_user_id(strUser_id);
    						bean2.setApproval_cd(strApproval_cd);
    						bean2.setApproval_nm(strApproval_nm);
    						bean2.setApproval_seq(Integer.toString(i));
    						bean2.setApproval_gb(strApproval_gb);
    						bean2.setApproval_type(strApproval_type);
    						bean2.setDuty_nm(strDuty_nm);
    						bean2.setDept_nm(strDept_nm);
    						bean2.setGroup_line_grp_cd(strGroup_line_grp_cd);
    						bean2.setGroup_line_grp_nm(strGroup_line_grp_nm);
    						bean2.setUser_id(strUser_id);
    						
    						ApprovalList.add(bean2);    						
    					}
    					
    				} else {
        				
    					bean.setAdmin_line_cd(strAdmin_line_cd);
						bean.setAdmin_line_grp_cd(strAdmin_line_grp_cd);
						bean.setApproval_user_id(strApproval_user_id);
						bean.setApproval_cd(strApproval_cd);
						bean.setApproval_nm(strApproval_nm);
						bean.setApproval_seq(Integer.toString(i));
						bean.setApproval_gb(strApproval_gb);
						bean.setApproval_type(strApproval_type);
						bean.setDuty_nm(strDuty_nm);
						bean.setDept_nm(strDept_nm);
						bean.setGroup_line_grp_cd(strGroup_line_grp_cd);
						bean.setGroup_line_grp_nm(strGroup_line_grp_nm);
						bean.setUser_id(strUser_id);
    					
    					ApprovalList.add(bean);
    				}
    			}
    			
    			l = ApprovalList;
    			
    		}else if(itemGb.equals("groupApprovalLine")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetGroupApprovalLine(map);
    		}else if(itemGb.equals("ctmAgentList")){
    			
    			String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
    			String data_center 		= CommonUtil.isNull(map.get("p_data_center"));
    			
    			if ( strServerGb.equals("D") || strServerGb.equals("T") ) {
    				map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
    			} else {
    				if(data_center.equals("S54,WINI")){
    					map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR1.SCHEMA"));
    				}else if(data_center.equals("S646,EXPERT")){
    					map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR2.SCHEMA"));
    				}else if(data_center.equals("S647,CARD")){
    					map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR3.SCHEMA"));
    				}
    			}
    			
    			try {

        			// DB링크 접속
    				CommonUtil.dblinkConnect();
    			
    				l = commonDao.dGetCtmAgentList(map);
	    			
    			}catch (Exception e) {
    				
					logger.error("DB LINK 오류로 재 호출");
					
					try {
					
						// DB링크 접속
	    				CommonUtil.dblinkConnect();
	    				
					}catch (Exception ee) {
						
					}
    			
    				l = commonDao.dGetCtmAgentList(map);
					
				} finally {
					
					// DB링크 접속
    				CommonUtil.dblinkConnect();
					
					l = commonDao.dGetCtmAgentList(map);
					
					// DB링크 접속 해제 
	    			CommonUtil.dblinkDisconnect();
    			}
    			
    		}else if(itemGb.equals("doc02List")){
    			l = worksApprovalDocService.dGetDoc02List(map);
    		}else if(itemGb.equals("mHostList")){
    			
    			List sCodeList = null;
    			
				Map<String, Object> map2 = new HashMap<String, Object>();
				map2.put("mcode_cd", "M96"); // 폴더의 수행 서버권한 사용여부
				map2.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				sCodeList = commonService.dGetsCodeList(map2);
				String scode_nm = "";
				for(int i = 0; i < sCodeList.size(); i++) {
					CommonBean bean = (CommonBean)sCodeList.get(i);
					scode_nm = CommonUtil.isNull(bean.getScode_nm());
				}
				if(scode_nm.equals("N")) {
					l = commonService.dGetHostInfoList(map); // 폴더의 수행 서버권한 사용여부 'N' - 모든 수행서버 노출
				}else {
					l = commonService.dGetMHostList(map);
				}
    		}else if(itemGb.equals("doc02List2")){
    			l = worksApprovalDocService.dGetDoc02List2(map);
    		}else if(itemGb.equals("doc02JobList2")){
    			l = worksApprovalDocService.dGetDoc02JobList2(map);
    		}else if(itemGb.equals("argumentList")){
    			l = commonService.dGetArgumentList(map);
    		}else if(itemGb.equals("periodList")){
    			
    			String strApplicationOfDef = CommonUtil.isNull(map.get("p_application_of_def"));
    			
    			if ( !strApplicationOfDef.equals("") ) {
    				strApplicationOfDef = "'" + strApplicationOfDef + "'";
    				map.put("p_application_of_def", strApplicationOfDef);
    			}
    			
    			l = emDefJobsService.dGetDefJobExcelList(map);
    			
    		}else if(itemGb.equals("getInCondNameList")){
    			l = commonDao.dGetInCondNameList(map);
    			
    		}else if(itemGb.equals("checkIfName")){
    			
    			String ifName = CommonUtil.isNull(map.get("if_name"));
    			
    			l = dcheckIfName(ifName);
    			
    		}else if(itemGb.equals("batchResultTotalList2")) {
    			
    			map.put("p_sched_table", 	CommonUtil.isNull(map.get("p_sched_table")).replaceAll("&apos;","\'"));
//    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			l = emBatchResultTotalService.dGetBatchResultTotalList2(map);
    		
    		}else if(itemGb.equals("batchResultTotalList3")) {
    			
    			map.put("p_sched_table", 	CommonUtil.isNull(map.get("p_sched_table")).replaceAll("&apos;","\'"));
//    			map.put("p_application_of_def", CommonUtil.isNull(map.get("p_application_of_def")).replaceAll("&apos;","\'"));
    			
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			l = emBatchResultTotalService.dGetBatchResultTotalList3(map);
    		
    		} else if(itemGb.equals("srList")) {
    			l = commonService.dGetSrList(map);
    			
    		} else if(itemGb.equals("myWorksInfoList")) {
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			
    			l = commonService.dGetMyWorksInfoList(map);
    		
    		} else if(itemGb.equals("myDocInfoCntList")) {
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
				map.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));

    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			
    			l = commonService.dGetMyDocInfoCntList(map);
    		
    		} else if(itemGb.equals("myAlarmDocInfoCntList")) {
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			
    			l = commonService.dGetMyAlarmDocInfoCntList(map);
    		
    		} else if(itemGb.equals("myApprovalDocInfoList")) {
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			
    			l = commonService.dGetMyApprovalDocInfoList(map);
    		
    		} else if(itemGb.equals("execDocInfoList")) {
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			
    			l = commonService.dGetExecDocInfoList(map);
    		
    		} else if(itemGb.equals("myWorkList")) {
    			
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			
    			List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();
    			List<Map<String, Object>> data_center_items = new ArrayList<>();
    			
    			Map<String, Object> hm = null;
    			
    			for(int i=0;i<dataCenterList.size();i++){
    				CommonBean bean = dataCenterList.get(i);
    				
    				hm = new HashMap();
    				hm.put("data_center_code", bean.getData_center_code());
    				hm.put("data_center", bean.getData_center());
    				hm.put("active_net_name", bean.getActive_net_name());
    				
    				data_center_items.add(hm);
    			}
    			
    			map.put("data_center_items", data_center_items);
    			
    			l = commonService.dGetMyWorkList(map);
    			
    		}else if(itemGb.equals("checkSmartTableCnt")){
    			
    			String strTableName = CommonUtil.isNull(map.get("table_name"));
    			
    			l = commonService.dGetCheckSmartTableCnt(map);
    		
    		}else if(itemGb.equals("userDailyNameList")){
    			
    			l = commonService.dGetUserDailyNameList(map);
    		}else if(itemGb.equals("sForderList")){
    			
    			l = commonService.dGetsForderList(map);
    		} else if (itemGb.equals("batchTotal")) {
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			l = dGetBatchTotal(map);
    		} else if (itemGb.equals("docApprovalTotal")) {
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			l = dGetDocApprovalTotal(map);
    		} else if (itemGb.equals("jobCondTotal")) {
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			l = dGetJobCondTotal(map);
    		} else if (itemGb.equals("errorLogTotal")) {
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			l = dGetErrorLogTotal(map);
    			
    			//페이징 처리를 위한 total_count 조회
    			List errorLogTotalCnt = dGetErrorLogTotalCnt(map);
    			for(int i=0;i<errorLogTotalCnt.size();i++){
    				CommonBean bean = (CommonBean)errorLogTotalCnt.get(i);
    				String total_cnt 			= String.valueOf(bean.getTotal_cnt()); 
    				l.add(total_cnt);
    			}

    		// 네이버 그룹 메일 조회
    		} else if(itemGb.equals("groupMailList")) {
    			
    			try {
    			
	    			String json_string				= "";
	    			String strGroupMailSearchUrl	= CommonUtil.isNull(CommonUtil.getMessage("GROUP_MAIL_SEARCH_URL"));
	    			String strPsearchGubun		 	= CommonUtil.isNull(map.get("p_search_gubun"));
	    			String strPsearchText		 	= CommonUtil.isNull(map.get("p_search_text"));
	    			
	    			URL obj = new URL(strGroupMailSearchUrl + "&" + strPsearchGubun + "=" + java.net.URLEncoder.encode(strPsearchText));
	    			HttpURLConnection conn = (HttpURLConnection) obj.openConnection();
	    			
	    			conn.setRequestMethod("GET");
	    			conn.setDoOutput(true);
	    			
	    			BufferedReader br 	= null;
	
	    			br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
	    			
	    			String line = "";
	    			
	    			while ((line = br.readLine()) != null) {				
	    				json_string = line;
	    			}
	    			
	    			br.close();
	    			conn.disconnect();
	    			
	    			JsonParser jsonParser 	= new JsonParser();
	    			JsonObject jsonObject 	= (JsonObject) jsonParser.parse(json_string);
	    			JsonArray jsonArray 	= jsonObject.getAsJsonArray("dlInfo");
	    			
	    			for (int i = 0; i < jsonArray.size(); i++) {
	    				
	    				CommonBean commonBean 	= new CommonBean();
	    				
	    				JsonObject object = (JsonObject) jsonArray.get(i);
	    				
	    				String dlNm 	= CommonUtil.isNull(object.get("dlNm").getAsString());
	    				String email 	= CommonUtil.isNull(object.get("email").getAsString());
	    				String dlCd 	= CommonUtil.isNull(object.get("dlCd").getAsString());
	    				
	    				commonBean.setDlNm(dlNm);
	    				commonBean.setEmail(email);
	    				commonBean.setDlCd(dlCd);
	    				
	    				l.add(commonBean);
	    			}
	    			
    			} catch (Exception e) {
    				e.printStackTrace();
    			}
    		} else if (itemGb.equals("defJobExceptMapper")) {
    			//SC 복수 작업명 검색가능 요건으로 변경 (2020.10.20 김수정)
    			String p_search_text = CommonUtil.isNull(map.get("p_job_name"));
    			ArrayList<String> p_search_text_list = new ArrayList<String>();
    			for (String text : p_search_text.split(",")) {
    				p_search_text_list.add(text);
    			}
    			map.put("p_job_name", p_search_text_list);
    			
    			l = commonDao.dGetDefJobExceptMapper(map);
    		} else if (itemGb.equals("cmAppGrpCodeList")) {
    			//depth에 따라 조회 데이터가 변경됨
    			String grp_depth = CommonUtil.isNull(map.get(("p_grp_depth")));
    			if ("1".equals(grp_depth)) { //서비스(테이블)
        			l = commonDao.dGetCmTable(map);
    			} else if ("2".equals(grp_depth)) { //어플리케이션
        			l = commonDao.dGetCmApplication(map);
    			} else if ("3".equals(grp_depth)) { //그룹
        			l = commonDao.dGetCmGroup(map);
    			}
    		}else if (itemGb.equals("ctmHostList")) {
    			String select_gb = CommonUtil.isNull(map.get(("p_gb")));
    			map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("DB.CTMSVR.SCHEMA"));
    			
				List<CommonBean> HostList 		= new ArrayList<>();
				List<CommonBean> ctmHostList 	= ctmInfoDao.dGetCtmHost(map);
    			List<CommonBean> ezHostList 	= commonDao.dGetEzHostList(map);
    			
    			for(int i=0;i<ctmHostList.size();i++){
    				boolean dup_chk = false;
    				CommonBean bean = (CommonBean) ctmHostList.get(i);
    				
    				for(int j=0;j<ezHostList.size();j++){
    					CommonBean bean2 = (CommonBean) ezHostList.get(j);
    					
    					//ez_host에 존재하지 않는 host정보만 담아서 노출.
    					if(CommonUtil.isNull(bean2.getAgent()).equals(CommonUtil.isNull(bean.getNodeid()))) {
    						dup_chk = true;
    						break;
    					}
    				}
    				if(!dup_chk) {
    					HostList.add(bean);
    				}
    			}
    			l = HostList;
    		}else if (itemGb.equals("emOwnerList")) {
				List<CommonBean> ownerList 		= new ArrayList<>();
				List<CommonBean> emOwnerList 	= commonDao.dGetEmOwnerList(map);
    			
    			for(int i=0;i<emOwnerList.size();i++){
    				CommonBean bean = (CommonBean) emOwnerList.get(i);
    					
					if(!CommonUtil.isNull(bean.getHost_cd()).equals("")) {
						ownerList.add(bean);
					}
    			}
    			l = ownerList;
    		}else if (itemGb.equals("quartzList")) {
    			l = commonDao.dGetQuartzList(map);
    		} else if (itemGb.equals("popupQuartzList")) {
    			l = commonDao.dGetPopupQuartzList(map);
    		} else if(itemGb.equals("folderAppGrpList")) {
    			String user_cd = CommonUtil.isNull(map.get("user_cd"));
    			// 사용자 다중조회일 경우 데이터 초기화를 위해 user_cd = 0(빈값)으로 조회 (2024-09-09 김선중)
    			if(user_cd.indexOf(",") > 0) { 
    				map.put("user_cd", "0");
    			}
    			
    			l = worksUserService.dGetUserFolAuthList(map);
    		}else if(itemGb.equals("groupUserGroup")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetGroupUserGroup(map);
    		}else if(itemGb.equals("groupUserLine")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetGroupUserLine(map);
    		}else if(itemGb.equals("forecastDocList")){				//요청서류함
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			map.put("s_dept_cd", CommonUtil.isNull(req.getSession().getAttribute("DEPT_CD")));
    			l = worksApprovalDocService.dGetForecastDocList(map);
    		}else if(itemGb.equals("adminApprovalLineCd")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetAdminApprovalLineCd(map);
    		}else if(itemGb.equals("adminApprovalLineList")){
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			l = commonService.dGetAdminApprovalLineList(map);
    		}else if(itemGb.equals("workGroup")) {      // 업무그룹 리스트 조회
    			l = worksUserService.dGetWorkGroup(map);
    		}else if(itemGb.equals("folderGroupList")) {
    			l = worksApprovalDocService.dGetFolderGroupList(map);
    		}else if(itemGb.equals("resourceList")) {
    			map.put("mcode_cd", "M85");
    			System.out.println("map : " + map);
    			List<CommonBean> a = commonService.dGetScodeList(map);
    			map.put("CTMSVR_SCHEMA", CommonUtil.getMessage("CTMSVR.SCHEMA"));
    			l = commonService.dGetResourceList(map);
    		}else if(itemGb.equals("finalApprovalLineList")){ // 사용자 최종 결재선 조회
    			map.put("s_user_cd", CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));

    			List<CommonBean> ApprovalList = new ArrayList<>();

    			// 2023.08.27 강명준 추가
    			// 필수결재선의 결재구분이 개인결재인 경우 사용자결재선으로 변경해서 보여준다.
    			// 결재그룹인 경우 그룹원을 풀어서 보여준다.
    			List<ApprovalLineBean> userApprovalList 	= worksApprovalLineService.dGetUserApprovalLineList(map);
    			List<CommonBean> adminApprovalList 			= commonService.dGetAdminApprovalLineList(map);

    			String strUserApprovalSeq = "0";

    			for (CommonBean reMap:adminApprovalList) {

    				CommonBean bean = new CommonBean();

    				String strAdmin_line_cd 		= CommonUtil.isNull(reMap.getAdmin_line_cd());
    				String strAdmin_line_grp_cd 	= CommonUtil.isNull(reMap.getAdmin_line_grp_cd());
    				String strApproval_user_id 		= CommonUtil.isNull(reMap.getApproval_user_id());
    				String strApproval_cd 			= CommonUtil.isNull(reMap.getApproval_cd());
    				String strApproval_nm			= CommonUtil.isNull(reMap.getApproval_nm());
    				String strApproval_gb 			= CommonUtil.isNull(reMap.getApproval_gb());
    				String strApproval_type			= CommonUtil.isNull(reMap.getApproval_type());
    				String strDuty_nm				= CommonUtil.isNull(reMap.getDuty_nm());
    				String strDept_nm 				= CommonUtil.isNull(reMap.getDept_nm());
    				String strGroup_line_grp_cd		= CommonUtil.isNull(reMap.getGroup_line_grp_cd());
    				String strGroup_line_grp_nm 	= CommonUtil.isNull(reMap.getGroup_line_grp_nm());
    				String strUser_id 				= CommonUtil.isNull(reMap.getUser_id());
    				String strGroupApprovalUserNm	= CommonUtil.isNull(reMap.getGroup_approval_user_nm());
    				String strGroupApprovalUserCd   = CommonUtil.isNull(reMap.getGroup_approval_user_cd());
    				String strApprovalSeq			= CommonUtil.isNull(reMap.getApproval_seq());

    				// 개인결재 차수를 구함.
    				if ( strApproval_nm.equals("개인결재") ) {
    					strUserApprovalSeq = strApprovalSeq;
    				}

    				if ( strApproval_cd.equals("") && strGroup_line_grp_nm.equals("") ) {

    					int userApprovalListCnt = 0;

    					for (ApprovalLineBean reMap2:userApprovalList) {

    						userApprovalListCnt++;

    						CommonBean bean2 = new CommonBean();

    						strUser_id 		= CommonUtil.isNull(reMap2.getUser_id());
    						strApproval_nm 	= CommonUtil.isNull(reMap2.getUser_nm());
    						strDuty_nm 		= CommonUtil.isNull(reMap2.getDuty_nm());
    						strDept_nm		= CommonUtil.isNull(reMap2.getDept_nm());

    						String strLine_gb	= CommonUtil.isNull(reMap2.getLine_gb());

    						String strUserApprovalListCnt = Integer.toString(userApprovalListCnt + Integer.parseInt(strApprovalSeq) - 1);

    						bean2.setAdmin_line_cd(strAdmin_line_cd);
    						bean2.setAdmin_line_grp_cd(strAdmin_line_grp_cd);
    						bean2.setApproval_user_id(strUser_id);
    						bean2.setApproval_cd(strApproval_cd);
    						if(strLine_gb.equals("U")) {
    							strApproval_nm = "[개인결재선] " + strApproval_nm + "[" +strDept_nm + "][" + strDuty_nm + "]";
    						}
    						bean2.setApproval_nm(strApproval_nm);
    						bean2.setApproval_seq(strUserApprovalListCnt);
    						bean2.setApproval_gb(strApproval_gb);
    						bean2.setApproval_type(strApproval_type);
    						bean2.setDuty_nm(strDuty_nm);
    						bean2.setDept_nm(strDept_nm);
    						bean2.setGroup_line_grp_cd(strGroup_line_grp_cd);
    						bean2.setGroup_line_grp_nm(strGroup_line_grp_nm);
    						bean2.setUser_id(strUser_id);
    						bean2.setGroup_approval_user_nm(strGroupApprovalUserNm);

    						ApprovalList.add(bean2);
    					}

    				} else {

    					// 개인결재보다 차수가 높으면 개인결재자만큼 더하기.
    					if ( Integer.parseInt(strUserApprovalSeq) > 0 && (Integer.parseInt(strUserApprovalSeq) < Integer.parseInt(strApprovalSeq)) ) {
    						strApprovalSeq = Integer.toString(Integer.parseInt(strApprovalSeq) + userApprovalList.size()-1);
    					}

    					bean.setAdmin_line_cd(strAdmin_line_cd);
						bean.setAdmin_line_grp_cd(strAdmin_line_grp_cd);
						bean.setApproval_user_id(strApproval_user_id);
						bean.setApproval_cd(strApproval_cd);
						strApproval_nm = "[필수결재선] " + strApproval_nm + "[" +strDept_nm + "][" + strDuty_nm + "]";
						bean.setApproval_nm(strApproval_nm);
						bean.setApproval_seq(strApprovalSeq);
						bean.setApproval_gb(strApproval_gb);
						bean.setApproval_type(strApproval_type);
						bean.setDuty_nm(strDuty_nm);
						bean.setDept_nm(strDept_nm);
						bean.setGroup_line_grp_cd(strGroup_line_grp_cd);
						bean.setGroup_line_grp_nm(strGroup_line_grp_nm);
						bean.setUser_id(strUser_id);
						bean.setGroup_approval_user_nm(strGroupApprovalUserNm);
						bean.setGroup_approval_user_cd(strGroupApprovalUserCd);

    					ApprovalList.add(bean);
    				}
    			}

    			l = ApprovalList;
    		}else if(itemGb.equals("userLoginHistoryList")){
    			l =  worksUserService.dGetLoginHistoryList(map);
    		}else if(itemGb.equals("folderUserList")) {
    			l = worksUserService.dGetFolderUserList(map);
    		}else if(itemGb.equals("alarmInfo")) {
    			l = commonService.dGetAlarmInfo(map);
    		}else if(itemGb.equals("jobHistoryInfo")){
    			l = commonService.dGetJobHistoryInfo(map);
    		}else if(itemGb.equals("batchReport")) {
    			
    			map.put("p_sched_table", 	CommonUtil.isNull(map.get("p_sched_table")).replaceAll("&apos;","\'"));
    			
    			map.put("s_user_cd", 		CommonUtil.isNull(req.getSession().getAttribute("USER_CD")));
    			map.put("s_user_gb", 		CommonUtil.isNull(req.getSession().getAttribute("USER_GB")));
    			
    			l = emBatchResultTotalService.dGetBatchReport(map);
    		
    		}else if(itemGb.equals("subTableList")) {
    			String[] table_id_list = CommonUtil.isNull(map.get("table_id")).split(",");
    			map.put("table_id_list", table_id_list);
    			l = commonService.dGetSubTableList(map);
    		}else if(itemGb.equals("smartTableTreeList")) {
    			map.put("active_net_name", 		CommonUtil.getCtmActiveNetName(map));
    			l = commonService.dGetSmartTreeList(map);
    		}else if(itemGb.equals("smartTreeInfoList")) {
    			String task_type = CommonUtil.isNull(map.get("task_type"));
    			String rba 		 = CommonUtil.isNull(map.get("rba"));
    			
    			if(task_type.equals("SMART Table")) {
    				map.put("smart_table_rba", rba);
    			}else if(task_type.equals("Sub-Table")){
    				map.put("sub_table_rba", rba);
    			}
    			map.put("active_net_name", 		CommonUtil.getCtmActiveNetName(map));
    			l = commonService.dGetSmartTreeInfoList(map);
    		}
    	}catch(Exception e){
    		throw e;
    	}
    	
		return l;
	}

	@Override
	public String dGetMcodeCd(Map<String, Object> map) {
		
		return commonDao.dGetMcodeCd(map);
	}

	@Override
	public String dGetScodeCd(Map<String, Object> map) {
		
		return commonDao.dGetScodeCd(map);
	}

	@Override
	public Map<String, Object> dPrcMcodeInsert(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		int dup_chk = 0;
		
		try{
			
			dup_chk = commonDao.dGetMcodeDupChk(map);
			
			//if(dup_chk > 0){
				//rtnMap.put("r_code", "-1");
				//rtnMap.put("r_msg", "ERROR.45");
			//}else{
				map.put("mcode_cd", CommonUtil.isNull(commonDao.dGetMcodeCd(map)));
				map.put("mcode_sub_cd", "0");
				rtn = commonDao.dPrcMcodeInsert(map);
				if(rtn > 0){
					rtnMap.put("r_code", "1");
					rtnMap.put("r_msg", "DEBUG.01");
				}else{
					rtnMap.put("r_code", "-1");
					rtnMap.put("r_msg", "ERROR.01");
				}
			//}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}

	@Override
	public Map<String, Object> dPrcMcodeUpdate(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcMcodeUpdate(map);
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
			}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}

	@Override
	public Map<String, Object> dPrcScodeInsert(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		int dup_chk = 0;
		
		try{
			
			dup_chk = commonDao.dGetScodeDupChk(map);
			
			//if(dup_chk > 0){
				//rtnMap.put("r_code", "-1");
				//rtnMap.put("r_msg", "ERROR.45");
			//}else{	
				map.put("scode_cd", CommonUtil.isNull(commonDao.dGetScodeCd(map)));
				rtn = commonDao.dPrcScodeInsert(map);
				if(rtn > 0){
					rtnMap.put("r_code", "1");
					rtnMap.put("r_msg", "DEBUG.01");
				}else{
					rtnMap.put("r_code", "-1");
					rtnMap.put("r_msg", "ERROR.01");
				}
			//}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}

	@Override
	public Map<String, Object> dPrcScodeUpdate(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcScodeUpdate(map);
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
			}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcScodeDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcScodeDelete(map);
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcScodeGroupUpdate(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		String[] arr_scode_cd	   = CommonUtil.isNull(map.get("scode_cd")).split(",", -1);
		String[] arr_order_no	   = CommonUtil.isNull(map.get("order_no")).split(",", -1);
		String[] arr_scode_nm	   = CommonUtil.isNull(map.get("scode_nm")).split(",", -1);
		String[] arr_scode_eng_nm  = CommonUtil.isNull(map.get("scode_eng_nm")).split(",", -1);
		String[] arr_scode_desc	   = CommonUtil.isNull(map.get("scode_desc")).split(",", -1);
		String[] arr_scode_use_yn  = CommonUtil.isNull(map.get("scode_use_yn")).split(",", -1);
		int rtn = 0;
		
		try {
			for(int i = 0; i < arr_scode_cd.length; i++) {
				map.put("scode_cd",		arr_scode_cd[i]);
				map.put("order_no",		arr_order_no[i]);
				map.put("scode_nm",		arr_scode_nm[i]);
				map.put("scode_eng_nm", arr_scode_eng_nm[i]);
				map.put("scode_desc", 	arr_scode_desc[i]);
				map.put("scode_use_yn", arr_scode_use_yn[i]);
				
				if(arr_scode_cd[i].equals("0")) { // 새로 추가된 데이터가 있을때 
					map.put("scode_cd", CommonUtil.isNull(commonDao.dGetScodeCd(map)));
					rtn = commonDao.dPrcScodeInsert(map);
				}else {
					rtn = commonDao.dPrcScodeUpdate(map);
				}
				
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public List<AppGrpBean> dGetAppGrpList(Map<String, Object> map) {
		
		return commonDao.dGetAppGrpList(map);
	}
	
	@Override
	public List<AppGrpBean> dGetAppGrp2List(Map<String, Object> map) {
		
		return commonDao.dGetAppGrp2List(map);
	}
	
	@Override
	public Map<String, Object> dPrcAppGrpExcelInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		Map rMap = new HashMap();
		
		int rtn 		= 0;
		int dup_chk 	= 0;
			
		String[] arr_folder_nm   = CommonUtil.isNull(map.get("folder_nm")).split(",", -1);
		String[] arr_host_nm     = CommonUtil.isNull(map.get("host_nm")).split("[|]", -1);
		String[] arr_user_daily  = CommonUtil.isNull(map.get("user_daliy")).split(",", -1);
		String[] arr_folder_desc = CommonUtil.isNull(map.get("folder_desc")).split(",", -1);
		String[] arr_app_nm		 = CommonUtil.isNull(map.get("app_nm")).split(",", -1);
		String[] arr_app_desc	 = CommonUtil.isNull(map.get("app_desc")).split(",", -1);
		String[] arr_grp_nm 	 = CommonUtil.isNull(map.get("group_nm")).split(",", -1);
		String[] arr_grp_desc 	 = CommonUtil.isNull(map.get("group_desc")).split(",", -1);
		
		String grp_ins_user_cd 	 = CommonUtil.isNull(map.get("s_user_cd"));
		
		map.put("grp_ins_user_cd", grp_ins_user_cd);
		for(int i = 0; i < arr_folder_nm.length; i++) {
			
			// 폴더 추가
			map.put("grp_depth",     "1");
			map.put("grp_eng_nm",    arr_folder_nm[i]);
			map.put("grp_desc",    	 arr_folder_desc[i]);
			map.put("user_daily",    arr_user_daily[i]);
			map.put("grp_parent_cd", "0");
			map.put("v_host_cd", 	 "0");
			dup_chk = commonDao.dGetAppGrpDupChk(map); // 폴더 존재여부 체크
			if( dup_chk == 0 ) {
				int grp_cd = commonDao.dGetAppGrpCd(map);
				map.put("grp_cd",   grp_cd);
				rtn = commonDao.dPrcAppGrpInsert(map);
				if(rtn < 0) break;
				
			}else {
				AppGrpBean bean = commonDao.dGetAppGrpCodeInfo(map);
				
				if( !"".equals(arr_folder_desc[i]) && !arr_folder_desc[i].equals(CommonUtil.isNull(bean.getGrp_desc())) ) {
					map.put("grp_cd",  CommonUtil.isNull(bean.getGrp_cd()));
					rtn = commonDao.dPrcAppGrpUpdate(map);
					if(rtn < 0) break;
					
				}else if( !arr_user_daily[i].equals(CommonUtil.isNull(bean.getUser_daily())) ) {
					System.out.println("arr_user_daily[i]" + arr_user_daily[i]);
					System.out.println("bean.getUser_daily()" + bean.getUser_daily());
					rMap.put("r_code","-1");
					rMap.put("r_msg", (i+1)+"번째 열 등록되어 있는 폴더의 USER_DAILY와 일치하지 않습니다.");
					throw new DefaultServiceException(rMap);
				}
			}
			
			// 호스트 추가
			if(!"".equals(arr_host_nm[i])) {
				
				AppGrpBean bean = commonDao.dGetAppGrpCodeInfo(map);
				String grp_cd	= CommonUtil.isNull(bean.getGrp_cd());
				String[] ins_host = arr_host_nm[i].split(",");
				
				for(int j = 0; j < ins_host.length; j++) {
					map.put("host_nm", ins_host[j]);
					CommonBean host_bean = commonDao.dGetHostInfoChk(map);
					if(host_bean != null) {
						map.put("host_cd", CommonUtil.isNull(host_bean.getHost_cd()));
						int hostMpngChk = commonDao.dGetTableMpngHostChk(map); // 중복등록 방지
						if(hostMpngChk == 0) {
							map.put("flag", "host_udt");
							map.put("grp_cd", grp_cd);
							rtn = commonDao.dPrcGrpHostExcelInsert(map);
						}
						
					}else {
						rMap.put("r_code","-1");
						rMap.put("r_msg", "입력한 데이터를 다시 확인해주세요. \\n\\n * " + (i+1)+"번째 열의 수행서버 : " + ins_host[j]);
						throw new DefaultServiceException(rMap);
					}
				}
				
				
			}
				
			
			// 어플리케이션 추가
			if( !"".equals(arr_app_nm[i])) {
				map.put("grp_depth", 		  "2");
				map.put("grp_eng_nm",   	  arr_app_nm[i]);
				map.put("grp_desc",			  arr_app_desc[i]);
				map.put("search_folder_name", arr_folder_nm[i]);
				AppGrpBean appGrpBean = commonDao.dGetAppParentCd(map);
				if(appGrpBean != null) {
					int grp_cd 		 = commonDao.dGetAppGrpCd(map);
					String parent_cd = CommonUtil.isNull(appGrpBean.getGrp_cd());
					
					map.put("grp_parent_cd", parent_cd);
					map.put("grp_cd",   grp_cd);
					
					dup_chk = commonDao.dGetAppGrpDupChk(map); // 어플리케이션 존재여부 체크
					if(dup_chk == 0) {
						rtn = commonDao.dPrcAppGrpInsert(map);
						if(rtn < 0) break;
					}else {
						AppGrpBean bean = commonDao.dGetAppGrpCodeInfo(map);
						if( !"".equals(arr_app_desc[i]) && !arr_app_desc[i].equals(CommonUtil.isNull(bean.getGrp_desc())) ) {
							map.put("grp_cd",  CommonUtil.isNull(bean.getGrp_cd()));
							rtn = commonDao.dPrcAppGrpUpdate(map);
							if(rtn < 0) break;
						}
					}
				}
			}
			
			// 그룹 추가 
			if( !"".equals(arr_grp_nm[i])) {
				map.put("grp_depth", 		  "3");
				map.put("grp_eng_nm", 		  arr_grp_nm[i]);
				map.put("grp_desc",			  arr_grp_desc[i]);
				map.put("search_folder_name", arr_folder_nm[i]);
				map.put("search_app_name", 	  arr_app_nm[i]);
				
				AppGrpBean appGrpBean = commonDao.dGetGrpParentCd(map);
				if(appGrpBean != null) {
					int grp_cd 		 = commonDao.dGetAppGrpCd(map);
					String parent_cd = CommonUtil.isNull(appGrpBean.getGrp_cd());
					map.put("grp_parent_cd", parent_cd);
					map.put("grp_cd",   grp_cd);
					
					dup_chk = commonDao.dGetAppGrpDupChk(map); // 그룹 존재여부 체크
					if(dup_chk == 0) {
						rtn = commonDao.dPrcAppGrpInsert(map);
						if(rtn < 0) break;
						
					}else {
						AppGrpBean bean = commonDao.dGetAppGrpCodeInfo(map);
						if( !"".equals(arr_grp_desc[i]) && !arr_grp_desc[i].equals(CommonUtil.isNull(bean.getGrp_desc())) ) {
							map.put("grp_cd",  CommonUtil.isNull(bean.getGrp_cd()));
							rtn = commonDao.dPrcAppGrpUpdate(map);
							if(rtn < 0) break;
							
						}
					}
				}else {
					rMap.put("r_code","-1");
					rMap.put("r_msg", (i+1)+"번째 열 폴더명 또는 어플리케이션명이 존재하지 않습니다.");
					
					throw new DefaultServiceException(rMap);
				}
			}
		}
		
		
		if(rtn < 0) {
			map.put("r_code", "1");
			map.put("r_msg", "ERROR.01"); // 처리 실패
		}else {
			map.put("r_code", "1");
			map.put("r_msg", "DEBUG.01"); // 처리 완료
		}
		
		return map;
	}
	
	@Override
	public Map<String, Object> dPrcAppGrpInsert(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		int dup_chk = 0;
		
		try{
			dup_chk = commonDao.dGetAppGrpDupChk(map);
			logger.debug("dup_chk2 : " + dup_chk);
			if(dup_chk > 0){
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.45");
			}else{	
				
				int grp_cd = commonDao.dGetAppGrpCd(map);
					
				map.put("grp_cd", Integer.toString(grp_cd));
				rtn = commonDao.dPrcAppGrpInsert(map);
				logger.debug("rtn : " + rtn);
				if(rtn > 0){
					rtnMap.put("r_code", "1");
					rtnMap.put("r_msg", "DEBUG.01");
				}else{
					rtnMap.put("r_code", "-1");
					rtnMap.put("r_msg", "ERROR.01");
				}
			}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcAppGrpUpdate(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			String host_cd = CommonUtil.isNull(map.get("arr_host_cd"));
			String[] arr_host_cd = null;
			if(!host_cd.equals("")) arr_host_cd = host_cd.split(",");

			rtn = commonDao.dPrcAppGrpUpdate(map); 
			
			if(rtn > 0){
				
				//수행서버 변경 쿼리를 프로시저로 변경하면서 수정하는 부분의 계정입력 부분도 같이 변경되어 
				// flag를 변경해서 프로시저를 호출해야함
				
				//기존 호스트명 제거
				map.put("host_cd", "");
				map.put("flag", "host_del_all");
				commonDao.dPrcGrpHostDelete(map);
				
				//체크된 호스트명만 추가
				map.put("flag", "host_udt");
				if(arr_host_cd != null){
										
					for(int i=0;i<arr_host_cd.length;i++){
						map.put("host_cd", arr_host_cd[i]);
						commonDao.dPrcGrpHostInsert(map);
					}
				}
			
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
			}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcAppGrpDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		int cnt = 0;
		
		try{
			
			//삭제 대상 그룹을 모두 조회한 후, 테이블/어플리케이션/그룹을 삭제한다.
			List<AppGrpBean> appGrpBeanList = commonDao.dGetChildAppGrpCodeList(map);
			
			//테이블/어플리케이션/그룹을 삭제한다.
			rtn = commonDao.dPrcAppGrpDelete(map);
			
			//그룹을 삭제하기 전 ez_user_folder에서 해당 그룹 권한이 들어간 행 삭제
			String grp_depth =  CommonUtil.isNull(map.get("grp_depth"));
			
			if(grp_depth.equals("1")) {
				cnt = commonDao.dPrcUserFloderDelete(map);
			}

			if(rtn > 0){
				//위에서 삭제된 그룹의 mapping된 호스트를 삭제한다(ez_grp_host 테이블).
				map.put("flag", "host_del_all");
				commonDao.dPrcGrpHostDelete(map);
//				for (AppGrpBean appGrpBean : appGrpBeanList) {
//					map.put("grp_cd", appGrpBean.getGrp_cd());
//					commonDao.dPrcGrpHostDelete(map);
//				}
				
				logger.debug("mapping된 호스트를 삭제 정상처리");
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				logger.debug("mapping된 호스트를 삭제 비정상처리");
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
			}
			
		}catch(Exception e){
			logger.debug("dPrcAppGrpDelete 에러 :::" + e.toString());
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public List<CalCodeBean> dGetCalCodeList2(Map<String, Object> map) {
		
		return commonDao.dGetCalCodeList2(map);
	}
	
	@Override
	public JobMapperBean dGetDocFileInfo(Map<String, Object> map) {
		
		return commonDao.dGetDocFileInfo(map);
	}
	
	@Override
	public List<CommonBean> dGetMyWorksInfoList(Map<String, Object> map) {
		
		return commonDao.dGetMyWorksInfoList(map);
	}
	
	@Override
	public List<CommonBean> dGetMyDocInfoCntList(Map<String, Object> map) {
		
		return commonDao.dGetMyDocInfoCntList(map);
	}
	
	@Override
	public List<CommonBean> dGetMyAlarmDocInfoCntList(Map<String, Object> map) {
		
		return commonDao.dGetMyAlarmDocInfoCntList(map);
	}
	
	@Override
	public List<CommonBean> dGetMyApprovalDocInfoList(Map<String, Object> map) {
		
		return commonDao.dGetMyApprovalDocInfoList(map);
	}
	@Override
	public List<CommonBean> dGetExecDocInfoList(Map<String, Object> map) {
		
		return commonDao.dGetExecDocInfoList(map);
	}
	
	@Override
	public List<CommonBean> dGetMyWorkList(Map<String, Object> map) {
		
		return commonDao.dGetMyWorkList(map);
	}
	
	@Override
	public String dGetCtmActiveNetName(Map<String, Object> map) {
		
		return commonDao.dGetCtmActiveNetName(map);
	}
	
	@Override
	public String dGetMainAllDocInfoCnt(Map<String, Object> map) {
		
		return commonDao.dGetMainAllDocInfoCnt(map);
	}
	
	@Override
	public List<DocInfoBean> dGetMainAllDocInfoList(Map<String, Object> map) {
		
		return commonDao.dGetMainAllDocInfoList(map);
	}
	
	@Override
	public List<CommonBean> dGetCtmLogList(Map<String, Object> map) {
		
		return commonDao.dGetCtmLogList(map);
	}
	
	@Override
	public List<CommonBean> dGetUserApprovalGroup(Map<String, Object> map) {
		
		return commonDao.dGetUserApprovalGroup(map);
	}
	
	
	
	@Override
	public List<CommonBean> dGetUserApprovalLine(Map<String, Object> map) {
		
		return commonDao.dGetUserApprovalLine(map);
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalGroupInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
	
		String strUseYn = CommonUtil.isNull(map.get("use_yn"));
		int iCnt		= 0;
		
		if ( strUseYn.equals("Y") ) {
			iCnt = 1;
		}
		
		// 결재선 사용은 한개만 존재해야 함.
		CommonBean bean = commonDao.dGetChkUserApprovalUseCnt(map);
		
		if ( (bean.getTotal_count() + iCnt) > 1 ) {			
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.48");
			throw new DefaultServiceException(rMap);
		}
		
		int seq = commonDao.dGetUserApprovalGroupSeq(map);
		map.put("line_grp_cd", seq);
		
		rtn = commonDao.dPrcUserApprovalGroupInsert(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalGroupUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		String strUseYn = CommonUtil.isNull(map.get("use_yn"));
		int iCnt		= 0;
		
		if ( strUseYn.equals("Y") ) {
			iCnt = 1;
		}
		
		// 결재선 사용은 한개만 존재해야 함.
		CommonBean bean = commonDao.dGetChkUserApprovalUseCnt(map);
		
		if ( (bean.getTotal_count() + iCnt) > 1 ) {			
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.48");
			throw new DefaultServiceException(rMap);
		}
		
		rtn = commonDao.dPrcUserApprovalGroupUpdate(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}

		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalGroupDelete(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcUserApprovalGroupDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalGroupTotalUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		String[] arr_line_grp_cd 	= CommonUtil.isNull(map.get("line_grp_cd")).split(",", -1);
		String[] arr_line_grp_nm    = CommonUtil.isNull(map.get("line_grp_nm")).split(",", -1);
		String[] arr_use_yn 		= CommonUtil.isNull(map.get("use_yn")).split(",", -1);
		
		for(int i = 0; i < arr_line_grp_cd.length; i++) {
			map.put("line_grp_cd", 	   arr_line_grp_cd[i]);
			map.put("line_grp_nm", arr_line_grp_nm[i]);
			map.put("use_yn",      arr_use_yn[i]);
			
			if(arr_line_grp_cd[i].equals("0")) {
				arr_line_grp_cd[i] = Integer.toString(commonDao.dGetUserApprovalGroupSeq(map));
				map.put("line_grp_cd", arr_line_grp_cd[i]);
				rtn = commonDao.dPrcUserApprovalGroupInsert(map);
			}else {
				rtn = commonDao.dPrcUserApprovalGroupUpdate(map);
			}
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
			}
			
		}
		
		// 결재선 사용은 한개만 존재해야 함.
		CommonBean bean = commonDao.dGetChkUserApprovalUseCnt(map);
		if( bean.getTotal_count() > 1) {
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.48");
			throw new DefaultServiceException(rMap);
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalLineInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		// 결재 순서 중복 체크.
		int approval_seq_cnt = commonDao.dGetUserApprovalLineApprovalSeqCnt(map);
		
		if ( approval_seq_cnt > 0 ) {
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.30");
			throw new DefaultServiceException(rMap);
		}
		
		// 결재자 유형 중복 체크.
//		int approval_gb_cnt = commonDao.dGetUserApprovalLineApprovalGbCnt(map);
//		
//		if ( approval_gb_cnt > 0 ) {
//			Map rMap = new HashMap();
//			rMap.put("r_code","-1");
//			rMap.put("r_msg","ERROR.51");
//			throw new DefaultServiceException(rMap);
//		}
		
		// 결재자 중복 체크.
		int approval_user_cnt = commonDao.dGetUserApprovalLineApprovalUserCnt(map);
		
		if ( approval_user_cnt > 0 ) {
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.81");
			throw new DefaultServiceException(rMap);
		}
		
		int seq = commonDao.dGetUserApprovalLineSeq(map);
		map.put("line_cd", seq);
		
		rtn = commonDao.dPrcUserApprovalLineInsert(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalLineUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		rtn = commonDao.dPrcUserApprovalLineUpdate(map);
		
		if(rtn > 0){
			
			// 결재 순서 중복 체크.
			int approval_seq_cnt = commonDao.dGetUserApprovalLineApprovalSeqCnt(map);			
			
			if ( approval_seq_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.30");
				throw new DefaultServiceException(rMap);
			}
			
			// 결재자 유형 중복 체크.
			int approval_gb_cnt = commonDao.dGetUserApprovalLineApprovalGbCnt(map);
			
			if ( approval_gb_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.51");
				throw new DefaultServiceException(rMap);
			}
			
			// 결재자 중복 체크.
			int approval_user_cnt = commonDao.dGetUserApprovalLineApprovalUserCnt(map);
			
			if ( approval_user_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.81");
				throw new DefaultServiceException(rMap);
			}
			
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
	
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalLineDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcUserApprovalLineDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcUserApprovalLineGroupUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		
		String[] arr_line_cd 		= CommonUtil.isNull(map.get("line_cd")).split(",", -1);
		String[] arr_approval_cd  	= CommonUtil.isNull(map.get("approval_cd")).split(",", -1);
		String[] arr_approval_seq 	= CommonUtil.isNull(map.get("approval_seq")).split(",", -1);
		
		// 결재자 수정 업데이트
		for(int i = 0; i < arr_line_cd.length; i++) {
			int rtn = 0;
			
			map.put("line_cd", arr_line_cd[i]);
			map.put("approval_cd", arr_approval_cd[i]);
			map.put("approval_seq", arr_approval_seq[i]);
			if( arr_line_cd[i].equals("0") ) {
				arr_line_cd[i] = Integer.toString(commonDao.dGetUserApprovalLineSeq(map));
				map.put("line_cd", arr_line_cd[i]);
				rtn = commonDao.dPrcUserApprovalLineInsert(map);
			}else {
				rtn = commonDao.dPrcUserApprovalLineUpdate(map);
			}
			if(rtn < 1){
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
				throw new DefaultServiceException(rtnMap);
			}
		}
		// 결재자 수정 후 중복 체크로직
		for(int i = 0; i < arr_line_cd.length; i++) {
			map.put("line_cd", arr_line_cd[i]);
			map.put("approval_cd", arr_approval_cd[i]);
			map.put("approval_seq", arr_approval_seq[i]);
			
			
			// 결재 순서 중복 체크.
			int approval_seq_cnt = commonDao.dGetUserApprovalLineApprovalSeqCnt(map);			
			if ( approval_seq_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.30");
				throw new DefaultServiceException(rMap);
			}
			
			// 결재자 유형 중복 체크.
			int approval_gb_cnt = commonDao.dGetUserApprovalLineApprovalGbCnt(map);
			if ( approval_gb_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.51");
				throw new DefaultServiceException(rMap);
			}
			
			// 결재자 중복 체크.
			int approval_user_cnt = commonDao.dGetUserApprovalLineApprovalUserCnt(map);
			if ( approval_user_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.81");
				throw new DefaultServiceException(rMap);
			}
			
		}
		
		rtnMap.put("r_code", "1");
		rtnMap.put("r_msg", "DEBUG.01");
		return rtnMap;
	}
	
	@Override
	public List<CommonBean> dGetWorkGroupList(Map<String, Object> map) {
		
		return commonDao.dGetWorkGroupList(map);
	}
	
	@Override
	public List<CommonBean> dGetAdminApprovalGroup(Map<String, Object> map) {
		
		return commonDao.dGetAdminApprovalGroup(map);
	}
	
	@Override
	public List<CommonBean> dGetAdminApprovalLine(Map<String, Object> map) {
		
		return commonDao.dGetAdminApprovalLine(map);
	}
	
	@Override
	public List<CommonBean> dGetAdminApprovalLine_u(Map<String, Object> map) {
		List<CommonBean> result = commonDao.dGetAdminApprovalLine_u(map);
		return result;
	}
	
	@Override
	public List<CommonBean> dGetApproavlGroupCnt(Map<String, Object> map) {
		List<CommonBean> result = commonDao.dGetApproavlGroupCnt(map);
		return result;
	}

	@Override
	public Map<String, Object> dPrcAdminApprovalGroupInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
//		필수결재선그룹 사용여부 안씀. 무조건 사용.
		map.put("use_yn", "Y");
		
		String[] arr_admin_line_grp_cd = CommonUtil.isNull(map.get("admin_line_grp_cd")).split(",", -1);
		String[] arr_admin_line_grp_nm = CommonUtil.isNull(map.get("admin_line_grp_nm")).split(",", -1);
		String[] arr_doc_gubun		   = CommonUtil.isNull(map.get("doc_gubun")).split(",", -1);
		String[] arr_post_approval_yn  = CommonUtil.isNull(map.get("post_approval_yn")).split(",", -1);
		
		for(int i = 0; i < arr_admin_line_grp_cd.length; i++) {
			map.put("admin_line_grp_cd", arr_admin_line_grp_cd[i]);
			map.put("admin_line_grp_nm", arr_admin_line_grp_nm[i]);
			map.put("doc_gubun", 		 arr_doc_gubun[i]);
			map.put("post_approval_yn",  arr_post_approval_yn[i]);
			
			if(arr_admin_line_grp_cd[i].equals("0")) { // 신규 추가일 경우
				arr_admin_line_grp_cd[i] = Integer.toString(commonDao.dGetAdminApprovalGroupSeq(map));
				map.put("admin_line_grp_cd", arr_admin_line_grp_cd[i]);
				rtn = commonDao.dPrcAdminApprovalGroupInsert(map);
			}else {
				rtn = commonDao.dPrcAdminApprovalGroupUpdate(map);
			}
			
			if(rtn < 1){
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
				throw new DefaultServiceException(rtnMap);
			}
			
		}
		
		// 중복체크
		for(int i = 0; i < arr_admin_line_grp_cd.length; i++) {
			map.put("doc_gubun", 		 arr_doc_gubun[i]);
			map.put("post_approval_yn",  arr_post_approval_yn[i]);
			
			int chk_admin_approval_line_cnt = commonDao.dGetAdminApprovalGroupChkCnt(map);
			if(chk_admin_approval_line_cnt > 1) {
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.85");
				throw new DefaultServiceException(rtnMap);
			}
		}
		
		rtnMap.put("r_code", "1");
		rtnMap.put("r_msg", "DEBUG.01");
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcAdminApprovalGroupUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
//		필수결재선그룹 사용여부 안씀. 무조건 사용.
		map.put("use_yn", "Y");
//		String strUseYn = CommonUtil.isNull(map.get("use_yn"));
//		int iCnt		= 0;
//		
//		if ( strUseYn.equals("Y") ) {
//			iCnt = 1;
//		}
//		
//		// 결재선 사용은 한개만 존재해야 함.
//		CommonBean bean = commonDao.dGetChkAdminApprovalUseCnt(map);
//		
//		if ( (bean.getTotal_count() + iCnt) > 1 ) {			
//			Map rMap = new HashMap();
//			rMap.put("r_code","-1");
//			rMap.put("r_msg","ERROR.48");
//			throw new DefaultServiceException(rMap);
//		}
		
		rtn = commonDao.dPrcAdminApprovalGroupUpdate(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}

		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcAdminApprovalGroupDelete(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcAdminApprovalGroupDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcAdminApprovalLineInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		String approval_cd = CommonUtil.isNull(map.get("approval_cd")).toString();
		// 결재 순서 중복 체크.
		int approval_seq_cnt = commonDao.dGetAdminApprovalLineApprovalSeqCnt(map);			
		
		if ( approval_seq_cnt > 0 ) {
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.30");
			throw new DefaultServiceException(rMap);
		}
		
		if(!approval_cd.equals("")) {
			// 결재자 중복 체크
			int approval_cd_cnt = commonDao.dGetAdminApprovalLineApprovalCdCnt(map);			
			
			if ( approval_cd_cnt > 0 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.29");
				throw new DefaultServiceException(rMap);
			}			
		}
		
		// 결재자 유형 중복 체크. ==> 결재구분 중복 체크(2020.05.12, 김수정)
		// JT 중복결재자 사용으로 주석처리(2021.04.01, 김수정)
//		int approval_gb_cnt = commonDao.dGetAdminApprovalLineApprovalGbCnt(map);
//		
//		if ( approval_gb_cnt > 0 ) {
//			Map rMap = new HashMap();
//			rMap.put("r_code","-1");
//			rMap.put("r_msg","ERROR.51");
//			throw new DefaultServiceException(rMap);
//		}
		
		int seq = commonDao.dGetAdminApprovalLineSeq(map);
		map.put("admin_line_cd", seq);
		
		// 후결 이후 순차결재 불가.
		checkApprovalInOrder(map);
		
		rtn = commonDao.dPrcAdminApprovalLineInsert(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
	
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcAdminApprovalLineUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		String approval_cd = CommonUtil.isNull(map.get("approval_cd")).toString();
		
		rtn = commonDao.dPrcAdminApprovalLineUpdate(map);
		
		if(rtn > 0){
			
			// 결재 순서 중복 체크.
			int approval_seq_cnt = commonDao.dGetAdminApprovalLineApprovalSeqCnt(map);			
			
			if ( approval_seq_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.30");
				throw new DefaultServiceException(rMap);
			}
			
			if(!approval_cd.equals("")) {
				// 결재자 중복 체크
				int approval_cd_cnt = commonDao.dGetAdminApprovalLineApprovalCdCnt(map);			
				
				if ( approval_cd_cnt > 1 ) {
					Map rMap = new HashMap();
					rMap.put("r_code","-1");
					rMap.put("r_msg","ERROR.29");
					throw new DefaultServiceException(rMap);
				}			
			}
			
			// 결재자 유형 중복 체크. ==> 결재구분 중복 체크(2020.05.12, 김수정)
			// JT 중복결재자 사용으로 주석처리(2021.04.01, 김수정)
//			int approval_gb_cnt = commonDao.dGetAdminApprovalLineApprovalGbCnt(map);
//			
//			if ( approval_gb_cnt > 1 ) {
//				Map rMap = new HashMap();
//				rMap.put("r_code","-1");
//				rMap.put("r_msg","ERROR.51");
//				throw new DefaultServiceException(rMap);
//			}
			
			// 후결 이후 순차결재 불가.
			checkApprovalInOrder(map);
			
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
	
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcAdminApprovalLineGroupUpdate(Map<String, Object> map) throws Exception {
		Map<String, Object> rtnMap = new HashMap<>();
		
		String[] arr_admin_line_cd		= CommonUtil.isNull(map.get("admin_line_cd")).split(",", -1);
		String[] arr_approval_cd 		= CommonUtil.isNull(map.get("approval_cd")).split(",", -1);
		String[] arr_group_line_grp_cd 	= CommonUtil.isNull(map.get("group_line_grp_cd")).split(",", -1);
		String[] arr_approval_seq 		= CommonUtil.isNull(map.get("approval_seq")).split(",", -1);
		String[] arr_approval_gb 		= CommonUtil.isNull(map.get("approval_gb")).split(",", -1);
		String[] arr_approval_type 		= CommonUtil.isNull(map.get("approval_type")).split(",", -1);
		
		for(int i = 0 ; i < arr_admin_line_cd.length; i++) {
			int rtn = 0;
			
			map.put("admin_line_cd", 	 arr_admin_line_cd[i]);
			map.put("approval_cd", 		 arr_approval_cd[i]);
			map.put("group_line_grp_cd", arr_group_line_grp_cd[i]);
			map.put("approval_seq", 	 arr_approval_seq[i]);
			map.put("approval_gb", 		 arr_approval_gb[i]);
			map.put("approval_type", 	arr_approval_type[i]);
			
			if(arr_admin_line_cd[i].equals("0")) { // 추가된 데이터가 있을때
				arr_admin_line_cd[i] = Integer.toString(commonDao.dGetAdminApprovalLineSeq(map));
				map.put("admin_line_cd", arr_admin_line_cd[i]);
				rtn = commonDao.dPrcAdminApprovalLineInsert(map);
			}else { // 수정된 데이터만 있을때
				rtn = commonDao.dPrcAdminApprovalLineUpdate(map);
			}
			
			if(rtn < 1){
				rtnMap.put("r_code", "-1");
				rtnMap.put("r_msg", "ERROR.01");
				throw new DefaultServiceException(rtnMap);
			}
		}
		
		// 중복 체크로직
		for(int i = 0 ; i < arr_admin_line_cd.length; i++) {
			map.put("admin_line_cd", 	 	arr_admin_line_cd[i]);
			map.put("approval_cd", 		 	arr_approval_cd[i]);
			map.put("group_line_grp_cd", 	arr_group_line_grp_cd[i]);
			map.put("approval_seq", 	 	arr_approval_seq[i]);
			map.put("approval_gb", 		 	arr_approval_gb[i]);
			map.put("approval_type", 		arr_approval_type[i]);
			
			// 결재 순서 중복 체크.
			int approval_seq_cnt = commonDao.dGetAdminApprovalLineApprovalSeqCnt(map);			
			if ( approval_seq_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.30");
				throw new DefaultServiceException(rMap);
			}
			// 결재자 중복 체크
			if(!arr_approval_cd[i].equals("")) {
				int approval_cd_cnt = commonDao.dGetAdminApprovalLineApprovalCdCnt(map);			
				if ( approval_cd_cnt > 1 ) {
					Map rMap = new HashMap();
					rMap.put("r_code","-1");
					rMap.put("r_msg","ERROR.29");
					throw new DefaultServiceException(rMap);
				}
			}
			
			// 후결 이후 순차결재 불가.
			checkApprovalInOrder(map);
			
		}
		
		rtnMap.put("r_code", "1");
		rtnMap.put("r_msg", "DEBUG.01");
		
		return rtnMap;
	}
	
	public void checkApprovalInOrder(Map map) throws Exception {
		String u_approval_type = (String)map.get("approval_type");
		int u_admin_line_cd = Integer.parseInt(map.get("admin_line_cd").toString());
		int u_approval_seq = Integer.parseInt(map.get("approval_seq").toString());

		List<CommonBean> beanList = commonDao.dGetAdminApprovalLine(map);
		
		boolean isError01 = false;
		boolean isError03 = false;

		if (u_approval_type.equals("01")) { //수정/삽입할 결재선이 순차결재일 때,
			for (CommonBean bean : beanList) {
				// 해당 결재선 이후의 결재선이 후결(03)이면 삽입/수정불가
				if (Integer.parseInt(bean.getAdmin_line_cd()) < u_admin_line_cd && bean.getApproval_type().equals("03") && Integer.parseInt(bean.getApproval_seq()) < u_approval_seq ) {
					isError01 = true;
				}
			}	
		} else if (u_approval_type.equals("03")) { //수정/삽입할 결재선이 후결일 때,
			for (CommonBean bean: beanList) {
				// 해당 결재선 이후의 결재선이 순차결재(01)이면 삽입/수정불가
				//if ((Integer.parseInt(bean.getAdmin_line_cd()) > u_admin_line_cd && bean.getApproval_type().equals("01")) || Integer.parseInt(bean.getApproval_seq()) < u_approval_seq) {
				if ( Integer.parseInt(bean.getApproval_seq()) > u_approval_seq && bean.getApproval_type().equals("01"))  {
						isError03 = true;
				}

			}
		}
		
		if(isError01) { // 후결 결재선 이후 순차결재선을 설정할 수 없습니다.
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.55");
			throw new DefaultServiceException(rMap);			
		}

		if(isError03) { // 순차 결재선 이전 후결결재선을 설정할 수 없습니다.
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.79");
			throw new DefaultServiceException(rMap);
		}
	}
	
	@Override
	public Map<String, Object> dPrcAdminApprovalLineDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcAdminApprovalLineDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public List<CommonBean> dGetGroupApprovalGroup(Map<String, Object> map) {
		
		return commonDao.dGetGroupApprovalGroup(map);
	}
	
	@Override
	public List<CommonBean> dGetGroupApprovalLine(Map<String, Object> map) {
		
		return commonDao.dGetGroupApprovalLine(map);
	}
	
	@Override
	public Map<String, Object> dPrcGroupApprovalGroupInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;	
		
		int seq = commonDao.dGetGroupApprovalGroupSeq(map);
		map.put("group_line_grp_cd", seq);
		
		rtn = commonDao.dPrcGroupApprovalGroupInsert(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupApprovalGroupUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;		
		
		rtn = commonDao.dPrcGroupApprovalGroupUpdate(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}

		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupApprovalGroupDelete(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		int usingCnt = 0;
		
		try{
			CommonService commonService = (CommonService)CommonUtil.getSpringBean("commonService");
			
			List<CommonBean> groupList = commonService.dGetApproavlGroupCnt(map);
			
			usingCnt = groupList.size();
			
			if(usingCnt != 0) {
				Map rMap = new HashMap();
				rtnMap.put("r_code","-2");
				rtnMap.put("r_msg","ERROR.71");
			}else {
				rtn = commonDao.dPrcGroupApprovalGroupDelete(map);
				if(rtn > 0){
					rtnMap.put("r_code", "1");
					rtnMap.put("r_msg", "DEBUG.01");
				}else{
					rtnMap.put("r_code", "1");
					rtnMap.put("r_msg", "DEBUG.01");
				}
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupApprovalLineInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;

		// 결재 순서 중복 체크.
		/*
		int approval_seq_cnt = commonDao.dGetGroupApprovalLineApprovalSeqCnt(map);			
		
		if ( approval_seq_cnt > 0 ) {
			Map rMap = new HashMap();
			rMap.put("r_code","-1");
			rMap.put("r_msg","ERROR.30");
			throw new DefaultServiceException(rMap);
		}
		*/
		
		int seq = commonDao.dGetGroupApprovalLineSeq(map);
		map.put("group_line_cd", seq);
		
		rtn = commonDao.dPrcGroupApprovalLineInsert(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}

		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupApprovalLineUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		rtn = commonDao.dPrcGroupApprovalLineUpdate(map);
			
		if(rtn > 0){
			
			// 결재 순서 중복 체크.
			/*
			int approval_seq_cnt = commonDao.dGetGroupApprovalLineApprovalSeqCnt(map);			
			
			if ( approval_seq_cnt > 1 ) {
				Map rMap = new HashMap();
				rMap.put("r_code","-1");
				rMap.put("r_msg","ERROR.30");
				throw new DefaultServiceException(rMap);
			}
			*/
			
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupApprovalLineDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcGroupApprovalLineDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public int dGetDefTableCnt(Map<String, Object> map) {
		
		// 서브 폴더일 경우 최상단 폴더만 추출해서 전달
		String strTableName = CommonUtil.isNull(map.get("table_name"));
		if( strTableName.indexOf("/") > -1 ) {
			strTableName = strTableName.substring(0, strTableName.lastIndexOf('/'));
		}
		
		map.put("table_name", strTableName);
		
		return commonDao.dGetDefTableCnt(map);
	}
	
	@Override
	public Map<String, Object> dPrcCtmAgentInfoUpdate(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcCtmAgentInfoUpdate(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Doc06Bean dGetDoc06FileInfo(Map<String, Object> map) {
		
		return commonDao.dGetDoc06FileInfo(map);
	}
	
	@Override
	public Map<String, Object> dPrcGrpHostInsert(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
	
		try{
			
			String host_cd = CommonUtil.isNull(map.get("host_cd"));
			
			StringTokenizer st = new StringTokenizer(host_cd, ",");
			
			String v_host_cd = "";
			while(st.hasMoreTokens()){
				v_host_cd = st.nextToken();
			
				map.put("host_cd", v_host_cd);
				map.put("flag", "host_udt");

				commonDao.dPrcGrpHostInsert(map);
			}			
			
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGrpHostUpdate(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
	
		try{
			
			String grp_cd = CommonUtil.isNull(map.get("grp_cd"));
			String[] chk_grp_cd = grp_cd.split(",");
			
			String host_cd = CommonUtil.isNull(map.get("host_cd"));
			String[] chk_host_cd = host_cd.split(",");
			
			for(int i=0;i<chk_grp_cd.length;i++) {
				for(int j=0;j<chk_host_cd.length;j++) {
					logger.error(chk_grp_cd.length);
					logger.error(chk_host_cd.length);
					
					map.put("grp_cd", chk_grp_cd[i]);
					map.put("host_cd", chk_host_cd[j]);
					
					commonDao.dPrcGrpHostInsert(map);
				}
			}
			
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGrpHostsDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
				String grp_cd = CommonUtil.isNull(map.get("grp_cd"));
				String[] chk_grp_cd = grp_cd.split(",");
				String host_cd = CommonUtil.isNull(map.get("host_cd"));
				String[] chk_host_cd = host_cd.split(",");
				//StringTokenizer st = new StringTokenizer(host_cd, ",");
				
				String v_host_cd = "";

				for(int i=0;i<chk_grp_cd.length;i++) {
					for(int j=0;j<chk_host_cd.length;j++) {
						logger.error("chk_grp_cd.length : " + chk_grp_cd.length);
						logger.error("chk_host_cd.length : " + chk_host_cd.length);
						
						map.put("grp_cd", chk_grp_cd[i]);
						map.put("host_cd", chk_host_cd[j]);
						
						rtn = commonDao.dPrcGrpHostDelete(map);
					}
				}
				
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGrpHostDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{			
			rtn = commonDao.dPrcGrpHostDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public List<CommonBean> dGetMHostList(Map<String, Object> map) {
		
		return commonDao.dGetMHostList(map);
	}
	
	@Override
	public List<CommonBean> dGetHostInfoList(Map<String, Object> map) {
		
		return commonDao.dGetHostInfoList(map);
	}
	
	@Override
	public List<CommonBean> dGetArgumentList(Map<String, Object> map) {
		
		return commonDao.dGetArgumentList(map);
	}
	
	
	public List dcheckIfName(String ifName) throws Exception {
		
		return SendIfCheck.SendIfCheck(ifName);		
	}
	
	public List<CommonBean> dGetSrList(Map<String, Object> map) {
		
		Connection con 			= null;
		PreparedStatement pstmt = null;
		ResultSet rs 			= null;
		String sql 				= "";
		
		String sr_search_text	= CommonUtil.isNull(map.get("sr_search_text"));
		String sr_search_gubun	= CommonUtil.isNull(map.get("sr_search_gubun"));		
		String search_sql		= "";
		
		ArrayList srList 		= new ArrayList<>();
		
		try {
			
			String strSrHost 	= CommonUtil.isNull(CommonUtil.getMessage("SR.HOST"));
			String strSrPort 	= CommonUtil.isNull(CommonUtil.getMessage("SR.PORT"));
			String strSrSid 	= CommonUtil.isNull(CommonUtil.getMessage("SR.SID"));
			String strSrId 		= CommonUtil.isNull(CommonUtil.getMessage("SR.ID"));
			String strSrPasswd 	= CommonUtil.isNull(CommonUtil.getMessage("SR.PASSWD"));
			
			con = DbUtil.getConnection("OR", strSrHost, strSrPort, strSrSid, strSrId, strSrPasswd);
			
			sql = 	"select sreq_code, sreq_title, pm_nm, sreq_planmh, sreq_resmh 	";
			sql += 	"  from wpms.v_srlist_woori ";
			sql += 	" where 1 = 1 ";
			
			if ( !sr_search_text.equals("") ) {
				if ( sr_search_gubun.equals("sreq_code") ) {
					search_sql = " and " + sr_search_gubun + " = '" + sr_search_text + "'";
				} else {
					search_sql = " and " + sr_search_gubun + " LIKE '%" + sr_search_text + "%'";
				}
			}
			
			sql += search_sql;
			
			pstmt 	= con.prepareStatement(sql);
			rs		= pstmt.executeQuery();
			
			while(rs.next()) {
				
				CommonBean commonBean 	= new CommonBean();
				
				String sreq_code	= CommonUtil.isNull(rs.getString(1));
				String sreq_title 	= CommonUtil.isNull(rs.getString(2));
				String pm_nm 		= CommonUtil.isNull(rs.getString(3));
				String sreq_planmh 	= CommonUtil.isNull(rs.getString(4));
				String sreq_resmh 	= CommonUtil.isNull(rs.getString(5));
				
				commonBean.setSreq_code(sreq_code);
				commonBean.setSreq_title(sreq_title);
				commonBean.setPm_nm(pm_nm);
				commonBean.setSreq_planmh(sreq_planmh);
				commonBean.setSreq_resmh(sreq_resmh);
				
				srList.add(commonBean);
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return srList;
	}
	
	@Override
	public List<CommonBean> dGetCmsNodGrpList(Map map) {
		
		return commonDao.dGetCmsNodGrpList(map);
	}
	
	@Override
	public List<CommonBean> dGetCmsNodGrpNodeList(Map map) {
		
		return commonDao.dGetCmsNodGrpNodeList(map);
	}
	
	@Override
	public List<CommonBean> dGetCheckSmartTableCnt(Map map) {
		
		return commonDao.dGetCheckSmartTableCnt(map);
	}
	
	public List<CommonBean> dGetUserDailyNameList(Map map){
		return commonDao.dGetUserDailyNameList(map);
	}

	public CommonBean dGetHolidayCheck(Map map){
		return commonDao.dGetHolidayCheck(map);
	}

	public void dDblinkConnect(){
		commonDao.dblinkConnect();
	}
	
	public void dDblinkDisconnect(){
		commonDao.dblinkdisConnect(); 
	}

	public List<CtmInfoBean> dGetJobCondList(Map map) {
		return commonDao.dGetJobCondList(map);
	}
	
	//smartforder
	public List<CommonBean> dGetsForderList(Map map){
		return commonDao.dGetsForderList(map);
	}

	@Override
	public String dGetNodeInfo(Map<String, Object> map) {
		return commonDao.dGetNodeInfo(map);
	}

	@Override
	public List dGetBatchTotal(Map map) {
		return commonDao.dGetBatchTotal(map);
	}

	@Override
	public List dGetDocApprovalTotal(Map map) {
		return commonDao.dGetDocApprovalTotal(map);
	}

	@Override
	public List dGetJobCondTotal(Map map) {
		return commonDao.dGetJobCondTotal(map);
	}

	@Override
	public List dGetErrorLogTotal(Map map) {
		return commonDao.dGetErrorLogTotal(map);
	}
	
	@Override
	public Map<String, Object> dPrcCmAppGrpInsert(Map<String, Object> paramMap) {
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		String grp_depth = CommonUtil.isNull(paramMap.get("p_grp_depth"));
		String[] eng_nm_arr = ((String)paramMap.get("p_grp_eng_nm")).split(",");
		String[] parent_cd_arr = null;
		String[] table_type_arr = null;
		String[] user_daily_arr = null;
		
		paramMap.put("grp_depth", grp_depth);
		paramMap.put("grp_use_yn", "Y");
		paramMap.put("grp_ins_user_cd", paramMap.get("s_user_cd"));
		paramMap.put("scode_cd", paramMap.get("p_scode_cd"));
		paramMap.put("v_host_cd", "0");
		if ("1".equals(grp_depth)) { 	//폴더
			paramMap.put("grp_parent_cd", "0");
//			paramMap.put("user_daily", "SYSTEM");
			table_type_arr = ((String)paramMap.get("p_grp_table_type")).split(",");
			user_daily_arr = ((String)paramMap.get("p_user_daily")).split(",",-1);
		} else {
			parent_cd_arr = ((String)paramMap.get("p_grp_parent_cd")).split(",");
		}
		for (int i = 0; i < eng_nm_arr.length; i++) {
			paramMap.put("grp_eng_nm", eng_nm_arr[i]);
			paramMap.put("grp_desc", eng_nm_arr[i]);
			
				if ("1".equals(grp_depth)) {
					paramMap.put("table_type", table_type_arr[i]);
					
					if(CommonUtil.isNull(user_daily_arr[i]).equals("undefined") || CommonUtil.isNull(user_daily_arr[i]).equals("")) {
						paramMap.put("user_daily", "");
					}else {
						paramMap.put("user_daily", CommonUtil.isNull(user_daily_arr[i]));
					}
					
				} else {
					paramMap.put("grp_parent_cd", parent_cd_arr[i]);
					paramMap.put("table_type", "1");
					paramMap.put("user_daily", "");
				}

			rMap = dPrcAppGrpInsert(paramMap); //기존 insert 사용.
			if (!"1".equals(rMap.get("r_code")))
				return rMap;
		}
			
		return rMap;
	}
	
	@Override
	public List<CommonBean> dGetGroupUserGroup(Map<String, Object> map) {
		
		return commonDao.dGetGroupUserGroup(map);
	}
	
	@Override
	public Map<String, Object> dPrcGroupUserGroupInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;	
		
		int seq = commonDao.dGetGroupUserGroupSeq(map);
		map.put("group_user_group_cd", seq);
		
		rtn = commonDao.dPrcGroupUserGroupInsert(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupUserGroupUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;		
		
		rtn = commonDao.dPrcGroupUserGroupUpdate(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}

		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupUserGroupDelete(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcGroupUserGroupDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public List<CommonBean> dGetGroupUserLine(Map<String, Object> map) {
		
		return commonDao.dGetGroupUserLine(map);
	}
	
	@Override
	public List<CommonBean> dGetAdminApprovalLineCd(Map<String, Object> map) {
		
		return commonDao.dGetAdminApprovalLineCd(map);
	}
	
	@Override
	public List<CommonBean> dGetAdminApprovalLineList(Map<String, Object> map) {
		
		return commonDao.dGetAdminApprovalLineList(map);
	}
	
	@Override
	public Map<String, Object> dPrcGroupUserLineInsert(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;

		int seq = commonDao.dGetGroupUserLineSeq(map);
		map.put("group_user_line_cd", seq);
		
		rtn = commonDao.dPrcGroupUserLineInsert(map);
		
		if(rtn > 0){
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}

		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupUserLineUpdate(Map<String, Object> map) throws Exception {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		rtn = commonDao.dPrcGroupUserLineUpdate(map);
			
		if(rtn > 0){
			
			rtnMap.put("r_code", "1");
			rtnMap.put("r_msg", "DEBUG.01");
		}else{
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
	
	@Override
	public Map<String, Object> dPrcGroupUserLineDelete(Map<String, Object> map) {
		
		Map<String, Object> rtnMap = new HashMap<>();
		int rtn = 0;
		
		try{
			
			rtn = commonDao.dPrcGroupUserLineDelete(map);
			
			if(rtn > 0){
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}else{
				rtnMap.put("r_code", "1");
				rtnMap.put("r_msg", "DEBUG.01");
			}
			
		}catch(Exception e){
			rtnMap.put("r_code", "-1");
			rtnMap.put("r_msg", "ERROR.01");
		}
		
		return rtnMap;
	}
}
