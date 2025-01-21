package com.ghayoun.ezjobs.t.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.math.DoubleRange;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.util.SystemOutLogger;
import org.json.JSONArray;
import org.json.JSONObject;
import org.quartz.JobDataMap;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bmc.ctmem.schema900.AndOrType;
import com.bmc.ctmem.schema900.InConditionType;
import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.domain.AppGrpBean;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.common.axis.ConnectionManager;
import com.ghayoun.ezjobs.common.util.AAPI_Util;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.CommonWorksUtil;
import com.ghayoun.ezjobs.common.util.DateUtil;
import com.ghayoun.ezjobs.common.util.DbUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.ExcelUtil;
import com.ghayoun.ezjobs.common.util.FileUtil;
import com.ghayoun.ezjobs.common.util.SeedUtil;
import com.ghayoun.ezjobs.common.util.SendIfCheck;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.SshEncodeUtil;
import com.ghayoun.ezjobs.common.util.SshUtil;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.m.domain.CtmInfoBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.m.repository.EmBatchResultTotalDao;
import com.ghayoun.ezjobs.t.axis.T_Manager4;
import com.ghayoun.ezjobs.t.axis.T_Manager5;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.ApprovalInfoBean;
import com.ghayoun.ezjobs.t.domain.DefJobBean;
import com.ghayoun.ezjobs.t.domain.DefJobsFileBean;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.Doc07Bean;
import com.ghayoun.ezjobs.t.domain.Doc08Bean;
import com.ghayoun.ezjobs.t.domain.Doc09Bean;
import com.ghayoun.ezjobs.t.domain.Doc12Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobGroupBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.domain.UserBean;
import com.ghayoun.ezjobs.t.repository.EmDeleteConditionDao;
import com.ghayoun.ezjobs.t.repository.EmGrpDefinitionDao;
import com.ghayoun.ezjobs.t.repository.EmJobActionDao;
import com.ghayoun.ezjobs.t.repository.EmJobCondDao;
import com.ghayoun.ezjobs.t.repository.EmJobCreateDao;
import com.ghayoun.ezjobs.t.repository.EmJobDefinitionDao;
import com.ghayoun.ezjobs.t.repository.EmJobDeleteDao;
import com.ghayoun.ezjobs.t.repository.EmJobOrderDao;
import com.ghayoun.ezjobs.t.repository.EmJobUploadDao;
import com.ghayoun.ezjobs.t.repository.PopupDefJobDao;
import com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao;
import com.ghayoun.ezjobs.t.repository.WorksApprovalLineDao;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;
import com.sshtools.j2ssh.util.Hash;

public class WorksApprovalDocServiceImpl implements WorksApprovalDocService {
	
	protected final Log logger = LogFactory.getLog(getClass());
	
	public static StringBuffer upload_sb		= new StringBuffer();

	private CommonDao commonDao;
	private WorksApprovalDocDao worksApprovalDocDao;
	
	private WorksUserDao worksUserDao;
	 
	private EmJobDefinitionDao emJobDefinitionDao;
	private EmJobUploadDao emJobUploadDao;
	private EmJobOrderDao emJobOrderDao;
	private EmJobCreateDao emJobCreateDao;
	private EmJobDeleteDao emJobDeleteDao;
	private EmJobCondDao emJobCondDao;
	
	private EmJobActionDao emJobActionDao;
	private EmGrpDefinitionDao emGrpDefinitionDao;
	private EmBatchResultTotalDao emBatchResultTotalDao;
	private QuartzDao quartzDao;

	private PopupDefJobDao popupDefJobDao;
	
	private WorksApprovalLineDao worksApprovalLineDao;
	
	private EmDeleteConditionDao emDeleteConditionDao;
	
	public void setPopupDefJobDao(PopupDefJobDao popupDefJobDao) {
        this.popupDefJobDao = popupDefJobDao;
    }	
	
	public void setWorksApprovalLineDao(WorksApprovalLineDao worksApprovalLineDao) {
        this.worksApprovalLineDao = worksApprovalLineDao;
    }
	
	public void setCommonDao(CommonDao commonDao) {
        this.commonDao = commonDao;
    }
	public void setWorksApprovalDocDao(WorksApprovalDocDao worksApprovalDocDao) {
        this.worksApprovalDocDao = worksApprovalDocDao;
    }
	public void setWorksUserDao(WorksUserDao worksUserDao) {
        this.worksUserDao = worksUserDao;
    }
	
	public void setEmJobDefinitionDao(EmJobDefinitionDao emJobDefinitionDao) {
        this.emJobDefinitionDao = emJobDefinitionDao;
    }
	public void setEmJobUploadDao(EmJobUploadDao emJobUploadDao) {
        this.emJobUploadDao = emJobUploadDao;
    }
	public void setEmJobOrderDao(EmJobOrderDao emJobOrderDao) {
        this.emJobOrderDao = emJobOrderDao;
    }
	public void setEmJobCreateDao(EmJobCreateDao emJobCreateDao) {
        this.emJobCreateDao = emJobCreateDao;
    }
	public void setEmJobDeleteDao(EmJobDeleteDao emJobDeleteDao) {
        this.emJobDeleteDao = emJobDeleteDao;
    }
	public void setEmJobCondDao(EmJobCondDao emJobCondDao) {
        this.emJobCondDao = emJobCondDao;
    }
	public void setEmJobActionDao(EmJobActionDao emJobActionDao) {
        this.emJobActionDao = emJobActionDao;
    }
	public void setEmGrpDefinitionDao(EmGrpDefinitionDao emGrpDefinitionDao) {
        this.emGrpDefinitionDao = emGrpDefinitionDao;
    }
	public void setEmBatchResultTotalDao(EmBatchResultTotalDao emBatchResultTotalDao) {
        this.emBatchResultTotalDao = emBatchResultTotalDao;
    }    
	public void setEmDeleteConditionDao(EmDeleteConditionDao emDeleteConditionDao) {
        this.emDeleteConditionDao = emDeleteConditionDao;
    }
	public void setQuartzDao(QuartzDao quartzDao) {
        this.quartzDao = quartzDao;
    }
	
    public List<ApprovalInfoBean> dGetApprovalInfoList(Map map){
		return worksApprovalDocDao.dGetApprovalInfoList(map);
	}
	

    public CommonBean dGetAllDocInfoListCnt(Map map){
    	return worksApprovalDocDao.dGetAllDocInfoListCnt(map);
    }
	public List<DocInfoBean> dGetAllDocInfoList(Map map){
		return worksApprovalDocDao.dGetAllDocInfoList(map);
	}

    public CommonBean dGetMyDocInfoListCnt(Map map){
    	return worksApprovalDocDao.dGetMyDocInfoListCnt(map);
    }
	public List<DocInfoBean> dGetMyDocInfoList(Map map){ return worksApprovalDocDao.dGetMyDocInfoList(map);}

	public CommonBean dGetApprovalDocInfoListCnt(Map map){
    	return worksApprovalDocDao.dGetApprovalDocInfoListCnt(map);
    }
	public List<DocInfoBean> dGetApprovalDocInfoList(Map map){
		return worksApprovalDocDao.dGetApprovalDocInfoList(map);
	}
	
	public ActiveJobBean dGetActiveJobListCnt(Map map){
		return worksApprovalDocDao.dGetActiveJobListCnt(map);
	}
	public List<ActiveJobBean> dGetActiveJobList(Map map){
		return worksApprovalDocDao.dGetActiveJobList(map);
	}
	
	public List<ActiveJobBean> dGetActiveJobCntList(Map map){
		return worksApprovalDocDao.dGetActiveJobCntList(map);
	}
	public ActiveJobBean dGetAjobStatus(Map map){
		return worksApprovalDocDao.dGetAjobStatus(map);
	}

    public DefJobBean dGetDefJobListCnt(Map map){
    	return worksApprovalDocDao.dGetDefJobListCnt(map);
    }
	public List<DefJobBean> dGetDefJobList(Map map){
		return worksApprovalDocDao.dGetDefJobList(map);
	}
	public Doc01Bean dGetDoc01(Map map){
    	return worksApprovalDocDao.dGetDoc01(map);
    }
	public Doc01Bean dGetDoc02(Map map){
    	return worksApprovalDocDao.dGetDoc02(map);  
    }
	public Doc03Bean dGetDoc03(Map map){
    	return worksApprovalDocDao.dGetDoc03(map);
    }
	public Doc01Bean dGetDoc04(Map map){
    	return worksApprovalDocDao.dGetDoc04(map);
    }
	public Doc01Bean dGetDoc04_original(Map map){
    	return worksApprovalDocDao.dGetDoc04_original(map);
    }
	public Doc05Bean dGetDoc05(Map map){
    	return worksApprovalDocDao.dGetDoc05(map);  
    }
	public Doc05Bean dGetGroupDoc05(Map map){
    	return worksApprovalDocDao.dGetGroupDoc05(map);
    }
	public Doc07Bean dGetDoc07(Map map){
    	return worksApprovalDocDao.dGetDoc07(map);
    }
	public Doc08Bean dGetDoc08(Map map){
    	return worksApprovalDocDao.dGetDoc08(map);
    }
	public Doc01Bean dGetDoc09(Map map){
    	return worksApprovalDocDao.dGetDoc09(map);
    }
	public Doc01Bean dGetDoc10(Map map){
		return worksApprovalDocDao.dGetDoc10(map);
	}
	public Doc01Bean dGetJobModifyInfo(Map map){
		return worksApprovalDocDao.dGetJobModifyInfo(map);
	}
	public CommonBean dGetScodeDesc(Map map){
    	return worksApprovalDocDao.dGetScodeDesc(map);
    }
	
	public List<Doc02Bean> dGetDoc02List(Map map){
		
		CommonBean commonBean 		= emBatchResultTotalDao.dGetDataCenterInfo(map);
		String strActiveNetName 	= CommonUtil.isNull(commonBean.getActive_net_name());
		map.put("active_net_name", 	strActiveNetName);
		
		return worksApprovalDocDao.dGetDoc02List(map);
	}
	
	public List<DocInfoBean> dGetForecastDocList(Map map){
		return worksApprovalDocDao.dGetForecastDocList(map);	
	}
	
	public int dGetChkDefJobCnt(Map map){
		CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(map);
		int chk = 0;
		if( bean.getTotal_count()>0){
			chk = bean.getTotal_count();
		}
		return chk;
    }
	
	
	public int chkDoc06JobCnt(Map map){
		CommonBean bean = worksApprovalDocDao.dGetChkDoc06JobCnt(map);
		int chk = 0;
		if( bean.getTotal_count()>0){
			chk = 1;
		}
		return chk;
    }

	// 요청서 공통 (등록:01, 일회성:02, 삭제:03, 수정:04, 오더:05, 상태변경:07, 일괄요청:09, 오류조치:10)
	public Map dPrcDoc(Map map) throws Exception {

		String strFlag 			= CommonUtil.isNull(map.get("flag"), "");
		String strJobName 			= CommonUtil.isNull(map.get("job_name"), "");
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strDocGb 			= CommonUtil.isNull(map.get("doc_gb"));
		String strTable_name 		= CommonUtil.isNull(map.get("table_name"));
		String strGroup_main 		= CommonUtil.isNull(map.get("group_main"));
		String strMainDocCd 		= CommonUtil.isNull(map.get("main_doc_cd"));
		String s_user_gb 			= CommonUtil.isNull(map.get("s_user_gb"));
		//일괄요청서는 mapper를 안타기위해 체크로직 추가
		String strOriDocGb 		= CommonUtil.isNull(map.get("ori_doc_gb"));
		String strOriDocCd 		= CommonUtil.isNull(map.get("doc_cd"));
		String strPostApprovalYn 	= "";
		String strPostApprovalCnt 	= "";

		// 결재통보 발송 체크로직
		String bJobApprovalChk = "N";

		Map rMap = null;

		// 수시 작업은 S_ 를 prefix 설정
		if (strDocGb.equals("02")) {
			strJobName = "S_" + strJobName;
			map.put("job_name", strJobName);
		}

		if (strFlag.equals("post_draft")) {
			strPostApprovalYn = "Y";
		} else if (strFlag.equals("draft")) {
			strPostApprovalYn = "N";
		}

		map.put("post_approval_yn", strPostApprovalYn);

		// 코드관리 - 사용자의 폴더권한 사용여부
		String userFolderAuth_yn = "Y";
		map.put("mcode_cd", "M95");
		List<CommonBean> sCodeList = commonDao.dGetsCodeList(map);
		for(int i = 0; i < sCodeList.size(); i++) {
			CommonBean bean = (CommonBean)sCodeList.get(i);
			userFolderAuth_yn = CommonUtil.isNull(bean.getScode_nm());
		}

		// 폴더 권한 체크
		if (s_user_gb.equals("01") && userFolderAuth_yn.equals("Y")) {
			Map rMap4 = new HashMap();
			map.put("table_name", strTable_name);
			List authList = worksUserDao.dGetUserAuthList(map);

			if (authList == null || authList.size() < 1) {
				rMap4.put("r_code", "-2");
				rMap4.put("r_msg", CommonUtil.getMessage("ERROR.57"));
				throw new DefaultServiceException(rMap4);
			}
		}

		if (strDocGb.equals("01") && strOriDocGb.equals("")) {

			// 등록 요청서는 Control-M 의 존재 여부 체크
			CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(map);
			if (bean.getTotal_count() > 0) {
				Map rMap2 = new HashMap();
				rMap2.put("r_code", "-2");
				rMap2.put("r_msg", CommonUtil.getMessage("ERROR.17"));
				throw new DefaultServiceException(rMap2);
			}

			// 엑셀 의뢰 존재 여부
			CommonBean bean9 = worksApprovalDocDao.dGetChkDoc06JobCnt(map);
			if (bean9.getTotal_count() > 0) {
				Map rMap3 = new HashMap();
				rMap3.put("r_code", "-2");
				rMap3.put("r_msg", CommonUtil.getMessage("ERROR.52"));
				throw new DefaultServiceException(rMap3);
			}
				
		} else if (strDocGb.equals("03")) {

			// 삭제 요청서 저장시 체크로직 진행
			if (strFlag.equals("ins") || strFlag.equals("draft_i") || strFlag.equals("post_draft_i")) {

				// 저장 또는 미결 상태인 삭제 요청서 조회
				CommonBean bean = worksApprovalDocDao.dGetChkDoc03Cnt(map);
				CommonBean bean2 = worksApprovalDocDao.dGetChkDoc03Cnt2(map);
				if (bean.getTotal_count() > 0) {
					if (bean2 == null || bean.getTotal_count() > 0) {
						Map rMap2 = new HashMap();
						rMap2.put("r_code", "-2");
						rMap2.put("r_msg", CommonUtil.getMessage("ERROR.47"));
						throw new DefaultServiceException(rMap2);
					}
				}
				
				// 저장 또는 미결 상태인 수정 요청서 조회
				CommonBean bean3 = worksApprovalDocDao.dGetChkDoc04Cnt(map);
				CommonBean bean4 = worksApprovalDocDao.dGetChkDoc04Cnt2(map);
				if (bean3.getTotal_count() > 0) {
					if (bean4 == null || bean3.getTotal_count() > 0) {
						Map rMap2 = new HashMap();
						rMap2.put("r_code", "-2");
						rMap2.put("r_msg", CommonUtil.getMessage("ERROR.47"));
						throw new DefaultServiceException(rMap2);
					}
				}

				// 엑셀 의뢰 존재 여부
				CommonBean bean9 = worksApprovalDocDao.dGetChkDoc06JobCnt(map);
				if (bean9.getTotal_count() > 0) {
					Map rMap3 = new HashMap();
					rMap3.put("r_code", "-2");
					rMap3.put("r_msg", CommonUtil.getMessage("ERROR.52"));
					throw new DefaultServiceException(rMap3);
				}
			}

		} else if (strDocGb.equals("04")) {

			// 최초 수정 요청 시 체크 로직 진행
			if (strFlag.equals("ins") ) {

				// 저장 또는 미결 상태인 삭제 요청서 조회
				CommonBean bean = worksApprovalDocDao.dGetChkDoc03Cnt(map);
				CommonBean bean2 = worksApprovalDocDao.dGetChkDoc03Cnt2(map);
				if (bean.getTotal_count() > 0) {
					if (bean2 == null || bean.getTotal_count() > 0) {
						Map rMap2 = new HashMap();
						rMap2.put("r_code", "-2");
						rMap2.put("r_msg", CommonUtil.getMessage("ERROR.47"));
						throw new DefaultServiceException(rMap2);
					}
				}

				// 수정 요청서는 저장 또는 미결상태의 수정요청서 존재 여부 체크
				CommonBean bean3 = worksApprovalDocDao.dGetChkDoc04Cnt(map);
				CommonBean bean4 = worksApprovalDocDao.dGetChkDoc04Cnt2(map);
				if (bean3.getTotal_count() > 0) {
					if (bean4 == null || bean3.getTotal_count() > 0) {
						Map rMap2 = new HashMap();
						rMap2.put("r_code", "-2");
						rMap2.put("r_msg", CommonUtil.getMessage("ERROR.47"));
						throw new DefaultServiceException(rMap2);
					}
				}

				// 엑셀 의뢰 존재 여부
				CommonBean bean9 = worksApprovalDocDao.dGetChkDoc06JobCnt(map);
				if (bean9.getTotal_count() > 0) {
					Map rMap3 = new HashMap();
					rMap3.put("r_code", "-2");
					rMap3.put("r_msg", CommonUtil.getMessage("ERROR.52"));
					throw new DefaultServiceException(rMap3);
				}
			}
		}

		//등록/수정 시 시스템관리 내의 그룹 존재 여부 확인 후 등록해주는 로직
		if(strDocGb.equals("01") || strDocGb.equals("04")){
			Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
			
			String strTableName = CommonUtil.isNull(map.get("table_name"));
			
			if ( !strTableName.equals("") ) {
				strTableName = strTableName.split("/")[0];
			}
			
			appGrpCodeMap.put("SCHEMA", 	map.get("SCHEMA"));
			appGrpCodeMap.put("tb_nm", 		strTableName);	// 서브폴더에 등록할 경우 스마트폴더로 체크 해야 함 (2024.05.02 강명준) 
			appGrpCodeMap.put("ap_nm", 		map.get("application"));
			appGrpCodeMap.put("grp_nm", 	map.get("group_name"));
			appGrpCodeMap.put("grp_depth", 	"3");
			appGrpCodeMap.put("data_center", CommonUtil.isNull(map.get("data_center")));

			List<AppGrpBean> appGrpCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appGrpCodeMap);
			//시스템관리에 등록되어 있지 않은 그룹일 경우 등록해준다.
			if (appGrpCodeList.size() == 0) {
				//어플리케이션 grp_cd 가져오기
				Map<String, Object> appCodeMap = new HashMap<String, Object>();
				appCodeMap.put("SCHEMA", 		map.get("SCHEMA"));
				appCodeMap.put("grp_eng_nm", 	map.get("application"));
				appCodeMap.put("grp_depth", 	"2");
				appCodeMap.put("data_center", 	CommonUtil.isNull(map.get("data_center")).split(",")[0]);

				List<AppGrpBean> appCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appCodeMap);

				int app_grp_cd = Integer.parseInt(appCodeList.get(0).getGrp_cd());
				int grp_cd = commonDao.dGetAppGrpCd(map);

				Map<String, Object> GrpInsMap = new HashMap<String, Object>();

				//시스템관리에 그룹 추가하는 구간 추가   GRP_PARENT_CD
				GrpInsMap.put("SCHEMA", 			map.get("SCHEMA"));
				GrpInsMap.put("flag", 				"ins");
				GrpInsMap.put("grp_cd", 			Integer.toString(grp_cd));
				GrpInsMap.put("grp_parent_cd", 		app_grp_cd);
				GrpInsMap.put("grp_use_yn", 		"Y");
				GrpInsMap.put("grp_depth", 			"3");
				GrpInsMap.put("grp_eng_nm", 		map.get("group_name"));
				GrpInsMap.put("grp_ins_user_cd", 	map.get("s_user_cd"));
				GrpInsMap.put("scode_cd", 			CommonUtil.isNull(map.get("data_center")).split(",")[0]);

				commonDao.dPrcAppGrpInsert(GrpInsMap);
			}
		}

		// 상태변경 체크로직
		if ( strDocGb.equals("07") && !strGroup_main.equals("Y")) {
			
			String hold_status = CommonUtil.isNull(map.get("hold_status"));
			String before_status = CommonUtil.isNull(map.get("before_status"));
			if(before_status.equals("HOLD")) {
				map.put("before_status", before_status + "(" + hold_status + ")");
			}

			String strErrorMessage = CommonUtil.getStatusChangeCheck(map);

			if ( !strErrorMessage.equals("") ) {
				Map rMap3 = new HashMap();
				rMap3.put("r_code",	"-2");
				rMap3.put("r_msg",	strErrorMessage);
				throw new DefaultServiceException(rMap3);
			}
		}

		// 특수문자 공통 처리
		CommonWorksUtil.jobInfoReplaceStrHtml(map);

		// 요청서 프로시저 분기 처리
		if(!strGroup_main.equals("Y")) {
			if (strDocGb.equals("01")) rMap = worksApprovalDocDao.dPrcDoc01(map);
			if (strDocGb.equals("02")) rMap = worksApprovalDocDao.dPrcDoc02(map);
			if (strDocGb.equals("03")) rMap = worksApprovalDocDao.dPrcDoc03(map);
			if (strDocGb.equals("04")) rMap = worksApprovalDocDao.dPrcDoc04(map);
			if (strDocGb.equals("05")) rMap = worksApprovalDocDao.dPrcDoc05(map);
			if (strDocGb.equals("07")) rMap = worksApprovalDocDao.dPrcDoc07(map);
			if (strDocGb.equals("10")) rMap = worksApprovalDocDao.dPrcDoc10(map);
		}

		// kubernetes일 경우 저장하는 프로시저 추가
		if("Kubernetes".equals(CommonUtil.isNull(map.get("task_type"))) && (strDocGb.equals("01") || strDocGb.equals("02") || strDocGb.equals("04"))) {
			Map rMap4 = new HashMap();
			
			if(strFlag.equals("udt") || strFlag.equals("draft_admin") || strFlag.equals("draft")) {
				rMap4.put("flag", 	"udt_kubernetes");
			}else {
				rMap4.put("flag", 	strFlag);
			}
			rMap4.put("doc_cd", rMap.get("r_doc_cd"));
			rMap4.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			String yaml_file = CommonUtil.isNull(map.get("yaml_file"));

			// 마지막 역슬래시(\) 또는 슬래시(/)의 인덱스를 찾음
	        int lastSeparatorIndex = yaml_file.lastIndexOf('\\');
	        if (lastSeparatorIndex == -1) {
	            lastSeparatorIndex = yaml_file.lastIndexOf('/');
	        }

	        // 파일 이름 추출
	        String fileName = yaml_file.substring(lastSeparatorIndex + 1);

	        //파일 내용
	        String encodeValue = CommonUtil.isNull(map.get("file_content"));
	        
	        //특수문자 변환
	        encodeValue = CommonUtil.replaceStrHtml(encodeValue);
	        
	        //인코딩 여부 체크하여 인코딩 진행
			if(CommonUtil.isNull(map.get("cont_encode_yn")).equals("N")) {
				encodeValue = Base64.getEncoder().encodeToString(encodeValue.getBytes());
			}

			for(int i=0;i<11;i++) {
				if(i == 0) {
					rMap4.put("var_name", "UCM-ACCOUNT");
					rMap4.put("var_value", CommonUtil.isNull(map.get("con_pro")));
				}else if(i == 1) {
					rMap4.put("var_name", "UCM-JOB_YAML_FILE_PARAMS");
					rMap4.put("var_value", CommonUtil.isNull(map.get("spec_param")));
				}else if(i == 2) {
					rMap4.put("var_name", "UCM-GET_LOGS");
					rMap4.put("var_value", CommonUtil.isNull(map.get("get_pod_logs")));
				}else if(i == 3) {
					rMap4.put("var_name", "UCM-CLEANUP");
					rMap4.put("var_value", CommonUtil.isNull(map.get("job_cleanup")));
				}else if(i == 4) {
					rMap4.put("var_name", "UCM-JOB_POLL_INTERVAL");
					rMap4.put("var_value", CommonUtil.isNull(map.get("polling_interval")));
				}else if(i == 5) {
					rMap4.put("var_name", "UCM-JOB_YAML_FILE");
					rMap4.put("var_value", fileName);
				}else if(i == 6) {
					rMap4.put("var_name", "UCM-JOB_YAML_FILE_N001_element");
					rMap4.put("var_value", fileName);
				}else if(i == 7) {
					rMap4.put("var_name", "UCM-JOB_YAML_FILE_N002_element");
					rMap4.put("var_value", encodeValue);
				}else if(i == 8) {
					rMap4.put("var_name", "UCM-JOB_SPEC_TYPE");
					rMap4.put("var_value", CommonUtil.isNull(map.get("job_spec_type")));
				}else if(i == 9) {
					rMap4.put("var_name", "UCM-OS_EXIT_CODE");
					rMap4.put("var_value", CommonUtil.isNull(map.get("os_exit_code")));
				}else {
					rMap4.put("var_name", "UCM-APP_NAME");
					rMap4.put("var_value", "KBN062023");
				}
				
				rMap4.put("seq", String.valueOf(i+1));
				
				logger.info("kubernetes일 경우 ez_doc_setvar ::::: " + rMap4);
				
				rMap4 = worksApprovalDocDao.dPrcDocSetvar(rMap4);

				if( !"1".equals(CommonUtil.isNull(rMap4.get("r_code"))) ) throw new DefaultServiceException(rMap4);
			}
		}
		
		// Database일 경우 저장하는 프로시저 추가
		if("Database".equals(CommonUtil.isNull(map.get("task_type"))) && (strDocGb.equals("01") || strDocGb.equals("02") || strDocGb.equals("04"))) {
			Map rMap5 = new HashMap();
			
			rMap5.put("doc_cd", rMap.get("r_doc_cd"));
			rMap5.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			if(strFlag.equals("udt") || strFlag.equals("draft_admin") || strFlag.equals("draft")) {
				rMap5.put("flag", "database_del");
				worksApprovalDocDao.dPrcDocSetvar(rMap5);
				rMap5.put("flag", "ins");
			}else {
				rMap5.put("flag", 	strFlag);
			}
			int idx = 0;
			int index = 0;
			int index2 = 0;
			int index3 = 0;
			for(int i=0;i<12;i++) {
				
				if(i == 0) {
					rMap5.put("var_name", "%%DB-ACCOUNT");
					rMap5.put("var_value", CommonUtil.isNull(map.get("db_con_pro")));
				}else if(i == 1) {
					rMap5.put("var_name", "%%DB-DB_TYPE");
					rMap5.put("var_value", CommonUtil.isNull(map.get("database_type")));
				}else if(i == 2) {
					rMap5.put("var_name", "%%DB-EXEC_TYPE");
					String strExeType = "";
					if(CommonUtil.isNull(map.get("execution_type")).equals("P")) {
						strExeType = "Stored Procedure";
					}else if(CommonUtil.isNull(map.get("execution_type")).equals("Q")){
						strExeType = "Open Query";
					}
					rMap5.put("var_value", strExeType);
				}else if(i == 3) {
					rMap5.put("var_name", "%%DB-STP_SCHEM");
					rMap5.put("var_value", CommonUtil.isNull(map.get("schema")));
				}else if(i == 4) {
					rMap5.put("var_name", "%%DB-STP_NAME");
					rMap5.put("var_value", CommonUtil.isNull(map.get("sp_name")));
				}else if(i == 5) {
					rMap5.put("var_name", "%%DB-QTXT-N001-SUBQTXT");
					rMap5.put("var_value", CommonUtil.isNull(map.get("query")));
				}else if(i == 6) {
					rMap5.put("var_name", "%%DB-QTXT-N001-SUBQLENGTH");
					rMap5.put("var_value", Integer.toString(CommonUtil.isNull(map.get("query")).length()));
				}else if(i == 7) {
					rMap5.put("var_name", "%%DB-AUTOCOMMIT");
					rMap5.put("var_value", CommonUtil.isNull(map.get("db_autocommit")));
				}else if(i == 8) {
					rMap5.put("var_name", "%%DB-APPEND_LOG");
					rMap5.put("var_value", CommonUtil.isNull(map.get("append_log")));
				}else if(i == 9) {
					rMap5.put("var_name", "%%DB-APPEND_OUTPUT");
					rMap5.put("var_value", CommonUtil.isNull(map.get("append_output")));
				}else if(i == 10){
					System.out.println(" i : " + i);
					rMap5.put("var_name", "%%DB-OUTPUT_FORMAT");
					String strFormat = "";
					if(CommonUtil.isNull(map.get("sel_db_output_format")).equals("T")) {
						strFormat = "Text";
					}else if(CommonUtil.isNull(map.get("sel_db_output_format")).equals("X")) {
						strFormat = "XML";
					}else if(CommonUtil.isNull(map.get("sel_db_output_format")).equals("C")) {
						strFormat = "CSV";
					}else{
						strFormat = "HTML";
					}
					rMap5.put("var_value", strFormat);
				}else{
					rMap5.put("var_name", "%%DB-CSV_SEPERATOR");
					if(CommonUtil.isNull(map.get("sel_db_output_format")).equals("C")) {
						rMap5.put("var_value", CommonUtil.isNull(map.get("csv_seperator")));
					}else {
						rMap5.put("var_value", "");
					}
				}
				idx = (i+1);
				
				
				rMap5.put("seq", String.valueOf(i+1));
				
				logger.info("kubernetes일 경우 ez_doc_setvar ::::: " + rMap5);
				
				rMap5 = worksApprovalDocDao.dPrcDocSetvar(rMap5);

				if( !"1".equals(CommonUtil.isNull(rMap5.get("r_code"))) ) throw new DefaultServiceException(rMap5);
			}
			
			rMap5 = new HashMap();
			
			if(strFlag.equals("udt") || strFlag.equals("draft_admin") || strFlag.equals("draft")) {
				rMap5.put("flag", 	"ins");
			}else {
				rMap5.put("flag", 	strFlag);
			}
			rMap5.put("doc_cd", rMap.get("r_doc_cd"));
			rMap5.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			for (int i=0;i<4;i++) {
				if(i == 0) {
					System.out.println("첫번째는 여기");
					//index3 = idx;
					while (true) {
					    // 파라미터 이름 생성
					    String paramName1 = "ret_name" + index;
					    String paramName2 = "in_name" + index;

					    // 파라미터 값 가져오기
					    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
					    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

					    // 두 파라미터 값이 모두 빈 문자열이면 종료
					    if (paramValue1.equals("") && paramValue2.equals("")) {
					        break;
					    }

					    // 빈 문자열이 아닌 경우에만 Map에 추가
					    if (!paramValue1.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_NAME");
							rMap5.put("var_value", paramValue1);
					    }
					    if (!paramValue2.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_NAME");
							rMap5.put("var_value", paramValue2);
					    }

						rMap5.put("seq", String.valueOf(i+1+idx+index2));
						logger.info("kubernetes일 경우 ez_doc_setvar ::::: " + rMap5);
						rMap5 = worksApprovalDocDao.dPrcDocSetvar(rMap5);
						if( !"1".equals(CommonUtil.isNull(rMap5.get("r_code"))) ) throw new DefaultServiceException(rMap5);
						// 인덱스 증가
					    index++;
					    index2++;
					    index3++;
					}
				}else if(i == 1) {
					System.out.println("두번째는 여기");
					index = 0;
					index3 = 0;
					while (true) {
					    // 파라미터 이름 생성
					    String paramName1 = "ret_data" + index;
					    String paramName2 = "in_data" + index;

					    // 파라미터 값 가져오기
					    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
					    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

					    // 두 파라미터 값이 모두 빈 문자열이면 종료
					    if (paramValue1.equals("") && paramValue2.equals("")) {
					        break;
					    }

					    // 빈 문자열이 아닌 경우에만 Map에 추가
					    if (!paramValue1.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_TYPE");
					        rMap5.put("var_value", paramValue1);
					    }
					    if (!paramValue2.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_TYPE");
					        rMap5.put("var_value", paramValue2);
					    }

					    rMap5.put("seq", String.valueOf(i+1+idx+index2));
					    logger.info("kubernetes일 경우 ez_doc_setvar ::::: " + rMap5);
					    rMap5 = worksApprovalDocDao.dPrcDocSetvar(rMap5);
					    if( !"1".equals(CommonUtil.isNull(rMap5.get("r_code"))) ) throw new DefaultServiceException(rMap5);
					    // 인덱스 증가
					    index++;
					    index2++;
					    index3++;
					}
				}else if(i == 2) {
					System.out.println("세번째는 여기");
					index = 0;
					index3 = 0;
					while (true) {
					    // 파라미터 이름 생성
					    String paramName1 = "ret_param" + index;
					    String paramName2 = "in_param" + index;

					    // 파라미터 값 가져오기
					    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
					    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

					    // 두 파라미터 값이 모두 빈 문자열이면 종료
					    if (paramValue1.equals("") && paramValue2.equals("")) {
					        break;
					    }

					    // 빈 문자열이 아닌 경우에만 Map에 추가
					    if (!paramValue1.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_DIRECTION");
					        rMap5.put("var_value", paramValue1);
					    }
					    if (!paramValue2.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_DIRECTION");
					        rMap5.put("var_value", paramValue2);
					    }

					    rMap5.put("seq", String.valueOf(i+1+idx+index2));
					    logger.info("kubernetes일 경우 ez_doc_setvar ::::: " + rMap5);
					    rMap5 = worksApprovalDocDao.dPrcDocSetvar(rMap5);
					    if( !"1".equals(CommonUtil.isNull(rMap5.get("r_code"))) ) throw new DefaultServiceException(rMap5);
					    // 인덱스 증가
					    index++;
					    index2++;
					    index3++;
					}
				}else{
					System.out.println("네번째는 여기");
					index = 0;
					index3 = 0;
					while (true) {
					    // 파라미터 이름 생성
					    String paramName1 = "ret_variable" + index;
					    String paramName2 = "in_value" + index;

					    // 파라미터 값 가져오기
					    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
					    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

					    // 두 파라미터 값이 모두 빈 문자열이면 종료
					    if (paramValue1.equals("") && paramValue2.equals("")) {
					        break;
					    }

					    // 빈 문자열이 아닌 경우에만 Map에 추가
					    if (!paramValue1.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_SETVAR");
					        rMap5.put("var_value", paramValue1);
					    }
					    if (!paramValue2.equals("")) {
					        rMap5.put("var_name", "%%DB-STP_PARAMS-P00"+((index3+1))+"-PRM_VALUE");
					        rMap5.put("var_value", paramValue2);
					    }

					    rMap5.put("seq", String.valueOf(i+1+idx+index2));
					    logger.info("kubernetes일 경우 ez_doc_setvar ::::: " + rMap5);
					    rMap5 = worksApprovalDocDao.dPrcDocSetvar(rMap5);
					    if( !"1".equals(CommonUtil.isNull(rMap5.get("r_code"))) ) throw new DefaultServiceException(rMap5);
					    // 인덱스 증가
					    index++;
					    index2++;
					    index3++;
					}
				}
				
			}
		}
		
		if ( strOriDocGb.equals("09") && strGroup_main.equals("Y") ) 	rMap = worksApprovalDocDao.dPrcDoc09(map);

		if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

		if( "1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) bJobApprovalChk = "Y";

		// 수정 요청서는 원본 저장 로직 추가
		if ( strDocGb.equals("04") ) {
			if (strFlag.equals("ins") || strFlag.equals("draft_admin")) {

				Map<String, Object> originalMap = new HashMap<String, Object>();

				map.put("p_sched_table", map.get("before_table_name"));
				Doc01Bean bean04_org = worksApprovalDocDao.dGetJobModifyInfo(map);

				originalMap = CommonUtil.ConvertObjectToMap(bean04_org);
				originalMap.put("flag", 		"original_ins");
				originalMap.put("doc_cd", 		CommonUtil.isNull(rMap.get("r_doc_cd")));
				originalMap.put("title", 		CommonUtil.isNull(map.get("title")));
				originalMap.put("content", 		CommonUtil.isNull(map.get("content")));
				originalMap.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

				worksApprovalDocDao.dPrcDoc04(originalMap);
			}
		}

		String  r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"), (String) rMap.get("doc_cd"));
		map.put("doc_cd", r_doc_cd);

		// 매퍼 등록 공통 처리.
		// 일괄승인요청 시 (등록/수정/삭제/오류처리만) jobMapperUpdate 제외
		if ( (!(strOriDocGb.equals("09") && strGroup_main.equals("Y")) && !(strGroup_main.equals("N") && (strDocGb.equals("01") || strDocGb.equals("03") || strDocGb.equals("04") || strDocGb.equals("10"))))) {
			CommonWorksUtil.jobMapperOneUpdateDoc(map);
		}
		// 후결 처리.
		if ( strPostApprovalYn.equals("Y") ) {

			r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"));

			Map rMap3 = new HashMap();
			rMap3.put("doc_cd",		r_doc_cd);
			rMap3.put("SCHEMA", 	CommonUtil.isNull(map.get("SCHEMA")));

			// 결재자 체크해서 모든 결재선이 후결일 경우 API 호출.
			CommonBean bean3 = worksApprovalDocDao.dGetChkPostApprovalLineCnt(rMap3);

			strPostApprovalCnt = CommonUtil.isNull(bean3.getTotal_count());

			if( Integer.parseInt(strPostApprovalCnt) == 0 && strMainDocCd.equals("") ) {
				map.put("doc_cd", 	r_doc_cd);
				map.put("flag", 	"post_draft");
				map.put("doc_cnt", 	"0");
				map.put("group_yn", strGroup_main);

				rMap = this.dPrcDocApproval(map);
				String r_code = CommonUtil.isNull(rMap.get("r_code"));
				if( !"1".equals(r_code) ) throw new DefaultServiceException(rMap);
			}else if(Integer.parseInt(strPostApprovalCnt) == 0 && !strMainDocCd.equals("") ){
				//컨트롤러단에서 반영하기 위한 체크로직 , 일괄요청서 관련 후결-후결
				rMap.put("jobApplyChk" , "Y");
			}
		}
		
		// MFT 정보 저장
		String accounts = CommonUtil.isNull(map.get("FTP_ACCOUNT"));
		if (!accounts.equals("")) {
			Map mftMap = new HashMap();

			mftMap.put("r_code", 	"");
			mftMap.put("r_msg", 	"");
			mftMap.put("doc_cd", 	CommonUtil.isNull(map.get("doc_cd")));
			mftMap.put("SCHEMA", 	CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

			//수정요청이면 삭제진행후 이후 등록작업
			if (strFlag.equals("udt") || strFlag.equals("draft")) {
				mftMap.put("flag", "mft_del");
				mftMap.put("seq", "");
				mftMap.put("var_name", "");
				mftMap.put("var_value", "");
				worksApprovalDocDao.dPrcDocSetvar(mftMap);

				mftMap.put("flag", "ins");
			} else {
				mftMap.put("flag", strFlag);
			}

			List<String> accountlist = Arrays.asList("FTP_ACCOUNT",
					"FTP_LHOST", "FTP_LOSTYPE", "FTP_LUSER", "FTP_CONNTYPE1",
					"FTP_RHOST", "FTP_ROSTYPE", "FTP_RUSER", "FTP_CONNTYPE2",
					"FTP_USE_DEF_NUMRETRIES", "FTP_NUM_RETRIES", "FTP_RPF", "FTP_CONT_EXE_NOTOK");
			
			List<String> advancedlist = Arrays.asList("FTP_NEWNAME", "FTP_SRC_ACT_FAIL", "FTP_DEST_NEWNAME",
					"FTP_EMPTY_DEST_FILE_NAME", "FTP_FILE_PFX", "FTP_CONT_EXE", "FTP_DEL_DEST_ON_FAILURE",
					"FTP_POSTCMD_ON_FAILURE", "FTP_ENCRYPTION1", "FTP_COMPRESSION1", "FTP_ENCRYPTION2",
					"FTP_COMPRESSION2", "FTP_PRESERVE_ATTR", "FTP_PRECOMM1", "FTP_PREPARAM11", "FTP_PREPARAM12",
					"FTP_POSTCOMM1", "FTP_POSTPARAM11", "FTP_POSTPARAM12", "FTP_PRECOMM2", "FTP_PREPARAM21",
					"FTP_PREPARAM22", "FTP_POSTCOMM2", "FTP_POSTPARAM21", "FTP_POSTPARAM22", "FTP_PGP_ENABLE",
					"FTP_PGP_TEMPLATE_NAME", "FTP_PGP_KEEP_FILES");

			List<String> pathlist = Arrays.asList("FTP_LPATH", "FTP_UPLOAD", "FTP_RPATH", "FTP_TYPE");

			List<String> list = Arrays.asList("FTP_SRCOPT", "FTP_IF_EXIST", "FTP_DSTOPT", "FTP_EXCLUDE_WILDCARD", "FTP_RECURSIVE");
			
			int total = 1;			
			String mcd = null;
			
			for (String name : accountlist) {
				mcd = Integer.toString(total);
				
				mftMap.put("seq", 			mcd);
				mftMap.put("var_name", 		name);
				mftMap.put("var_value", 	CommonUtil.isNull(map.get(name)));

				worksApprovalDocDao.dPrcDocSetvar(mftMap);
				total++;
			}

			for (int num = 0; num <= 5; num++) {
				String path = CommonUtil.isNull(CommonUtil.isNull(map.get("FTP_LPATH" + num)));
				if (!path.equals("") && !path.equals(null)) {
					for (int i = 0; i < pathlist.size(); i++) {
						mcd = Integer.toString(total);
						String name = pathlist.get(i) + num;
						
						System.out.println("mftPathList name : " + name);
						
						mftMap.put("seq", mcd);
						mftMap.put("var_name", name);
						mftMap.put("var_value", CommonUtil.isNull(map.get(name)));
						worksApprovalDocDao.dPrcDocSetvar(mftMap);
						total++;
					}
					
					for (int i = 0; i < advancedlist.size(); i++) {
						String name = advancedlist.get(i) + num;
						if(!CommonUtil.isNull(map.get(name)).equals("")) {
							mcd = Integer.toString(total);
							mftMap.put("seq", mcd);
							mftMap.put("var_name", name);
							mftMap.put("var_value", map.get(name));
							worksApprovalDocDao.dPrcDocSetvar(mftMap);
							total++;
						}
					}
					for (int i = 0; i < 5; i++) {
						String name = list.get(i) + num;
						mcd = Integer.toString(total);
						mftMap.put("seq", mcd);
						mftMap.put("var_name", name);
						if(CommonUtil.isNull(map.get(name)).equals("")) {
							mftMap.put("var_value", "0");
						} else {
							mftMap.put("var_value", map.get(name));
						}
						worksApprovalDocDao.dPrcDocSetvar(mftMap);
						total++;
					}
					
//					String advancd_check = CommonUtil.isNull(CommonUtil.isNull(map.get("FTP_SRCOPT" + num)));
//					if (!advancd_check.equals("")) {
//						for (int i = 0; i < advancedlist.size(); i++) {
//							mcd = Integer.toString(total);
//							String name = advancedlist.get(i) + num;
//							mftMap.put("seq", mcd);
//							mftMap.put("var_name", name);
//							mftMap.put("var_value", CommonUtil.isNull(map.get(name)));
//							worksApprovalDocDao.dPrcDocMFT(mftMap);
//							total++;
//						} 
//					} else {
//						List<String> list = Arrays.asList("FTP_SRCOPT", "FTP_IF_EXIST", "FTP_DSTOPT", "FTP_EXCLUDE_WILDCARD", "FTP_RECURSIVE");
//						for (int i = 0; i < 5; i++) {
//							mcd = Integer.toString(total);
//							String name = list.get(i) + num;
//							mftMap.put("seq", mcd);
//							mftMap.put("var_name", name);
//							mftMap.put("var_value", "0");
//							worksApprovalDocDao.dPrcDocMFT(mftMap);
//							total++;
//						}
//					}
				}
			}
		}
		rMap.put("sendApprovalNoti" , bJobApprovalChk);
		return rMap;
	}

	// 요청서 즉시결재 공통
	public Map dPrcDocAdmin(Map map) throws Exception{

		Map rMap = null;

		String strDocGb 	= CommonUtil.isNull(map.get("doc_gb"));
		String strMainDocCd = CommonUtil.isNull(map.get("main_doc_cd"));

		// 요청서 프로시저 공통
		rMap = this.dPrcDoc(map);

		String r_code = CommonUtil.isNull(rMap.get("r_code"));
		if( !"1".equals(r_code) ) throw new DefaultServiceException(rMap);

		String  r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"));
		map.put("doc_cd", 		CommonUtil.isNull(strMainDocCd,rMap.get("r_doc_cd")));
		map.put("approval_cd", 	"02");
		map.put("approval_seq", "1");
		map.put("flag", "draft_admin");

		logger.info("########### map : " + map);

		rMap = this.dPrcDocApproval(map);

		r_code = CommonUtil.isNull(rMap.get("r_code"));
		//if( !"1".equals(r_code) ) throw new DefaultServiceException(rMap);

		return rMap;
	}

	// 결재 처리.
	public Map dPrcDocApproval(Map map) throws Exception {

		String strDocGb				= CommonUtil.isNull(map.get("doc_gb"));
		String strTaskType			= CommonUtil.isNull(map.get("task_type"));
		String strDataCenter		= CommonUtil.isNull(map.get("data_center"));
		//String strTableName		= CommonUtil.isNull(map.get("table_name"));
		String strFlag				= CommonUtil.isNull(map.get("flag"));
		String strPostApprovalYn	= CommonUtil.isNull(map.get("post_approval_yn"));
		String strPostApprovalEnd	= CommonUtil.isNull(map.get("post_approval_end"));
		String group_approval		= CommonUtil.isNull(map.get("group_approval"));
		String approval_seq			= CommonUtil.isNull(map.get("approval_seq"));
		String strGroupMain			= CommonUtil.isNull(map.get("group_main"));
		String doc_cnt				= CommonUtil.isNull(map.get("doc_cnt"));
		String doc_cd 				= CommonUtil.isNull(map.get("doc_cd"));

		String r_msg				= "";
		String r_code				= "";
		String r_state_cd			= "";
		String r_apply_cd			= "";
		String rMsg					= "";

		String doc_gb				= "";

		String strTableId			= "";
		String strJobId				= "";
		String strJobName			= "";
		String strTableName			= "";
		String strJobgroupId		= "";
		String strMainDocCd			= "";
		String strDescription		= "";
		Map rMap = null;

		Map<String, Object> paramMap 	= new HashMap<String, Object>();
		Map<String, Object> rMap3 		= new HashMap<String, Object>();

		StringBuffer sb 				= new StringBuffer();
		// 결재통보 발송 체크로직
		String bJobApprovalChk 			= "N";
		// 반영완료 발송 체크로직
		String bJobExcChk 				= "N";

		int successCnt 					= 0;
		int failCnt 					= 0;

		CommonBean commonBean 			= emBatchResultTotalDao.dGetDataCenterInfo(map);

		String strActiveNetName 		= CommonUtil.isNull(commonBean.getActive_net_name());
		map.put("active_net_name", 	strActiveNetName);

		map.put("order", "");

		// 결재, 반려 등을 진행할 수 있는 상태인 지 체크.
		String strApprovalMessage = CommonUtil.getStatusApprovalCheck(map);

		if( !strApprovalMessage.equals("") ) {

			Map rMap2 = new HashMap();
			//rMap2.put("r_code",	"-1");
			rMap2.put("r_code",	"-2");
			rMap2.put("r_msg",	strApprovalMessage);
			rMap2.put("rMsg",	strApprovalMessage);	// 일괄 결재 시 rMsg로 설정해야 정상적으로 오류 출력
			throw new DefaultServiceException(rMap2);
		}

		// 화면에서 넘어온 결재 순서로 넘겨줘야 중복 결재를 체크 할 수 있음.
		String strCurApprovalSeq 	= approval_seq;
		map.put("approval_seq",	strCurApprovalSeq);

		rMap = worksApprovalDocDao.dPrcDocApproval(map);

		r_msg					= CommonUtil.isNull(rMap.get("r_msg"));
		r_code 					= CommonUtil.isNull(rMap.get("r_code"));
		r_state_cd 				= CommonUtil.isNull(rMap.get("r_state_cd"));
		r_apply_cd 				= CommonUtil.isNull(rMap.get("r_apply_cd"));

		//결재자 통보여부 체크
		if(r_state_cd.equals("01")){
			bJobApprovalChk = "Y";
		//반영완료/반려 시 의뢰자 통보여부 체크
		}else if(r_apply_cd.equals("02") || r_state_cd.equals("04")){
			bJobExcChk = "Y";
		}

		if ("1".equals(CommonUtil.isNull(rMap.get("r_code")))) {
			sb.append(CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg"))));
		}

		//결재 처리 후 반영 시점에 그룹 내 문서도 조회 후 반영한다.
		if ( "1".equals(r_code) && "02".equals(r_apply_cd) ) {
			map.put("doc_cnt", doc_cnt);
			//메인문서만 결재 처리해줘야 함/단건도마찬가지
			List mainDocInfoList = worksApprovalDocDao.dGetMainDocInfoList(map);

			//문서가 승인취소/삭제됐을 때 대비해서 체크로직 추가
			if (mainDocInfoList.size() == 0) {
				Map rMap2 = new HashMap();
				//rMap2.put("r_code",	"-1");
				rMap2.put("r_code", "-2");
				rMap2.put("r_msg", "ERROR.82");
				rMap2.put("rMsg", "ERROR.82");    // 일괄 결재 시 rMsg로 설정해야 정상적으로 오류 출력??
				throw new DefaultServiceException(rMap2);
			}
			
			// 오더된 작업 컨디션 일괄삭제
			for (int j = 0; j < mainDocInfoList.size(); j++) {
				DocInfoBean docInfo = (DocInfoBean) mainDocInfoList.get(j);
				doc_gb = CommonUtil.isNull(docInfo.getDoc_gb());
				
				if(doc_gb.equals("05")) {
					doc_cd 				= CommonUtil.isNull(docInfo.getDoc_cd());
					strTableName 		= CommonUtil.isNull(docInfo.getTable_name());
					strJobName 			= CommonUtil.isNull(docInfo.getJob_name());
					strDataCenter 		= CommonUtil.isNull(docInfo.getData_center());
					
					map.put("doc_cd"	,doc_cd);
					map.put("p_sched_table", strTableName);
					map.put("job_name", strJobName);
					map.put("data_center", strDataCenter);
					rMap = CommonWorksUtil.jobsDeleteCondition(map);
					
				}
			}

			for (int j = 0; j < mainDocInfoList.size(); j++) {

				DocInfoBean docInfo = (DocInfoBean) mainDocInfoList.get(j);

				doc_gb 				= CommonUtil.isNull(docInfo.getDoc_gb());
				doc_cd 				= CommonUtil.isNull(docInfo.getDoc_cd());
				strTableId 			= CommonUtil.isNull(docInfo.getTable_id());
				strJobId 			= CommonUtil.isNull(docInfo.getJob_id());
				strTableName 		= CommonUtil.isNull(docInfo.getTable_name());
				strJobName 			= CommonUtil.isNull(docInfo.getJob_name());
				strDataCenter 		= CommonUtil.isNull(docInfo.getData_center());
				strMainDocCd 		= CommonUtil.isNull(docInfo.getMain_doc_cd());
				strDescription 		= CommonUtil.isNull(docInfo.getDescription());

				map.put("flag"				,"exec");
				map.put("doc_cd"			,doc_cd);
				map.put("doc_gb"			,doc_gb);
				map.put("table_id"			,strTableId);
				map.put("table_name"		,strTableName);
				map.put("p_sched_table"		,strTableName);
				map.put("job_id"			,strJobId);
				map.put("job_name"			,strJobName);
				map.put("approval_seq"		,strCurApprovalSeq);
				map.put("data_center"		,strDataCenter);
				map.put("description"		,strDescription);

				rMap = worksApprovalDocDao.dPrcDocApproval(map);

				try{
					if (doc_gb.equals("01")) {
						// 정기 작업 등록 API 공통 처리
						rMap = CommonWorksUtil.prcDefCreateJobs(map, null);
						//등록 API 오류메세지 처리
						r_code = CommonUtil.isNull(rMap.get("rCode"));
						r_msg  = CommonUtil.isNull(rMap.get("rMsg"));

						if( !"1".equals(r_code)){
							rMap.put("r_code", 	"-2");
							rMap.put("r_msg", 	r_msg);
							throw new DefaultServiceException(rMap);
						}
					} else if (doc_gb.equals("02")) {
						// 일회성 작업 등록 API 공통 처리
						rMap = CommonWorksUtil.createJobs(map);
					} else if (doc_gb.equals("03")) {
						// 작업 삭제 API 공통 처리
						rMap = CommonWorksUtil.deleteJobs(map);
					} else if (doc_gb.equals("04")) {

						map.put("p_sched_table", map.get("table_name"));
						Doc01Bean doc01OriBean = worksApprovalDocDao.dGetJobModifyInfo(map);

						// 수정 요청 : 삭제 진행
						// 작업 삭제 API 공통 처리
						rMap = CommonWorksUtil.deleteJobs(map);

						String rCode = CommonUtil.isNull(rMap.get("rCode"));

						if (!"1".equals(rCode)) {
							rMap.put("r_code", "-1");
							throw new DefaultServiceException(rMap);
						} else {

							// 삭제 성공 -> 신규 등록 진행
							// 정기 작업 등록 API 공통 처리
							map.put("org", "");
							rMap = CommonWorksUtil.prcDefCreateJobs(map, null);

							rCode = CommonUtil.isNull(rMap.get("rCode"));
							rMsg = CommonUtil.isNull(rMap.get("rMsg"));

							if (!"1".equals(rCode)) {

								if (doc01OriBean != null) {

									// 삭제 성공 -> 신규 등록 실패 -> 기존 작업 원복 진행
									// 정기 작업 등록 API 공통 처리
									map.put("org", "Y");
									rMap = CommonWorksUtil.prcDefCreateJobs(map, doc01OriBean);

									rCode = CommonUtil.isNull(rMap.get("rCode"));
									if( !"1".equals(rCode)){
										logger.error("[수정 요청 후 작업 삭제] 작업명: " + strJobName);
									} else {
										logger.info("[수정 요청 후 작업 원복 완료] 작업명: " + strJobName);
									}

								} else {
									logger.error("[수정 요청 후 작업 삭제 원복] -> 원복할 정보가 존재하지 않습니다.");
								}

								rMap.put("r_code", "-2");
								rMap.put("r_msg", rMsg);
								throw new DefaultServiceException(rMap);
							}
						}

					} else if ("05".equals(doc_gb)) {
						// 작업 오더 API 공통 처리
						rMap = CommonWorksUtil.jobsOrder(map);
						String rCode = CommonUtil.isNull(rMap.get("rCode"));
						if( !"1".equals(rCode)) {
							throw new DefaultServiceException(rMap);
						}
					} else if ("07".equals(doc_gb)) {
						// 상태 변경 API 공통 처리
						rMap = CommonWorksUtil.jobAction(map);
						String rCode = CommonUtil.isNull(rMap.get("rCode"));
						if( !"1".equals(rCode)) {
							throw new DefaultServiceException(rMap);
						}
					} else if ("10".equals(doc_gb)) {

						String strAlarm_cd	 		= CommonUtil.isNull(docInfo.getAlarm_cd());
						String strErrorDescription 	= CommonUtil.isNull(docInfo.getError_description());
						String user_cd				= CommonUtil.isNull(docInfo.getUser_cd());

						map.put("alarm_cd", strAlarm_cd);
						map.put("error_description", strErrorDescription);
						map.put("user_cd", user_cd);

						rMap = CommonWorksUtil.jobErrorDescUdt(map);

						r_code = CommonUtil.isNull(rMap.get("r_code"));
						if( !"1".equals(r_code)) {
							throw new DefaultServiceException(rMap);
						}
					} else if ("06".equals(doc_gb)) {

						Doc01Bean doc01 = new Doc01Bean();
						Doc06Bean doc06 = worksApprovalDocDao.dGetDoc06(map);

						doc01.setData_center(CommonUtil.isNull(doc06.getData_center()));
						doc01.setTable_name(CommonUtil.isNull(doc06.getTable_name()));
						doc01.setTable_cnt(CommonUtil.isNull(doc06.getTable_cnt()));
						doc01.setUser_daily(CommonUtil.isNull(doc06.getUser_daily()));
						doc01.setDoc_cd(CommonUtil.isNull(doc06.getDoc_cd()));

						map.put("doc01", doc01);

						List<Doc06Bean> alDocList = new ArrayList();
						alDocList = worksApprovalDocDao.dGetDoc06DetailList(map);

						String act_gb = CommonUtil.isNull(doc06.getAct_gb());

						// 쿼츠에 있는 로직 가져와서 즉시 반영으로 변경
						String docCd = CommonUtil.isNull(map.get("doc_cd"));

						Map<String, Object> quartz_map = new HashMap<String, Object>();
						quartz_map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

						logger.info("#EzExcelBatchQuartzServiceImpl | Start~~~");

						quartz_map.put("flag", act_gb);
						quartz_map.put("doc_cd", docCd);

						Map<String, Object> quartz_rMap = new HashMap<>();
						Map<String, Object> quartz_rTokenMap = new HashMap<String, Object>();

						logger.info("#EzExcelBatchQuartzServiceImpl | flag ::" + act_gb);

						try {

							List<Doc06Bean> dt_list = quartzDao.dGetExcelBatchExecuteGroup(quartz_map);

							if (dt_list.size() > 0) {

								//ConnectionManager cm = new ConnectionManager();
								//quartz_rTokenMap = cm.login(map);

								HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
								String strUserToken = "";

								CommonUtil.emLogin(request);
								strUserToken = CommonUtil.isNull(request.getSession().getAttribute("USER_TOKEN"));

								quartz_map.put("userToken", CommonUtil.isNull(strUserToken));

								logger.info("#EzExcelBatchQuartzServiceImpl | userToken ::" + CommonUtil.isNull(strUserToken));

								for (int h = 0; h < dt_list.size(); h++) {

									Doc06Bean dt_bean = dt_list.get(h);

									quartz_map.put("data_center", dt_bean.getData_center());
									quartz_map.put("table_name", dt_bean.getTable_name());
									
									List<Doc06Bean> list = quartzDao.dGetExcelBatchList(quartz_map);

									int list_cnt = 0;
									list_cnt = list.size();

									if (list_cnt > 0) {

										T_Manager5 t = new T_Manager5();

										if (act_gb.equals("D")) { //삭제일경우

											StringBuffer quartz_sb = new StringBuffer();

											for (int i = 0; i < list_cnt; i++) {
												Doc06Bean bean = list.get(i);

												try {

													Map<String, Object> delMap = new HashMap<>();

													delMap.put("job_name", CommonUtil.isNull(bean.getJob_name()));
													delMap.put("table_name", CommonUtil.isNull(bean.getTable_name()));
													delMap.put("application", CommonUtil.isNull(bean.getApplication()));
													delMap.put("group_name", CommonUtil.isNull(bean.getGroup_name()));
													delMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

													//String before_table = quartzDao.dGetExcelBatchDelTable(delMap);
													//bean.setTable_name(CommonUtil.isNull(before_table));

													// CTM api Call
													quartz_map.put("doc06", bean);
													quartz_rMap = t.deleteJobs(quartz_map);
													String rApiCode = CommonUtil.isNull(quartz_rMap.get("rCode"));
													String rApiMsg = CommonUtil.isNull(quartz_rMap.get("rMsg"));

													logger.info("#EzExcelBatchQuartzServiceImpl | DELETE |job_name ::" + CommonUtil.isNull(bean.getJob_name()));
													logger.info("#EzExcelBatchQuartzServiceImpl | DELETE |rApiCode ::" + rApiCode);
													logger.info("#EzExcelBatchQuartzServiceImpl | DELETE |rApiMsg ::" + rApiMsg);

													String strUploadDataCenter = CommonUtil.isNull(bean.getData_center());

													if (strUploadDataCenter.indexOf(",") > -1) {
														strUploadDataCenter = strUploadDataCenter.split(",")[1];
													}

													// 업로드 테이블 추출
													quartz_sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
													quartz_sb.append(",");

													// EZ_DOC_06_DETAIL 플래그 업데이트
													if (rApiCode.equals("1")) {
														if (bean.getAct_gb().equals("U")) { //act_gb:U 일경우 apply_check:R 로
															quartz_map.put("apply_check", "R");
															quartz_map.put("r_msg", "삭제성공");
														} else {
															quartz_map.put("apply_check", "Y");
															quartz_map.put("r_msg", "성공");
														}

														quartz_map.put("doc_cd", bean.getDoc_cd());
														quartz_map.put("seq", bean.getSeq());

														quartzDao.dPrcExcelBatchApplyUpdate(quartz_map);

													} else {

														// 삭제실패(삭제할 대상이 없을 경우가 대부분일 듯)
														if (bean.getAct_gb().equals("U")) { //act_gb:U 일경우 apply_check:R 로
															quartz_map.put("apply_check", "R");
															quartz_map.put("r_msg", rApiMsg);
														} else {
															quartz_map.put("apply_check", "Y");
															quartz_map.put("r_msg", rApiMsg);
														}

														quartz_map.put("doc_cd", bean.getDoc_cd());
														quartz_map.put("seq", bean.getSeq());

														quartzDao.dPrcExcelBatchApplyUpdate(quartz_map);
													}

												} catch (Exception e) {
													logger.info("#EzExcelBatchQuartzServiceImpl | deleteJobs | Execute| Error :::" + e.getMessage());
												}
											}

											// 추출한 테이블 업로드
											String strUploadTable = CommonUtil.dupStringCheck(quartz_sb.toString());

											if (!strUploadTable.equals("")) {

												String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");

												for (int jj = 0; jj < arrUploadTable.length; jj++) {

													quartz_map.put("table_name", arrUploadTable[jj].split("[|]")[0]);
													quartz_map.put("data_center", arrUploadTable[jj].split("[|]")[1]);

													// 실제 업로드 수행
													t.defUploadjobs(quartz_map);
												}
											}

										} else if (act_gb.equals("C")) { //등록일경우

											StringBuffer quartz_sb = new StringBuffer();

											for (int i = 0; i < list_cnt; i++) {
												Doc06Bean bean = list.get(i);

												try {

													Map<String, Object> checkMap = new HashMap<>();

													checkMap.put("job_name", CommonUtil.isNull(bean.getJob_name()));
													checkMap.put("data_center", CommonUtil.isNull(bean.getData_center()));
													checkMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

													// 작업이 Control-M에 등록되어 있는지 확인.
													CommonBean quartz_commonBean = worksApprovalDocDao.dGetChkDefJobCnt(checkMap);

													if (quartz_commonBean.getTotal_count() == 0) {

														//CTM api Call
														quartz_map.put("doc06", bean);
														quartz_rMap = t.defCreateJobs(quartz_map);

														String rApiCode = CommonUtil.isNull(quartz_rMap.get("rCode"));
														String rApiMsg = CommonUtil.isNull(quartz_rMap.get("rMsg"));

														logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |job_name ::" + CommonUtil.isNull(bean.getJob_name()));
														logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |rApiCode ::" + rApiCode);
														logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |rApiMsg ::" + rApiMsg);

														String strUploadDataCenter = CommonUtil.isNull(bean.getData_center());
														if (strUploadDataCenter.indexOf(",") > -1) {
															strUploadDataCenter = strUploadDataCenter.split(",")[1];
														}

														// 업로드 테이블 추출
														quartz_sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
														quartz_sb.append(",");

														// EZ_DOC_06_DETAIL 플래그 업데이트
														if (rApiCode.equals("1")) {
															
															// EM API 호출 시 서브 폴더에 넣어도 최상단 스마트 폴더에 들어가는 버그 있는 듯.
															// DB 업데이트로 진행 해본다. (2024.05.02 강명준)
															String strParentTable = CommonUtil.isNull(bean.getTable_name());
															
															// EM API 호출 시 서브 폴더에 넣어도 최상단 스마트 폴더에 들어가는 버그 있는 듯.
															// DB 업데이트로 진행 해본다. (2024.05.02 강명준)
															if ( strParentTable.indexOf("/") > -1 ) {
																
																Connection conn			= null;
																PreparedStatement ps 	= null;
																
																com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
																conn = DbUtil.getConnection(ds);
																
																StringBuffer sql = new StringBuffer();
																
																sql.setLength(0);
																sql.append(" UPDATE DEF_JOB SET parent_table = '" + strParentTable + "' WHERE job_name = '" + strJobName + "' ");					
																	
																ps = conn.prepareStatement(sql.toString());
																ps.executeUpdate();
																
																ps.close();
																conn.close();
															}
															
															quartz_map.put("apply_check", "Y");
															quartz_map.put("r_msg", "등록성공");
															quartz_map.put("doc_cd", bean.getDoc_cd());
															quartz_map.put("seq", bean.getSeq());

															quartzDao.dPrcExcelBatchApplyUpdate(quartz_map);

															// 최종 반영 후 JOB_MAPPER에 등록
															CommonUtil.jobMapperInsertPrc(bean.getDoc_cd(), CommonUtil.isNull(bean.getJob_name()));
															
														} else {

															quartz_map.put("r_msg", rApiMsg);
															quartz_map.put("doc_cd", bean.getDoc_cd());
															quartz_map.put("seq", bean.getSeq());

															quartzDao.dGetExcelBatchErrMsgUpdate(quartz_map);

															logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |ERRORLOG ::" + quartz_map.get("r_msg"));
														}

													} else {

														quartz_map.put("r_msg", "중복 작업 존재");
														quartz_map.put("doc_cd", bean.getDoc_cd());
														quartz_map.put("seq", bean.getSeq());

														quartzDao.dGetExcelBatchErrMsgUpdate(quartz_map);

														logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |ERRORLOG ::" + quartz_map.get("r_msg"));
													}

												} catch (Exception e) {

													logger.info("#EzExcelBatchQuartzServiceImpl | CREATE | Execute | Error :::" + e.getMessage());
												}
											}

											// 추출한 테이블 업로드
											String strUploadTable = CommonUtil.dupStringCheck(quartz_sb.toString());

											if (!strUploadTable.equals("")) {

												String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");

												for (int jj = 0; jj < arrUploadTable.length; jj++) {

													quartz_map.put("table_name", arrUploadTable[jj].split("[|]")[0]);
													quartz_map.put("data_center", arrUploadTable[jj].split("[|]")[1]);

													// 실제 업로드 수행
													t.defUploadjobs(quartz_map);
												}
											}

										} else if (act_gb.equals("U")) {

											// 삭제 일괄 처리 먼저.
											StringBuffer quartz_sb = new StringBuffer();

											for (int i = 0; i < list_cnt; i++) {
												Doc06Bean bean = list.get(i);

												// 수정 요청 시 테이블명이 변경되는 것을 대비해서 변경 테이블 셋팅.
												String strAfterTableName = CommonUtil.isNull(bean.getTable_name());
												String strAfterApplication = CommonUtil.isNull(bean.getApplication());
												String strAfterGroupName = CommonUtil.isNull(bean.getGroup_name());

												try {

													Map<String, Object> delMap = new HashMap<>();

													delMap.put("job_name", CommonUtil.isNull(bean.getJob_name()));
													delMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

													CommonBean quartz_List = quartzDao.dGetExcelBatchDelTable(delMap);
													//String before_table = quartzDao.dGetExcelBatchDelTable(delMap);


													bean.setTable_name(CommonUtil.isNull(quartz_List.getSched_table()));
													bean.setApplication(CommonUtil.isNull(quartz_List.getApplication()));
													bean.setGroup_name(CommonUtil.isNull(quartz_List.getGroup_name()));

													// CTM api Call
													quartz_map.put("doc06", bean);
													quartz_rMap = t.deleteJobs(quartz_map);

													String rApiCode = CommonUtil.isNull(quartz_rMap.get("rCode"));
													String rApiMsg = CommonUtil.isNull(quartz_rMap.get("rMsg"));

													logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE |job_name ::" + CommonUtil.isNull(bean.getJob_name()));
													logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE |rApiCode ::" + rApiCode);
													logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE |rApiMsg ::" + rApiMsg);

													String strUploadDataCenter = CommonUtil.isNull(bean.getData_center());

													if (strUploadDataCenter.indexOf(",") > -1) {
														strUploadDataCenter = strUploadDataCenter.split(",")[1];
													}

													// 업로드 테이블 추출
													quartz_sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
													quartz_sb.append(",");

													// EZ_DOC_06_DETAIL 플래그 업데이트
													if (rApiCode.equals("1")) {
														if (bean.getAct_gb().equals("U")) { //act_gb:U 일경우 apply_check:R 로
															quartz_map.put("apply_check", "R");
															quartz_map.put("r_msg", "삭제성공");
														} else {
															quartz_map.put("apply_check", "Y");
															quartz_map.put("r_msg", "성공");
														}

														quartz_map.put("doc_cd", bean.getDoc_cd());
														quartz_map.put("seq", bean.getSeq());

														quartzDao.dPrcExcelBatchApplyUpdate(quartz_map);

													} else {

														// 삭제실패(삭제할 대상이 없을 경우가 대부분일 듯)
														if (bean.getAct_gb().equals("U")) { //act_gb:U 일경우 apply_check:R 로
															quartz_map.put("apply_check", "R");
															quartz_map.put("r_msg", rApiMsg);
														} else {
															quartz_map.put("apply_check", "Y");
															quartz_map.put("r_msg", rApiMsg);
														}

														quartz_map.put("doc_cd", bean.getDoc_cd());
														quartz_map.put("seq", bean.getSeq());

														quartzDao.dPrcExcelBatchApplyUpdate(quartz_map);
													}

												} catch (Exception e) {
													logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE | Execute| Error :::" + e.getMessage());
												}

												bean.setTable_name(strAfterTableName);
												bean.setApplication(strAfterApplication);
												bean.setGroup_name(strAfterGroupName);
											}

											// 삭제 후 1초 딜레이
											logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-DELETE 후 1초 딜레이");
											CommonUtil.setTimeout(1000);

											// 신규 일괄로 마무리.
											//quartz_sb = new StringBuffer();

											for (int i = 0; i < list_cnt; i++) {

												Doc06Bean bean = list.get(i);

												logger.info("bean.getTable_name() : " + bean.getTable_name());
												logger.info("bean.getApplication() : " + bean.getApplication());
												logger.info("bean.getGroup_name() : " + bean.getGroup_name());

												try {

													Map<String, Object> checkMap = new HashMap<>();

													checkMap.put("job_name", CommonUtil.isNull(bean.getJob_name()));
													checkMap.put("data_center", CommonUtil.isNull(bean.getData_center()));
													checkMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

													// 작업이 Control-M에 등록되어 있는지 확인.
													CommonBean quartz_commonBean = worksApprovalDocDao.dGetChkDefJobCnt(checkMap);

													if (quartz_commonBean.getTotal_count() == 0) {
														//CTM api Call
														quartz_map.put("doc06", bean);
														quartz_rMap = t.defCreateJobs(quartz_map);

														String rApiCode = CommonUtil.isNull(quartz_rMap.get("rCode"));
														String rApiMsg = CommonUtil.isNull(quartz_rMap.get("rMsg"));

														logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |job_name ::" + CommonUtil.isNull(bean.getJob_name()));
														logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |rApiCode ::" + rApiCode);
														logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |rApiMsg ::" + rApiMsg);

														String strUploadDataCenter = CommonUtil.isNull(bean.getData_center());
														if (strUploadDataCenter.indexOf(",") > -1) {
															strUploadDataCenter = strUploadDataCenter.split(",")[1];
														}

														// 업로드 테이블 추출
														quartz_sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
														quartz_sb.append(",");

														// EZ_DOC_06_DETAIL 플래그 업데이트
														if (rApiCode.equals("1")) {
															
															String strParentTable = CommonUtil.isNull(bean.getTable_name());
															
															// EM API 호출 시 서브 폴더에 넣어도 최상단 스마트 폴더에 들어가는 버그 있는 듯.
															// DB 업데이트로 진행 해본다. (2024.05.02 강명준)
															if ( strParentTable.indexOf("/") > -1 ) {
																
																Connection conn			= null;
																PreparedStatement ps 	= null;
																
																com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
																conn = DbUtil.getConnection(ds);
																
																StringBuffer sql = new StringBuffer();
																
																sql.setLength(0);
																sql.append(" UPDATE DEF_JOB SET parent_table = '" + strParentTable + "' WHERE job_name = '" + strJobName + "' ");					
																	
																ps = conn.prepareStatement(sql.toString());
																ps.executeUpdate();
																
																ps.close();
																conn.close();
															}

															quartz_map.put("apply_check", "Y");
															quartz_map.put("r_msg", "수정성공");
															quartz_map.put("doc_cd", bean.getDoc_cd());
															quartz_map.put("seq", bean.getSeq());

															quartzDao.dPrcExcelBatchApplyUpdate(quartz_map);

															// 최종 반영 후 JOB_MAPPER에 등록
															CommonUtil.jobMapperInsertPrc(bean.getDoc_cd(), CommonUtil.isNull(bean.getJob_name()));

														} else {

															rApiMsg = "삭제성공 이후 등록실패 : " + rApiMsg;

															quartz_map.put("r_msg", rApiMsg);
															quartz_map.put("doc_cd", bean.getDoc_cd());
															quartz_map.put("seq", bean.getSeq());

															quartzDao.dGetExcelBatchErrMsgUpdate(quartz_map);

															logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |ERRORLOG ::" + quartz_map.get("r_msg"));
														}

													} else {

														quartz_map.put("r_msg", "삭제실패 : 중복 작업 존재");
														quartz_map.put("doc_cd", bean.getDoc_cd());
														quartz_map.put("seq", bean.getSeq());

														quartzDao.dGetExcelBatchErrMsgUpdate(quartz_map);

														logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE |ERRORLOG ::" + quartz_map.get("r_msg"));
													}

												} catch (Exception e) {

													logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE | Execute | Error :::" + e.getMessage());
												}
											}

											logger.info("#EzExcelBatchQuartzServiceImpl | UPDATE-CREATE-UPLOAD 테이블 취합 " + quartz_sb.toString());

											// 추출한 테이블 업로드
											String strUploadTable = CommonUtil.dupStringCheck(quartz_sb.toString());

											if (!strUploadTable.equals("")) {

												String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");

												for (int jj = 0; jj < arrUploadTable.length; jj++) {

													quartz_map.put("table_name", arrUploadTable[jj].split("[|]")[0]);
													quartz_map.put("data_center", arrUploadTable[jj].split("[|]")[1]);

													// 실제 업로드 수행
													t.defUploadjobs(quartz_map);
												}
											}
										}
									}
								}
							}

						} catch (Exception e) {
							logger.info("#EzExcelBatchQuartzServiceImpl | Error :::" + e.getMessage());
						} finally {
						}
						logger.info("#EzExcelBatchQuartzServiceImpl | End~~~");
					}

				} catch (DefaultServiceException e) {
					System.out.println("#WorksApprovalDocServiceImpl | DefaultServiceException");
					rMap = e.getResultMap();
					System.out.println("::::rMap::::::::::::"+rMap);
					r_msg = CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")));
					if (r_msg.equals("")) {
						r_msg = CommonUtil.isNull(rMap.get("r_msg"));
					}

					//그룹 내 문서에 대한 오류메세지 노출 가능?
					sb.append("\n\n");
					sb.append("[오류발생 : 상세화면 확인 필요]");
					sb.append(CommonUtil.E2K(doc_cd) + " : " + r_msg);


					// 에러가 난 작업은 반영상태: 실패로 찍어준다. (2023.07.10 강명준)
					rMap3.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA." + CommonUtil.getMessage("DB_GUBUN") + "." + CommonUtil.getMessage("SERVER_GB")));
					rMap3.put("flag", "group_order_exec_fail");
					rMap3.put("doc_cd", doc_cd);
					//rMap3.put("approval_comment"	, CommonUtil.isNull(rMap.get("original_r_msg"), CommonUtil.getMessage(CommonUtil.isNull(rMap.get("r_msg")))));
					rMap3.put("approval_comment", r_msg);
					//등록/긴급/수정 시 관리자 즉시결재 반영실패 시 원복시킨다.
					if(strFlag.equals("draft_admin") && ("01".equals(doc_gb) || "02".equals(doc_gb) || "04".equals(doc_gb))) {
						rMap3.put("flag", "def_cancel");
						rMap3.put("doc_gb", doc_gb);
					}

					rMap3 = worksApprovalDocDao.dPrcDocApproval(rMap3);

					r_code = CommonUtil.isNull(rMap3.get("r_code"));

					if (!"1".equals(r_code)) {
						//throw new DefaultServiceException(rMap);
					}
					// 파라미터 원복 (2023.10.26 강명준)
					rMap3.put("approval_comment", "");

				} finally {
					if ("1".equals(CommonUtil.isNull(rMap.get("r_code"))))  {
						successCnt++;
					}else{
						failCnt++;
					}


				}
			}

			if (mainDocInfoList.size() != successCnt) {
				sb.append("\n");
			}

			//if(failCnt > 0) sb.insert(4,"\n\n" + mainDocInfoList.size() + "건의 작업 중 " + successCnt + "건 반영 완료 " + failCnt +"건 반영 실패");
			//if(failCnt == 0) sb.insert(4,"\n\n" + mainDocInfoList.size() + "건의 작업 중 " + successCnt + "건 반영 완료");

			if(!strMainDocCd.equals("")) {
				// 최종 결재 시 main_doc_cd의 apply_cd 적용시키는 구간
				map.put("flag", "group_approval_end");
				map.put("doc_cd", strMainDocCd);
				worksApprovalDocDao.dPrcDocApproval(map);
			}
		}

		rMap.put("r_msg",sb);
		rMap.put("doc_cd", doc_cd);
		rMap.put("sendInsUserNoti" , bJobExcChk);
		rMap.put("sendApprovalNoti" , bJobApprovalChk);

		// 일괄 결재일 경우 Controller에서 업로드 수행.
		// 일괄 결재일 경우 업로드를 한번에 하기 위해 r_table 셋팅.
		if ( group_approval.equals("Y") ) {

			String strUploadTable = CommonUtil.isNull(upload_sb.toString());
			rMap.put("r_table",	strUploadTable);

		// 폴더 업로드는 아래 4개만 진행 한다. (2023.11.30 강명준)
		} else if ( doc_gb.equals("01") || doc_gb.equals("03") || doc_gb.equals("04") || doc_gb.equals("06") ) {
			
			paramMap.put("userToken", 	CommonUtil.isNull(map.get("userToken")));

			String strUploadTable = CommonUtil.dupStringCheck(upload_sb.toString());
			
			logger.info("(" + doc_cd + ")" + "업로드 대상 폴더 : " + strUploadTable);

			if ( !strUploadTable.equals("") ) {

				String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");
				Map upload_Map = new HashMap();

				for ( int j = 0; j < arrUploadTable.length; j++ ) {

					paramMap.put("table_name", 	arrUploadTable[j].split("[|]")[0]);
					paramMap.put("data_center", arrUploadTable[j].split("[|]")[1]);

					// 실제 업로드 수행
					upload_Map = emJobUploadDao.defUploadJobs(paramMap);
					
					//업로드 수행 후 에러 발생시 예외 처리
					if(!upload_Map.get("rCode").equals("1")) {
						
						logger.info("폴더 upload 작업 실패 ::: " + paramMap.get("table_name"));
						
						upload_Map.put("r_msg", "폴더 upload 작업 실패");
						
						//업로드 수행 실패 후 업로드 초기화
						upload_sb.setLength(0);
						
						throw new DefaultServiceException(upload_Map);
					}
				}
			}
			
			//업로드 수행 후 업로드 초기화
			upload_sb.setLength(0);
		}

		return rMap;
	}
	
	public Map emPrcJobAction(Map map) throws Exception{
		
		Map<String, Object> rMap 	= new HashMap<String, Object>(); 
		
		String strFlag 			= CommonUtil.isNull(map.get("flag"));
		String strDataCenter 	= CommonUtil.isNull(map.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(map.get("order_id"));
		String hostname 		= CommonUtil.isNull(CommonUtil.getHostIp());		
			
		// Host 정보 가져오는 서비스.	
		map.put("server_gubun"	, "S");
		
		CommonBean bean = commonDao.dGetHostInfo(map);
		
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}
		
		String strResult = "";
		
		// DELETE 명령어는 API 기능에 없으므로 UTIL 사용.
		if ( "DELETE".equals(strFlag) ){
			
			try{
				
				String cmd 	= "ctmpsm -UPDATEAJF "+strOrderId+" HOLD \r\n ctmpsm -UPDATEAJF "+strOrderId+" DELETE";
				
				if(!"".equals(strHost)){
					
					if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
						
						Process proc 					= null;
						InputStream inputStream 		= null;
						BufferedReader bufferedReader 	= null;
						String[] cmd2					= null;
						String osName 					= System.getProperty("os.name");
						
						if(osName.toLowerCase().startsWith("window")) {
							cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
						} else {
							cmd2 = new String[] { "/bin/sh", "-c", cmd };
						}
					
						proc = Runtime.getRuntime().exec(cmd2);			
						inputStream = proc.getInputStream();
						bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
				
						bufferedReader.close();
						inputStream.close();
						
					} else {
					
						if( "S".equals(strAccessGubun) ){
							Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
							strResult = su.getOutput();
						}else{
							TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);							
						}
					}
				}
				
				if ( strResult.indexOf("successfully") > -1 ) {
					rMap.put("r_code", 	"1");
					rMap.put("rCode", 	"1");
					rMap.put("r_msg", 	"DEBUG.01");				
					rMap.put("rMsg", 	"처리 완료");
				} else {
					rMap.put("r_code", 	"-1");
					rMap.put("rCode", 	"-1");
					rMap.put("r_msg", 	strResult);				
					rMap.put("rMsg", 	strResult);
				}
				
			}catch(Exception e){
				logger.error(e.getMessage());
			}
			
		// UNDELETE 명령어는 API 기능에 없으므로 UTIL 사용.
		} else if ( "UNDELETE".equals(strFlag) ){
		
			try{
				
				String cmd 	= "ctmpsm -UPDATEAJF "+strOrderId+" UNDELETE";
				
				if(!"".equals(strHost)){
					
					if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
						
						Process proc 					= null;
						InputStream inputStream 		= null;
						BufferedReader bufferedReader 	= null;
						String[] cmd2					= null;
						String osName 					= System.getProperty("os.name");
						
						if(osName.toLowerCase().startsWith("window")) {
							cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
						} else {
							cmd2 = new String[] { "/bin/sh", "-c", cmd };
						}
					
						proc = Runtime.getRuntime().exec(cmd2);			
						inputStream = proc.getInputStream();
						bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
					
						bufferedReader.close();
						inputStream.close();
						
					} else {
					
						if( "S".equals(strAccessGubun) ){
							Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
							strResult = su.getOutput();
						}else{
							TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);							
						}
					}
				}
				
				if ( strResult.indexOf("successfully") > -1 ) {
					rMap.put("r_code", 	"1");
					rMap.put("rCode", 	"1");
					rMap.put("r_msg", 	"DEBUG.01");				
					rMap.put("rMsg", 	"처리 완료");
				}
				
			}catch(Exception e){
				logger.error(e.getMessage());
			}
			
		} else {
			System.out.println("delete&unelete 외에 나머지 상태변경");
			rMap = emJobActionDao.jobAction(map);
		}
		
		return rMap;
	}
	
	public Map emPrcJobOrder(Map map) throws Exception{
		
		Map rMap = emJobOrderDao.jobsOrder(map);
				
		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		if( !"1".equals(rCode)){
			rMap.put("r_code", "-1");
			throw new DefaultServiceException(rMap);
		}else{
			rMap.put("r_code", "1");
			rMap.put("r_msg", "DEBUG.03");
		}
		
		return rMap;
	}

	public Map dPrcDefJobsFile(Map map) throws Exception{
		
		String flag = CommonUtil.isNull(map.get("flag"));
		String file_path = CommonUtil.isNull(map.get("file_path"));
		String file_nm = CommonUtil.isNull(map.get("file_nm"));
		
		Map rMap = worksApprovalDocDao.dPrcDefJobsFile(map);
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		String r_code = CommonUtil.isNull(rMap.get("r_code"));
		String r_out = CommonUtil.isNull(rMap.get("r_out"));
		
		if( "ins".equals(flag) ){
			if( "1".equals(r_code) ){
				ExcelUtil eu = new ExcelUtil();
				ArrayList<String[]> al = eu.getExcelRead(file_path, file_nm);
				
				ArrayList alDoc01 = new ArrayList();
				for(int i=1; null!=al&&i<al.size(); i++){
					Doc01Bean docBean = new Doc01Bean();
					String[] items = al.get(i);
					if(null!=items&&0<items.length){
						docBean.setApplication				(CommonUtil.K2E(items[0]));
						docBean.setGroup_name	            (CommonUtil.K2E(items[1]));
						docBean.setMem_name	              	(CommonUtil.K2E(items[2]));
						docBean.setJob_name	              	(CommonUtil.K2E(items[3]));
						docBean.setDescription	          	(CommonUtil.K2E(items[4]));
						docBean.setAuthor	                (CommonUtil.K2E(items[5]));
						docBean.setOwner	                (CommonUtil.K2E(items[6]));
						docBean.setPriority	              	(CommonUtil.K2E(items[7]));
						docBean.setCritical	              	(CommonUtil.K2E(items[8]));
						docBean.setTask_type	            (CommonUtil.K2E(items[9]));
						docBean.setCyclic	                (CommonUtil.K2E(items[10]));
						docBean.setNode_id	              	(CommonUtil.K2E(items[11]));
						docBean.setRerun_interval	        (CommonUtil.K2E(items[12]));
						docBean.setRerun_interval_time	  	(CommonUtil.K2E(items[13]));
						docBean.setMem_lib	              	(CommonUtil.K2E(items[14]));
						docBean.setCommand	              	(CommonUtil.K2E(items[15]));
						docBean.setConfirm_flag	          	(CommonUtil.K2E(items[16]));
						docBean.setDays_cal	              	(CommonUtil.K2E(items[17]));
						docBean.setWeeks_cal	            (CommonUtil.K2E(items[18]));
						docBean.setRetro	                (CommonUtil.K2E(items[19]));
						docBean.setMax_wait	              	(CommonUtil.K2E(items[20]));
						docBean.setRerun_max	            (CommonUtil.K2E(items[21]));
						docBean.setTime_from	            (CommonUtil.K2E(items[22]));
						docBean.setTime_until	            (CommonUtil.K2E(items[23]));
						docBean.setMonth_days	            (CommonUtil.K2E(items[24]));
						docBean.setWeek_days	            (CommonUtil.K2E(items[25]));
						docBean.setMonth_1	              	(CommonUtil.K2E(items[26]));
						docBean.setMonth_2	              	(CommonUtil.K2E(items[27]));
						docBean.setMonth_3	              	(CommonUtil.K2E(items[28]));
						docBean.setMonth_4	              	(CommonUtil.K2E(items[29]));
						docBean.setMonth_5	              	(CommonUtil.K2E(items[30]));
						docBean.setMonth_6	              	(CommonUtil.K2E(items[31]));
						docBean.setMonth_7	              	(CommonUtil.K2E(items[32]));
						docBean.setMonth_8	              	(CommonUtil.K2E(items[33]));
						docBean.setMonth_9	              	(CommonUtil.K2E(items[34]));
						docBean.setMonth_10	              	(CommonUtil.K2E(items[35]));
						docBean.setMonth_11	              	(CommonUtil.K2E(items[36]));
						docBean.setMonth_12	              	(CommonUtil.K2E(items[37]));
						docBean.setCount_cyclic_from	    (CommonUtil.K2E(items[38]));
						docBean.setTime_zone	            (CommonUtil.K2E(items[39]));
						docBean.setMultiagent	            (CommonUtil.K2E(items[40]));
						docBean.setUser_daily	            (CommonUtil.K2E(items[41]));
						docBean.setSchedule_and_or	      	(CommonUtil.K2E(items[42]));
						docBean.setT_general_date	        (CommonUtil.K2E(items[43]));
						docBean.setT_conditions_in	      	(CommonUtil.K2E(items[44]));
						docBean.setT_conditions_out	      	(CommonUtil.K2E(items[45]));
						docBean.setT_resources_q	        (CommonUtil.K2E(items[46]));
						docBean.setT_resources_c	        (CommonUtil.K2E(items[47]));
						docBean.setT_set	                (CommonUtil.K2E(items[48]));
						docBean.setT_steps	              	(CommonUtil.K2E(items[49]));
						docBean.setT_postproc             	(CommonUtil.K2E(items[50]));
					}
					
					alDoc01.add(docBean);
				}
				
				map.put("alDoc01", alDoc01);
				
				rMap = emJobDefinitionDao.prcDefCreateJobs(map);
				
				String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
				if( !"1".equals(rCode)){
					rMap.put("r_code", "-1");
					throw new DefaultServiceException(rMap);
				}else{
					emJobUploadDao.defUploadJobs(map);
				}
				
				File orgFile = new File(file_path,file_nm);
				new File(file_path+r_out).mkdirs();
				File newFile = new File(file_path+r_out,file_nm);
				orgFile.renameTo(newFile);
				
			}
		}else if( "del".equals(flag) ){
			String file_cd = CommonUtil.isNull(map.get("file_cd"));
			
			FileUtil fu = new FileUtil();
			fu.delDir(new File(file_path+file_cd));
		}
		
		return rMap;
	}
	
	public Doc01Bean dGetDefJobInfo(Map map){
    	return worksApprovalDocDao.dGetDefJobInfo(map);
    }
	
	public CommonBean dGetJobGroupListCnt(Map map){
		return worksApprovalDocDao.dGetJobGroupListCnt(map);
	}
	
	public List<JobGroupBean> dGetJobGroupList(Map map){
    	return worksApprovalDocDao.dGetJobGroupList(map);
    }
	
	public JobGroupBean dGetJobGroupDetail(Map map){
		return worksApprovalDocDao.dGetJobGroupDetail(map);
	}
	
	public CommonBean dGetJobGroupDetailListCnt(Map map){
		return worksApprovalDocDao.dGetJobGroupDetailListCnt(map);
	}
	
	public List<DefJobBean> dGetJobGroupDetailList(Map map){
    	return worksApprovalDocDao.dGetJobGroupDetailList(map);
    }
	
	public CommonBean dGetChkGroupJobCnt(Map map){
		return worksApprovalDocDao.dGetChkGroupJobCnt(map);
	}
	
	// 수시작업 등록.
	public Map dPrcJobGroup(Map map) throws Exception {
		
//		Map rMap = null;
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		String strFlag 	= CommonUtil.isNull(map.get("flag"));
		
		if ( strFlag.equals("detail_delete") || strFlag.equals("detail_insert") ) {
			// 그룹 안의 수시 작업 가져오기.
			List jobGroupDetailList = worksApprovalDocDao.dGetJobGroupDetailList(map);
			
			String strCheckTableIds 	= CommonUtil.isNull(map.get("check_table_ids"));
			String strCheckJobIds 		= CommonUtil.isNull(map.get("check_job_ids"));
			String strCheckDataCenters 	= CommonUtil.isNull(map.get("check_data_centers"));
			String strCheckJobNames 	= CommonUtil.isNull(map.get("check_job_names"));
			String strCheckTableNames 	= CommonUtil.isNull(map.get("check_table_names"));
			String strCheckApplications = CommonUtil.isNull(map.get("check_applications"));
			String strCheckGroupNames 	= CommonUtil.isNull(map.get("check_group_names"));
			String strJobgroupId	 	= CommonUtil.isNull(map.get("jobgroup_id"));
			
			String arrCheckTableId[] 		= CommonUtil.isNull(strCheckTableIds).split(",");
			String arrCheckJobId[] 			= CommonUtil.isNull(strCheckJobIds).split(",");
			String arrCheckDataCenter[] 	= CommonUtil.isNull(strCheckDataCenters).split(",");
			String arrstrCheckJobName[] 	= CommonUtil.isNull(strCheckJobNames).split(",");
			String arrstrCheckTableName[] 	= CommonUtil.isNull(strCheckTableNames).split(",");
			String arrstrCheckApplication[] = CommonUtil.isNull(strCheckApplications).split(",");
			String arrstrCheckgroupName[] 	= CommonUtil.isNull(strCheckGroupNames).split(",");
			
			String strData_center		= "";
			if( jobGroupDetailList.size() > 0 ) {
				DefJobBean bean = (DefJobBean) jobGroupDetailList.get(0);
				strData_center = CommonUtil.isNull(bean.getData_center(), "");
			}
			
			for ( int z = 0; z < arrCheckTableId.length; z++) {
	
				map.put("table_id"			, arrCheckTableId[z]);
				map.put("job_id"			, arrCheckJobId[z]);
				map.put("data_center"		, arrCheckDataCenter[z]);
				map.put("job_name"			, arrstrCheckJobName[z]);
				map.put("table_name"		, arrstrCheckTableName[z]);
				map.put("application"		, arrstrCheckApplication[z]);
				map.put("group_name"		, arrstrCheckgroupName[z]);
				map.put("jobgroup_id"		, strJobgroupId);
				if(!strData_center.equals("") && !strData_center.equals(arrCheckDataCenter[z])) {
					rMap.put("r_code","-1");
					rMap.put("r_msg","ERROR.77");
					throw new DefaultServiceException(rMap);
				}
				rMap = worksApprovalDocDao.dPrcJobGroup(map);
			}
			
			// 그룹의 최종수정일을 최근으로 업데이트
			rMap.put("flag", "group_update");
			rMap = worksApprovalDocDao.dPrcJobGroup(map);
			
		} else if ( strFlag.equals("group_insert") || strFlag.equals("group_update") ) {
			
			rMap = worksApprovalDocDao.dPrcJobGroup(map);
		} else if (strFlag.equals("group_delete")) {
			String strCheckgroupId   = CommonUtil.isNull(map.get("jobgroup_id"));
			String arrCheckGroupId[] = CommonUtil.isNull(strCheckgroupId).split(",");
			
			for(int z = 0; z < arrCheckGroupId.length; z++) {
				map.put("jobgroup_id"		, arrCheckGroupId[z]);
				rMap = worksApprovalDocDao.dPrcJobGroup(map);
			}
		} else if (strFlag.equals("update_job_id")) {
//			rMap = worksApprovalDocDao.dPrcJobGroup(map);
		}
		
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public JobGroupBean dGetJobGroupDetailId(Map map){
		return worksApprovalDocDao.dGetJobGroupDetailId(map);
	}

	public Map dPrcDocGroup(Map map) throws Exception {

		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Map<String, Object> ArrMap 	= new HashMap<String, Object>();

		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		String strTitle				= CommonUtil.isNull(map.get("title"));
		String s_user_gb 				= CommonUtil.isNull(map.get("s_user_gb"));
		String strJobGroupId			= CommonUtil.isNull(map.get("jobgroup_id"));
		String order_date				= CommonUtil.isNull(map.get("order_date"));
		String e_order_date			= CommonUtil.isNull(map.get("e_order_date"));
		String days_cal				= CommonUtil.isNull(map.get("days_cal"));

		// 그룹 안의 작업 존재 여부 체크.
		List jobGroupDetailList = worksApprovalDocDao.dGetJobGroupDetailList(map);
		if(jobGroupDetailList.size() == 0) {
			rMap.put("r_code",	"-2");
			rMap.put("r_msg",	CommonUtil.getMessage("ERROR.76"));
			throw new DefaultServiceException(rMap);

		}else {

			String mainDocCd = "";

			map.put("flag", 		"doc_group_insert");
			map.put("jobgroup_id", 	strJobGroupId);
			map.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

			rMap = worksApprovalDocDao.dPrcDoc05(map);

			if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);

			// 그룹으로 작업 한건 추가.
			// 즉시결재와 승인요청은 로직이 다름
			if ( strFlag.equals("draft_admin") ) {
				map.put("flag", 			"group_draft_admin");
			} else if(strFlag.equals("draft")){
				map.put("flag", 			"group_draft");
			} else if(strFlag.equals("post_draft")){
				map.put("flag", 			"group_post_draft");
			}

			map.put("table_id", 		"");
			map.put("job_id", 			"");
			map.put("table_name", 		"");
			map.put("mem_name", 		"");
			map.put("job_name", 		"");
			map.put("order_date", 		order_date);
			map.put("e_order_date", 	e_order_date);
			map.put("days_cal", 		days_cal);

			rMap = worksApprovalDocDao.dPrcDoc05(map);

			if (!"1".equals(CommonUtil.isNull(rMap.get("r_code")))) throw new DefaultServiceException(rMap);
		}

		return rMap;
	}

	public JobGroupBean dGetJobGroupId(Map map){
    	return worksApprovalDocDao.dGetJobGroupId(map);
    }
	
	public JobGroupBean dGetJobGroupMainCd(Map map){
		return worksApprovalDocDao.dGetJobGroupMainCd(map);
	}
	
	public List<Doc05Bean> dGetJobGroupDetailApprovalList(Map map){
		return worksApprovalDocDao.dGetJobGroupDetailApprovalList(map);
	}
	
	public ApprovalInfoBean dGetApprovalMentInfo(Map map){
    	return worksApprovalDocDao.dGetApprovalMentInfo(map);
    }
	
	public CommonBean dGetGeneralApprovalLineCnt(Map map){
    	return worksApprovalDocDao.dGetGeneralApprovalLineCnt(map);
    }
	
	//procedure
	public Map dPrcApprovalDocUserUpdate(Map map){
		
		map.put("flag", "user_update");

		return worksApprovalDocDao.dPrcDocApproval(map);
	}
	
	public Map emPrcAjobUpdate(Map map) throws Exception{
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		System.out.println("map : " + map);
		String strJobName = CommonUtil.isNull(map.get("job_name"));
		
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strOrderId 			= CommonUtil.isNull(map.get("order_id"));
		String strGroupName 		= CommonUtil.isNull(map.get("group_name"));
		String strApplication 		= CommonUtil.isNull(map.get("application"));
		String strNodeId			= CommonUtil.isNull(map.get("node_id"));
		String strMemLib 			= CommonUtil.isNull(map.get("mem_lib"));
		String strMemName 			= CommonUtil.isNull(map.get("mem_name"));
		String strCommand 			= CommonUtil.isNull(map.get("command"));
		String strOwner 			= CommonUtil.isNull(map.get("owner"));
		String strRerunMax 			= CommonUtil.isNull(map.get("rerun_max"));
		String strTimeFrom 			= CommonUtil.isNull(map.get("time_from"));
		//String strTimeUntil 		= CommonUtil.isNull(map.get("time_until"), ">");
		String strTimeUntil 		= CommonUtil.isNull(map.get("time_until")); 
		String strCyclic			= CommonUtil.isNull(map.get("cyclic"));
		String strRerunInterval		= CommonUtil.isNull(map.get("rerun_interval"));
		String strPriority 			= CommonUtil.isNull(map.get("priority"));
		String strMaxWait 			= CommonUtil.isNull(map.get("max_wait"));
		String strTconditionIn		= CommonUtil.isNull(map.get("t_conditions_in"));
		String strTconditionOut		= CommonUtil.isNull(map.get("t_conditions_out"));
		String strTset				= CommonUtil.isNull(map.get("t_set"));
		String strMftValue			= CommonUtil.isNull(map.get("FTP_VALUE"));
		String strTaskType  		= CommonUtil.isNull(map.get("task_type"));
		
		strCommand = strCommand.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		strCommand = strCommand.trim();

		java.net.URLEncoder.encode(strCommand,"UTF-8");

		strTset = strTset.replace("&apos;","\'").replace("&amp;","&").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
		if(strTset.length()>0) {
			strTset += "|" + strMftValue;
		} else {
			strTset += strMftValue;
		}
		strTimeUntil	= strTimeUntil.replace("&gt;",">");
		
		String strReturnMsg 		= "";
		
		String[] aTmpT				= null;
		
		StringBuffer sb 			= new StringBuffer();
	
		try {
			
			String cmd		= " echo ctmpsm -FULLUPDATE " + strOrderId;
			
			if (!strGroupName.equals("") ) {
				cmd 		+= " -GROUP " + " \"" + CommonUtil.replaceStrDoubleQuote(strGroupName) + "\" ";
			}
			
			if (!strApplication.equals("") ) {
				cmd 		+= " -APPLICATION " + " \"" + CommonUtil.replaceStrDoubleQuote(strApplication) + "\" ";
			}
			
			if (!strNodeId.equals("") ) {
				cmd 		+= " -NODEGRP " + " \"" + CommonUtil.replaceStrDoubleQuote(strNodeId) + "\" ";
			}
			
			if (!strMemLib.equals("") ) {
				cmd 		+= " -MEMLIB " + " \"" + CommonUtil.replaceStrDoubleQuote(strMemLib) + "\" ";
			}
			
			if (!strMemName.equals("") ) {
				cmd 		+= " -MEMNAME " + " \"" + CommonUtil.replaceStrDoubleQuote(strMemName) + "\" ";
			}
			
			if (!strCommand.equals("") ) {
				//cmd 		+= " -CMDLINE " + CommonUtil.replaceStr(strCommand);
				cmd 		+= " -CMDLINE " + " \"" + CommonUtil.replaceStrDoubleQuote(strCommand) + "\" ";
			}
			
			if (!strOwner.equals("") ) {
				cmd 		+= " -OWNER " + " \"" + CommonUtil.replaceStrDoubleQuote(strOwner) + "\" ";
			}
			
			if (!strRerunMax.equals("") ) {
				cmd 		+= " -MAXRERUN " + strRerunMax;
			}
			
			if (strTimeFrom.equals("") ) {
				// 시작시간 TIMEFROM을 제거하면 NEWDAY 시간 구해서 SET.
				CtmInfoBean ctmInfoBean = worksApprovalDocDao.dGetEmCommInfo(map);
				strTimeFrom 			= ctmInfoBean.getCtm_daily_time().substring(1, 5);
				
			}
			cmd 		+= " -TIMEFROM " + strTimeFrom;
			
			if (!strTimeUntil.equals("") ) {
				cmd 		+= " -TIMEUNTIL " + " \"" + strTimeUntil + "\" ";
			}else {
				CtmInfoBean ctmInfoBean = worksApprovalDocDao.dGetEmCommInfo(map);
				strTimeUntil 			= ctmInfoBean.getCtm_daily_time().substring(1, 5);
				// NEWDAY에 -1분 값 SET
				SimpleDateFormat df = new SimpleDateFormat("HHmm");
				Date date = df.parse(strTimeUntil);
		 
				Calendar cal = Calendar.getInstance();
				cal.setTime(date);
				cal.add(Calendar.MINUTE, -1);
				strTimeUntil = df.format(cal.getTime());
				cmd 		+= " -TIMEUNTIL " + strTimeUntil;
			}
			
			if (!strCyclic.equals("") ) {
				cmd 		+= " -CYCLIC " + CommonUtil.getMessage("JOB.CYCLIC."+strCyclic).toUpperCase().substring(0, 1);
			}
			
			if (!strRerunInterval.equals("") ) {
				cmd 		+= " -INTERVAL " + strRerunInterval + "M";
			}
			
			if (!strPriority.equals("") ) {
				cmd 		+= " -PRIORITY " + strPriority;
			}
			
			if (!strMaxWait.equals("") ) {
				cmd 		+= " -MAXWAIT " + strMaxWait;
			}
			
			if (!strTconditionIn.equals("") ) {
				aTmpT = strTconditionIn.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",3);
					cmd 		+= " -INCOND " + " \"" + aTmpT1[0] + "\" " + aTmpT1[1] + " " + aTmpT1[2].toUpperCase();
				}
			}
			if (!strTconditionOut.equals("") ) {
				aTmpT = strTconditionOut.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",3);					
					cmd 		+= " -OUTCOND " + " \"" + aTmpT1[0] + "\" " + aTmpT1[1] + " " + aTmpT1[2].toUpperCase();
				}
			}
			
			/*if ( strTaskType.toLowerCase().equals("database") ) {
				//Database
				strTaskType		= "job";
				System.out.println("map : " + map);
				logger.debug("Database 변수 세팅 start ::::: " + strTset);
				
				strMemLib 	= "Database";
				strMemName 	= "Database";
				
				
				//Connection Profile
				if ( strTset.length() > 0 ) {
					strTset = strTset + "|" + "%%DB-ACCOUNT" + "," + CommonUtil.isNull(map.get("db_con_pro"));
				}else {
					strTset = "%%DB-ACCOUNT" + "," + CommonUtil.isNull(map.get("db_con_pro"));
				}
				
				if(!CommonUtil.isNull(map.get("database_type")).equals("")) 	strTset = strTset + "|" + "%%DB-DB_TYPE" + "," + CommonUtil.isNull(map.get("database_type"));
				if(!CommonUtil.isNull(map.get("execution_type")).equals("")) {
					if(CommonUtil.isNull(map.get("execution_type")).equals("P")) {
						strTset = strTset + "|" + "%%DB-EXEC_TYPE" + "," + "Stored Procedure";
						if(!CommonUtil.isNull(map.get("schema")).equals(""))	strTset = strTset + "|" + "%%DB-STP_SCHEM" + "," + CommonUtil.isNull(map.get("schema"));
						if(!CommonUtil.isNull(map.get("sp_name")).equals("")) 	strTset = strTset + "|" + "%%DB-STP_NAME" + "," + CommonUtil.isNull(map.get("sp_name"));
						if(!CommonUtil.isNull(map.get("sp_name")).equals("")) 	strTset = strTset + "|" + "%%DB-STP_PARAMS-P001-PRM_NAME" + "," + CommonUtil.isNull(map.get("sp_name"));
						if(!CommonUtil.isNull(map.get("sp_name")).equals("")) 	strTset = strTset + "|" + "%%DB-STP_PARAMS-P001-PRM_TYPE" + "," + CommonUtil.isNull(map.get("sp_name"));
						if(!CommonUtil.isNull(map.get("sp_name")).equals("")) 	strTset = strTset + "|" + "%%DB-STP_PARAMS-P001-PRM_DIRECTION" + "," + CommonUtil.isNull(map.get("sp_name"));
						if(!CommonUtil.isNull(map.get("sp_name")).equals("")) 	strTset = strTset + "|" + "%%DB-STP_PARAMS-P001-PRM_SETVAR" + "," + CommonUtil.isNull(map.get("sp_name"));
					}else if(CommonUtil.isNull(map.get("execution_type")).equals("Q")) {
						strTset = strTset + "|" + "%%DB-EXEC_TYPE" + "," + "Open Query";
						if(!CommonUtil.isNull(map.get("query")).equals("")) 	strTset = strTset + "|" + "%%DB-QTXT-N001-SUBQTXT" + "," + CommonUtil.isNull(map.get("query")).replaceAll("\"", "\\\\\"").replace("\n", "\\\\n").replaceAll("\r", "");   
						if(!CommonUtil.isNull(map.get("query")).equals("")) 	strTset = strTset + "|" + "%%DB-QTXT-N001-SUBQLENGTH" + "," + Integer.toString(CommonUtil.isNull(map.get("query")).length());
					}
				}
				
				if(!CommonUtil.isNull(map.get("db_autocommit")).equals("")) 	strTset = strTset + "|" + "%%DB-AUTOCOMMIT" + "," + CommonUtil.isNull(map.get("db_autocommit"));
				if(!CommonUtil.isNull(map.get("append_log")).equals("")) 		strTset = strTset + "|" + "%%DB-APPEND_LOG" + "," + CommonUtil.isNull(map.get("append_log"));
				if(!CommonUtil.isNull(map.get("append_output")).equals("")) {
					strTset = strTset + "|" + "%%DB-APPEND_OUTPUT" + "," + CommonUtil.isNull(map.get("append_output"));
					if(CommonUtil.isNull(map.get("append_output")).equals("Y")) {
						if(!CommonUtil.isNull(map.get("sel_db_output_format")).equals("")) {
							if(CommonUtil.isNull(map.get("sel_db_output_format")).equals("T")) {
								strTset = strTset + "|" + "%%DB-OUTPUT_FORMAT" + "," + "Text";
							}else if(CommonUtil.isNull(map.get("sel_db_output_format")).equals("X")) {
								strTset = strTset + "|" + "%%DB-OUTPUT_FORMAT" + "," + "XML";
							}else if(CommonUtil.isNull(map.get("sel_db_output_format")).equals("C")) {
								strTset = strTset + "|" + "%%DB-OUTPUT_FORMAT" + "," + "CSV";
								strTset = strTset + "|" + "%%DB-CSV_SEPERATOR" + "," + CommonUtil.isNull(map.get("csv_seperator"));
							}else {
								strTset = strTset + "|" + "%%DB-OUTPUT_FORMAT" + "," + "HTML";
							}
						}
					}
				}
				
				if ( strTset.substring(strTset.length()-1, strTset.length()).equals("[|]") ) {
					strTset = strTset.substring(0, strTset.length()-1);
				}
				
				logger.debug("strMemLib ::::: " + strMemLib);
				logger.debug("strMemName ::::: " + strMemName);
				logger.debug("Database 변수 세팅 end ::::: " + strTset);
				
			}*/
			
			if (!strTset.equals("") ) {

				aTmpT = strTset.split("[|]");

				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",2);

					cmd 		+= " -VARIABLE %%" + aTmpT1[0] + " \"" + CommonUtil.replaceStrDoubleQuote(aTmpT1[1]) +"\" ";
				}
			}
			
			
			cmd = CommonUtil.replaceStrFullUpdate(cmd); 
			
			cmd += " | sh";
			
			System.out.println("cmd: "+cmd);
			
			String hostname = CommonUtil.isNull(CommonUtil.getHostIp());

			// Host 정보 가져오는 서비스.	
			map.put("server_gubun"	, "S");
			
			CommonBean bean = commonDao.dGetHostInfo(map);
		
			String strHost 				= "";
			String strAccessGubun		= "";
			int iPort 					= 0;
			String strUserId 			= "";
			String strUserPw 			= "";
			
			if ( bean != null ) {
			
				strHost 			= CommonUtil.isNull(bean.getNode_id());
				strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
				iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
				strUserId 			= CommonUtil.isNull(bean.getAgent_id());
				strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			}
		
			//cmd = "echo " + cmd + "> a.txt";
	
			if(!"".equals(strHost)){			
					
					if( "S".equals(strAccessGubun) ){
						SshEncodeUtil su = new SshEncodeUtil(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
						System.out.println("Ssh2Util OK.");
						strReturnMsg = su.getOutput();
					}else{
						TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
						System.out.println("TelnetUtil OK.");
						strReturnMsg = tu.getOutput();
					}
				}

			System.out.println("strReturnMsg2  : "  + strReturnMsg);
			
			if ( strReturnMsg.equals("") ) {
				rMap.put("rCode", "-1");
			} else {
				rMap.put("rCode", "1");
				
				// 최종 수정 성공.
				if ( strReturnMsg.indexOf("has been saved successfully") > -1 ) {
					strReturnMsg = "처리 완료";
					
					// 실시간 작업 수정 성공 시 이력 저장					
					map.put("flag", "ajob");					
					commonDao.dPrcLog(map);
					
				// 최종 수정 실패.
				} else {
					strReturnMsg = "처리 실패 : " + strReturnMsg;
				}
			}
			
		}catch(Exception e){
			
			rMap.put("r_code", "-1");
			rMap.put("r_msg", e.getMessage());
			
			throw new DefaultServiceException(rMap);			
		}
		
		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		String rObject 	= CommonUtil.isNull(rMap.get("rObject"));
		
		if( !"1".equals(rCode)){
			rMap.put("r_code", "-1");
			throw new DefaultServiceException(rMap);
		}else{
			rMap.put("r_code", "1");
			rMap.put("r_msg", strReturnMsg);
		}
		
		return rMap;
	}
	
	
	
	public Map emPrcDefCalendar(Map map) throws Exception {
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strCalendar 			= CommonUtil.isNull(map.get("calendar"));
		String strYear	 			= CommonUtil.isNull(map.get("year"));
		String strDays	 			= CommonUtil.isNull(map.get("days"));
		String strDescription	 	= CommonUtil.isNull(map.get("description"));
		
		String strDbId	 			= CommonUtil.isNull(CommonUtil.getMessage("jdbc_em.username") );
		String strDbPw	 			= SeedUtil.decodeStr(CommonUtil.isNull(CommonUtil.getMessage("jdbc_em.password") ));
		String strGuiId	 			= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.ID") );
		String strGuiPw	 			= CommonUtil.isNull(CommonUtil.getMessage("EM.USER.PW") );
		
		strCalendar 	= "KANG_CAL3";
		strYear 		= "2014";
		strDays 		= "NNNYYNNNNNYYNNNNNYYNNNNNYY";
		strDescription 	= "그냥 테스트입니다.";
		
		String strReturnMsg 		= "";
		
		String[] aTmpT				= null;
		
		StringBuffer sb 			= new StringBuffer();
	
		try {
			
			sb.append("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>");
			sb.append("<\\!DOCTYPE DEFCAL SYSTEM \"defcal.dtd\">");
			sb.append("<DEFCAL>");
			sb.append("<CALENDAR DATACENTER=\""+strDataCenter+"\" NAME=\""+strCalendar+"\" TYPE=\"Regular\">");
			sb.append("<YEAR NAME=\""+strYear+"\" DAYS=\""+strDays+"\" DESCRIPTION=\""+strDescription+"\" >");
			sb.append("</YEAR>");
			sb.append("</CALENDAR>");
			sb.append("</DEFCAL>");
						
			String cmd 			= sb.toString();
			String defcal_cmd	= "defcal -u " + strDbId + " -p " + strDbPw + " -s " + strDataCenter + " -src def_cal.xml";
			String upload_cmd	= "em cli -U " + strGuiId + " -P " + strGuiPw + " -h " + strDataCenter + " -t 1000 -CAL_UPLOAD " + strDataCenter + " " + strCalendar + "";
			String hostname = CommonUtil.isNull(CommonUtil.getHostIp() );			
			
			// Host 정보 가져오는 서비스.			
			map.put("server_gubun"	, "S");
			
			CommonBean bean = commonDao.dGetHostInfo(map);
			
			String strHost 				= "";
			String strAccessGubun		= "";
			int iPort 					= 0;
			String strUserId 			= "";
			String strUserPw 			= "";
			
			if ( bean != null ) {
			
				strHost 			= CommonUtil.isNull(bean.getNode_id());
				strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
				iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
				strUserId 			= CommonUtil.isNull(bean.getAgent_id());
				strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			}			
			
			cmd = "echo '" + cmd + "' > def_cal.xml;";
			
			// Calendar 생성.
			cmd += cmd + defcal_cmd;
	
			if(!"".equals(strHost)){
				
				if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
					
					Process proc 					= null;
					InputStream inputStream 		= null;
					BufferedReader bufferedReader 	= null;
					String[] cmd2					= null;
					String osName 					= System.getProperty("os.name");
					
					if(osName.toLowerCase().startsWith("window")) {
						cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
					} else {
						cmd2 = new String[] { "/bin/sh", "-c", cmd };
					}
					
					proc = Runtime.getRuntime().exec(cmd2);			
					inputStream = proc.getInputStream();
					bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
					
					String line 		= "";
					
					while (( line = bufferedReader.readLine()) != null ) {
						strReturnMsg += line;
						//strReturnMsg += (line + "<br>");				
					}
					
					bufferedReader.close();
					inputStream.close();
					
				} else {
					
					if( "S".equals(strAccessGubun) ){
						Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
						System.out.println("Ssh2Util OK.");
						strReturnMsg = su.getOutput();
					}else{
						TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
						System.out.println("TelnetUtil OK.");
						strReturnMsg = tu.getOutput();
					}
				}
			}
			
			if ( strReturnMsg.indexOf("is valid") > -1 ) {
				
				rMap.put("rCode", "1");
				strReturnMsg = "캘린더 등록 완료";
				
				// 캘린더 등록이 완료 되면 캘린더 업로드.
				if(!"".equals(strHost)){
					
					if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
						
						Process proc 					= null;
						InputStream inputStream 		= null;
						BufferedReader bufferedReader 	= null;
						String[] cmd2					= null;
						String osName 					= System.getProperty("os.name");
						
						if(osName.toLowerCase().startsWith("window")) {
							cmd2 = new String[] { "cmd.exe", "/y", "/c", upload_cmd };
						} else {
							cmd2 = new String[] { "/bin/sh", "-c", upload_cmd };
						}
						
						proc = Runtime.getRuntime().exec(cmd2);			
						inputStream = proc.getInputStream();
						bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
						
						String line 		= "";
						
						while (( line = bufferedReader.readLine()) != null ) {
							strReturnMsg += line;
							//strReturnMsg += (line + "<br>");				
						}
						
						bufferedReader.close();
						inputStream.close();
						
					} else {
						
						if( "S".equals(strAccessGubun) ){
							Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
							System.out.println("Ssh2Util OK.");
							strReturnMsg = su.getOutput();
						}else{
							TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
							System.out.println("TelnetUtil OK.");
							strReturnMsg = tu.getOutput();
						}
					}
					
					if ( strReturnMsg.indexOf("Request was accomplished") > -1 ) {
						
						rMap.put("rCode", "1");
						strReturnMsg = "캘린더 업로드 완료";
					
					} else {
						
						rMap.put("rCode", "-1");
						strReturnMsg = "캘린더 업로드 실패";
					}
				}
				
			} else {
				
				System.out.println("strReturnMsg : " + strReturnMsg);
				
				if ( strReturnMsg.indexOf("Illeagal characters in year days") > -1 ) {
					strReturnMsg = "캘린더 등록 실패 : Illeagal characters in year days";
				} else {
					strReturnMsg = "캘린더 등록 실패";
				}
			}
			
		}catch(Exception e){
			
			rMap.put("r_code", "-1");
			rMap.put("r_msg", e.getMessage());
			
			throw new DefaultServiceException(rMap);			
		}
		
		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		String rObject 	= CommonUtil.isNull(rMap.get("rObject"));
		
		if( !"1".equals(rCode)){
			rMap.put("r_code", "-1");
			throw new DefaultServiceException(rMap);
		}else{
			rMap.put("r_code", "1");
			rMap.put("r_msg", strReturnMsg);
		}
		
		return rMap;
	}
	
	
	
	public Map dJobSchForecast(Map map) throws Exception {
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Doc01Bean doc01Bean			= new Doc01Bean();
		Doc03Bean doc03Bean			= new Doc03Bean();
		
		String gubun	 	= CommonUtil.isNull(map.get("gubun"));
		String data_center 	= CommonUtil.isNull(map.get("data_center"));
		String job_name 	= CommonUtil.isNull(map.get("job_name"));
		
		if ( gubun.equals("write") ) {
			
			doc01Bean.setTask_type("job");
			doc01Bean.setData_center(data_center);
			doc01Bean.setTable_name("SCHED_TEST");
			doc01Bean.setApplication("TESTAPP");
			doc01Bean.setGroup_name("TESTGRP");
			doc01Bean.setJob_name(job_name);
			doc01Bean.setMem_name("test");
			doc01Bean.setMem_lib("test");
			doc01Bean.setOwner("test");
			doc01Bean.setAuthor("test");
			
			// 스케줄 셋팅.

			String month_days = CommonUtil.isNull(map.get("month_days"));
			if(!month_days.equals("")){
				month_days = month_days.replace("&amp;lt;","<").replace("&lt;","<").replace("&amp;gt;",">").replace("&gt;",">");
			}
			
			String week_days = CommonUtil.isNull(map.get("week_days"));
			if(!week_days.equals("")){
				week_days = week_days.replace("&amp;lt;","<").replace("&lt;","<").replace("&amp;gt;",">").replace("&gt;",">");
			}
			
			doc01Bean.setDays_cal(CommonUtil.isNull(map.get("days_cal")));
			doc01Bean.setMonth_days(month_days);
			doc01Bean.setWeeks_cal(CommonUtil.isNull(map.get("weeks_cal")));
			doc01Bean.setWeek_days(week_days);
			doc01Bean.setSchedule_and_or(CommonUtil.isNull(map.get("schedule_and_or")));
			doc01Bean.setMonth_1(CommonUtil.isNull(map.get("month_1")));
			doc01Bean.setMonth_2(CommonUtil.isNull(map.get("month_2")));
			doc01Bean.setMonth_3(CommonUtil.isNull(map.get("month_3")));
			doc01Bean.setMonth_4(CommonUtil.isNull(map.get("month_4")));
			doc01Bean.setMonth_5(CommonUtil.isNull(map.get("month_5")));
			doc01Bean.setMonth_6(CommonUtil.isNull(map.get("month_6")));
			doc01Bean.setMonth_7(CommonUtil.isNull(map.get("month_7")));
			doc01Bean.setMonth_8(CommonUtil.isNull(map.get("month_8")));
			doc01Bean.setMonth_9(CommonUtil.isNull(map.get("month_9")));
			doc01Bean.setMonth_10(CommonUtil.isNull(map.get("month_10")));
			doc01Bean.setMonth_11(CommonUtil.isNull(map.get("month_11")));
			doc01Bean.setMonth_12(CommonUtil.isNull(map.get("month_12")));
			doc01Bean.setActive_from(CommonUtil.isNull(map.get("active_from")));
			doc01Bean.setActive_till(CommonUtil.isNull(map.get("active_till")));
			doc01Bean.setConf_cal(CommonUtil.isNull(map.get("conf_cal")));
			doc01Bean.setShift_num(CommonUtil.isNull(map.get("shift_num")));
			doc01Bean.setShift(CommonUtil.isNull(map.get("shift")));
			doc01Bean.setT_general_date(CommonUtil.isNull(map.get("t_general_date")));

			// 테이블 존재 여부
			map.put("table_name", CommonUtil.isNull(doc01Bean.getTable_name()));
			int table_cnt = CommonUtil.getDefTableCnt(map);
			
			if(table_cnt == 0){
				doc01Bean.setTable_cnt("0");
			}else{
				doc01Bean.setTable_cnt("1");
			}	
			
			map.put("doc01", doc01Bean);
			
			// 작업 신규 등록			
			rMap = emJobDefinitionDao.prcDefCreateJobs(map);

			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			if( !"1".equals(rCode)){
				rMap.put("r_code", "-1");
				throw new DefaultServiceException(rMap);
			}else{
				
				map.put("data_center", 	doc01Bean.getData_center());
				map.put("table_name", 	doc01Bean.getTable_name());
				map.put("job_name", 	doc01Bean.getJob_name());
				
				emJobUploadDao.defUploadJobs(map);
			}
			
		}else if ( gubun.equals("delete") ) {
			
			logger.debug("==================================================================forecast_delete_impl_start===========================================================");

			
			doc03Bean.setData_center(data_center);
			doc03Bean.setTable_name("SCHED_TEST");
			doc03Bean.setApplication("TESTAPP");
			doc03Bean.setGroup_name("TESTGRP");
			doc03Bean.setJob_name(job_name);
			
			map.put("doc03", doc03Bean);
			
			// 작업 삭제.
			rMap = emJobDeleteDao.deleteJobs(map);		
			
			String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
			if( !"1".equals(rCode)){
				rMap.put("r_code", "-1");
				throw new DefaultServiceException(rMap);
			}else{
				Doc01Bean docBean		= (Doc01Bean)map.get("doc01");
				
				map.put("data_center", 	data_center);
				doc01Bean.setTable_name("SCHED_TEST");
				map.put("job_name", 	job_name);
				
				emJobUploadDao.defUploadJobs(map);
			}
		}
		
		return rMap;
	}
	//엑셀일괄요청
	public Map dPrcDoc06(Map map) throws Exception {

		logger.info("#T WorksApprovalDocServiceImpl | dPrcDoc06 | Start~~~");
		
		//String table_name		= CommonUtil.isNull(map.get("table_name"));
		String file_path 		= CommonUtil.isNull(map.get("file_path"));		
		String file_nm 			= CommonUtil.isNull(map.get("file_nm"));
		String save_file_nm		= CommonUtil.isNull(map.get("save_file_nm"));
		String data_center		= CommonUtil.isNull(map.get("data_center"));
		String org_data_center	= CommonUtil.isNull(map.get("data_center"));
		String data_center_name	= CommonUtil.isNull(map.get("data_center_name"));
		String strFlag			= CommonUtil.isNull(map.get("flag"));
		String act_gb			= CommonUtil.isNull(map.get("act_gb"));
		String excel_data 		= CommonUtil.isNull(map.get("excel_data"));
		//반영일 추가
		String apply_date 		= CommonUtil.isNull(map.get("p_apply_date"));
		map.put("apply_date", apply_date);

		if ( data_center_name.indexOf("-") > -1 ) {
			data_center_name = data_center_name.split("-")[1];
		}

		// 결재통보 발송 체크로직
		String bJobApprovalChk 		= "N";
		String strPostApprovalYn 	= "";

		if(strFlag.equals("post_draft")) {
			bJobApprovalChk = "Y";
			strPostApprovalYn = "Y";
			map.put("post_approval_yn", strPostApprovalYn);
		}else if(strFlag.equals("draft")) {
			bJobApprovalChk = "Y";
			strPostApprovalYn = "N";
			map.put("post_approval_yn", strPostApprovalYn);
		}

		Map rMap 		= null;
		Map rMapDetail	= null;
		
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		
		// 잡 등록.
		rMap = worksApprovalDocDao.dPrcDoc06(map);
		
		String r_code 	= CommonUtil.isNull(rMap.get("r_code"));
		String r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"));

		rMap.put("doc_cd", r_doc_cd);
		rMap.put("sendApprovalNoti", bJobApprovalChk);
		
		if ( r_code.equals("1") ) {
			
			ArrayList<String[]> al = new ArrayList<>();
			String[] split_excel_data = excel_data.split("★");
			String[] arr_excel_data = null;
			
			int row_cnt = 0;
			int col_cnt = 0;
			
			//총 컬럼 갯수를 구한다.
			for(int i=0;i<split_excel_data.length;i++){
				String data = CommonUtil.isNull(split_excel_data[i]);
				
				if(!data.equals("☆END☆")){
					++col_cnt;
				}else{
					break;
				}
			}
			
			logger.info("#T WorksApprovalDocServiceImpl | dPrcDoc06 | 전체 :::"+col_cnt);
			
			int col = 0;
			arr_excel_data = new String[col_cnt];
			for(int j=0;j<split_excel_data.length;j++){
				
				String data = CommonUtil.isNull(split_excel_data[j]);
				
				if(!data.equals("☆END☆")){
					arr_excel_data[col] = data;
					++col;
				}else{
					al.add(arr_excel_data);				//배열에 있는 데이터를 ArrayList에 담는다
					
					arr_excel_data = new String[col_cnt];
					col = 0;
				}
			}
			
			ArrayList alDoc01 = new ArrayList();
			
			
			int idx_row = 0;
			
			if(strFlag.equals("temp_ins") || strFlag.equals("v_temp_ins")){
				
				if( "D".equals(act_gb)){
					
					for(int i=0; null!=al&&i<al.size(); i++){
						
						idx_row = i;
					
						Map<String, Object> rMap2 	= new HashMap<String, Object>();
						
						rMap2.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
						
						String[] items = al.get(i);
						
						if( null!=items && 0<items.length ) {
							
							if( "".equals(CommonUtil.isNull(items[0])) ) break;
							
							rMap2.put("table_name", 		CommonUtil.isNull(items[1]));
							rMap2.put("application", 		CommonUtil.isNull(items[2]));
							rMap2.put("group_name", 		CommonUtil.isNull(items[3]));
							rMap2.put("job_name", 			CommonUtil.isNull(items[7]));
							rMap2.put("description", 		CommonUtil.replaceStrHtml(CommonUtil.isNull(items[8])));
							// author 은 의뢰자 아이디를 넣어준다. (2023.08.08 강명준)
							rMap2.put("author",	 			map.get("s_user_id"));

							rMap2.put("data_center", 		data_center);
						}
						
						String strTable_name				= CommonUtil.isNull(items[1]);
						String strApplication				= CommonUtil.isNull(items[2]);
						String strGroupName 				= CommonUtil.isNull(items[3]);
						
						String strParentTable_name 			= strTable_name;
						String strSubTable_name 			= "";
								
						// 해당폴더가 서브폴더인지 확인하는 로직
						if( strParentTable_name.indexOf("/") > -1 ) {
							strParentTable_name 	= strTable_name.substring(0, strTable_name.lastIndexOf('/'));
							strSubTable_name 		= strTable_name.substring(strTable_name.lastIndexOf('/')+1, strTable_name.length());
						}
						
						if( strTable_name.equals("") ){
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", (idx_row+1)+"번째 열 폴더는 필수 입니다.");
							
							throw new DefaultServiceException(rMap3);
							
						} else {
							
							Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
							appGrpCodeMap.put("SCHEMA", 	rMap2.get("SCHEMA"));
							appGrpCodeMap.put("grp_nm", 	strTable_name);
							appGrpCodeMap.put("grp_depth", 	"1");
							appGrpCodeMap.put("data_center", CommonUtil.isNull(map.get("data_center")));
							
							List<AppGrpBean> appGrpCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appGrpCodeMap);
							
							if( appGrpCodeList.size() == 0 ) {
								
								int rtn = 0;
								
								// 해당폴더가 서브폴더인지 확인하는 로직
								if( strTable_name.indexOf("/") > -1 ) {
									Map<String, Object> subTableChkMap = new HashMap<String, Object>();
									
									subTableChkMap.put("SCHEMA",			rMap2.get("SCHEMA"));
									subTableChkMap.put("parent_table_nm",	strParentTable_name);
									subTableChkMap.put("sub_table_nm",		strSubTable_name);
									subTableChkMap.put("data_center",		CommonUtil.isNull(map.get("data_center")));
									
									CommonBean bean = commonDao.dGetSubTableChk(subTableChkMap);
									rtn = bean.getTotal_count();
								}
							
								if(rtn == 0) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "입력한 데이터를 다시 확인해주세요. \\n\\n * " + (idx_row+1)+"번째 열의 폴더 : " + strTable_name);
									
									throw new DefaultServiceException(rMap3);
								}
							}
						}
						
						if( strApplication.equals("") ){
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", (idx_row+1)+"번째 열 어플리케이션은 필수 입니다.");
							
							throw new DefaultServiceException(rMap3);
							
						} else {
							
							Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
							appGrpCodeMap.put("SCHEMA", 	rMap2.get("SCHEMA"));
							appGrpCodeMap.put("tb_nm", 		strParentTable_name);
							appGrpCodeMap.put("grp_nm", 	strApplication);
							appGrpCodeMap.put("grp_depth", 	"2");
							appGrpCodeMap.put("data_center", CommonUtil.isNull(map.get("data_center")));
							
							List<AppGrpBean> appGrpCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appGrpCodeMap);
							if( appGrpCodeList.size() == 0 ){
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "입력한 데이터를 다시 확인해주세요. \\n\\n * " + (idx_row+1)+"번째 열의 어플리케이션 : " + strApplication);
								
								throw new DefaultServiceException(rMap3);									
							}
						}
						
						if( strGroupName.equals("") ){
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", (idx_row+1)+"번째 열 그룹은 필수 입니다.");
							
							throw new DefaultServiceException(rMap3);
							
						} else {
							
							Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
							appGrpCodeMap.put("SCHEMA", 	rMap2.get("SCHEMA"));
							appGrpCodeMap.put("tb_nm", 		strParentTable_name);
							appGrpCodeMap.put("ap_nm", 		strApplication);
							appGrpCodeMap.put("grp_nm", 	strGroupName);
							appGrpCodeMap.put("grp_depth", 	"3");
							appGrpCodeMap.put("data_center", CommonUtil.isNull(map.get("data_center")));
							
							List<AppGrpBean> appGrpCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appGrpCodeMap);
							if( appGrpCodeList.size() == 0 ){
								/*Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "입력한 데이터를 다시 확인해주세요. \\n\\n * " + (idx_row+1)+"번째 열의 그룹 : " + strGroupName);
								
								throw new DefaultServiceException(rMap3);		*/

								//어플리케이션 grp_cd 가져오기
								Map<String, Object> appCodeMap = new HashMap<String, Object>();
								appCodeMap.put("SCHEMA", 		map.get("SCHEMA"));
								appCodeMap.put("grp_eng_nm", 	strApplication);
								appCodeMap.put("grp_depth", 	"2");
								appCodeMap.put("data_center", 	CommonUtil.isNull(map.get("data_center")));

								List<AppGrpBean> appCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appCodeMap);

								int app_grp_cd = Integer.parseInt(appCodeList.get(0).getGrp_cd());
								int grp_cd = commonDao.dGetAppGrpCd(map);

								Map<String, Object> GrpInsMap = new HashMap<String, Object>();

								//시스템관리에 그룹 추가하는 구간 추가   GRP_PARENT_CD
								GrpInsMap.put("SCHEMA", 			map.get("SCHEMA"));
								GrpInsMap.put("flag", 				"ins");
								GrpInsMap.put("grp_cd", 			Integer.toString(grp_cd));
								GrpInsMap.put("grp_parent_cd", 		app_grp_cd);
								GrpInsMap.put("grp_use_yn", 		"Y");
								GrpInsMap.put("grp_depth", 			"3");
								GrpInsMap.put("grp_eng_nm", 		strGroupName);
								GrpInsMap.put("grp_ins_user_cd", 	map.get("s_user_cd"));
								GrpInsMap.put("scode_cd", 			CommonUtil.isNull(map.get("data_center")).split(",")[0]);

								commonDao.dPrcAppGrpInsert(GrpInsMap);
							}
						}
						
						String s_user_gb 	= CommonUtil.isNull(map.get("s_user_gb"));
						String s_dept_cd 	= CommonUtil.isNull(map.get("s_dept_cd"));
						String strJobName 	= CommonUtil.isNull(CommonUtil.isNull(items[7]));
						
						rMap2.put("act_gb", 		"D");
						rMap2.put("data_center", 	org_data_center);
						rMap2.put("table_name", 	strParentTable_name);
						CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(rMap2);
						CommonBean bean9 = worksApprovalDocDao.dGetChkDoc06JobCnt(rMap2);
						
						if( bean.getTotal_count() == 0 ){
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "해당 테이블에 삭제할 작업명이 없습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " + strJobName);
							throw new DefaultServiceException(rMap3);
						}
						
						if( bean9.getTotal_count() > 0 ){							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "저장/미결/반영대기 상태의 엑셀일괄요청서가 있습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " +strJobName);
							throw new DefaultServiceException(rMap3);
						}
						
						CommonBean doc03_bean = worksApprovalDocDao.dGetChkDoc03Cnt(rMap2);
						CommonBean doc04_bean = worksApprovalDocDao.dGetChkDoc04Cnt(rMap2);
						
						if( doc03_bean.getTotal_count() > 0 || doc04_bean.getTotal_count() > 0 ){							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "저장/미결/반영대기 상태의 요청서가 있습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " +strJobName);
							throw new DefaultServiceException(rMap3);
						}
						
						rMap2.put("doc_cd", 		r_doc_cd);
						rMap2.put("table_name", 	strTable_name);
						rMap2.put("data_center", 	data_center);
						rMap2.put("flag", 			"detail_ins");
						rMap2.put("s_dept_cd",		s_dept_cd);
//						rMap2.put("user_id", 		rMap.get("author"));
						
						//  잡 이름으로 담당자그룹과 삭제하는 잡의 그룹이 맞는지 체크.
						CommonBean bean2 = worksApprovalDocDao.dGetChkDeptCnt(rMap2);
						
						if ( bean2 == null ) {
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "해당 작업에 대한 삭제 권한이 없습니다.(담당자를 확인해 주세요.) \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " + strJobName);
							throw new DefaultServiceException(rMap3);
						}
						
						String strBean2Team = CommonUtil.isNull(bean2.getTeam());
						
						if( !s_dept_cd.equals(strBean2Team) && !s_user_gb.equals("99") ){
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "해당 작업에 대한 삭제 권한이 없습니다.(담당자의 업무 부서가 다릅니다.) \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " + strJobName);
							throw new DefaultServiceException(rMap3);							
						}
						
						rMapDetail = worksApprovalDocDao.dPrcDoc06(rMap2);
						
						// 엑셀 파일 삭제.
						FileUtil fu = new FileUtil();
						fu.delDir(new File(file_path + save_file_nm));
						
						String strDetailRCode = CommonUtil.isNull(rMapDetail.get("r_code"));
						
						if( !"1".equals(strDetailRCode) ) {
							throw new DefaultServiceException(rMapDetail);
						}
						
						idx_row++;
					}
	
				}else{
					
					String dupchkinExcel 	= "";
					String rerun_interval 	= "";
					
					String strSms1 			= "";
					String strMail1 		= "";					
					String strSms2 			= "";
					String strMail2 		= "";					
					String strSms3 			= "";
					String strMail3 		= "";					
					String strSms4 			= "";
					String strMail4 		= "";
					String strSms5 			= "";
					String strMail5 		= "";
					String strSms6 			= "";
					String strMail6 		= "";
					String strSms7 			= "";
					String strMail7 		= "";
					String strSms8 			= "";
					String strMail8 		= "";
					String strSms9 			= "";
					String strMail9 		= "";
					String strSms10 		= "";
					String strMail10 		= "";
					String strGrpSms1		= "";
					String strGrpMail1 		= "";
					String strGrpSms2 		= "";
					String strGrpMail2 		= "";

					for(int i=0; null!=al&&i<al.size(); i++){
						
						String strActiveFrom 	= "";
						String strActiveTill 	= "";
						String strActiveDay 	= "";
						
						idx_row = i;
						
						Map<String, Object> rMap2 	= new HashMap<String, Object>();
						
						rMap2.put("data_center", 	data_center);
						rMap2.put("SCHEMA", 		CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
						//rMap2.put("table_name", 	table_name);
						
						String[] items = new String[100];
						items = al.get(i);
						System.out.println("items.length : " + items.length);
						if(items.length != 92){
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							
							String strFormMsg	= "";
							
							String strAddField  = "";
							strAddField			= "처음 필드 : 작업타입\\n";
							strAddField			+= "마지막 필드 : ON/DO\\n";
							
							rMap3.put("r_msg", "엑셀양식이 다릅니다. \\n조회 > 배치등록정보에서 다시 내려 받아주세요.)\\n\\n" + strAddField);
							
							throw new DefaultServiceException(rMap3);
						}
						if( null!=items && 0<items.length ) {
							int n = 0;
							rMap2.put("task_type", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("table_name", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("application", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("group_name", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("node_id", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("owner", 						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("max_wait", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("job_name", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("description", 				CommonUtil.replaceStrHtml(CommonUtil.isNull(CommonUtil.K2E(items[n++]),"")));
							rMap2.put("mem_lib", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							
							rMap2.put("mem_name", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("command", 					CommonUtil.replaceStrHtml(CommonUtil.isNull(CommonUtil.K2E(items[n++]),"")));
							rMap2.put("time_from", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("time_until", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));	
							rMap2.put("late_sub", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("late_time", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("late_exec", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));

							rMap2.put("cyclic", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("cyclic_type", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rerun_interval = CommonUtil.isNull(CommonUtil.K2E(items[n++]));
							rMap2.put("rerun_interval", 			rerun_interval);

							rMap2.put("interval_sequence", 			CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("specific_times", 			CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("ind_cyclic",					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("tolerance",					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("rerun_max", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							//rMap2.put("count_cyclic_from",		 	CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("confirm_flag", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("priority", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("success_sms_yn", 			CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("critical", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_days", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("days_cal", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							
							rMap2.put("conf_cal", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("shift", 						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("shift_num", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							
							strActiveDay	= CommonUtil.isNull(CommonUtil.K2E(items[n++]),"");

							if(!strActiveDay.equals("")) {
								strActiveFrom = strActiveDay.split("~")[0];
								strActiveTill = strActiveDay.split("~")[1];
							}
							rMap2.put("active_from", 				strActiveFrom);
							rMap2.put("active_till", 				strActiveTill);
							
							rMap2.put("month_1", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_2", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_3", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_4", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_5", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_6", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_7", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_8", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_9", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_10", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_11", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("month_12", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));		

							rMap2.put("schedule_and_or", 			CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("week_days", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));		
							rMap2.put("weeks_cal", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("t_general_date",		 		CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));	
							rMap2.put("t_conditions_in",		 	CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));							
							rMap2.put("t_conditions_out",		 	CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));	

							rMap2.put("author", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_1",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_1",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_2", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_2",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_2",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_3", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_3",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_3",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_4", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_4",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_4",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_5", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_5",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_5",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_6", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_6",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_6",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_7", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_7",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_7",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_8", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_8",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_8",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_9", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_9",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_9",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("user_cd_10", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("sms_10",						CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("mail_10",					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("grp_nm_1", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("grp_sms_1",					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("grp_mail_1",					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("grp_nm_2", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("grp_sms_2",					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("grp_mail_2",					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));

							//rMap2.put("error_description",			CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("t_resources_q", 				CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("t_set", 						CommonUtil.replaceStrHtml(CommonUtil.isNull(CommonUtil.K2E(items[n++]),"")));
							rMap2.put("t_steps", 					CommonUtil.isNull(CommonUtil.K2E(items[n++]),""));
							rMap2.put("t_resources_c", 				"");
						 
							String strJobName 						= CommonUtil.isNull(rMap2.get("job_name"));
							String strDescription					= CommonUtil.isNull(rMap2.get("description"));
							String strMemLib						= CommonUtil.isNull(rMap2.get("mem_lib"));
							String strMemName						= CommonUtil.isNull(rMap2.get("mem_name"));
							String in_cond 							= CommonUtil.isNull(rMap2.get("t_conditions_in"));
							String out_cond 						= CommonUtil.isNull(rMap2.get("t_conditions_out"));
							String chk_confirm_flag  				= CommonUtil.isNull(rMap2.get("confirm_flag"));
							String chk_cyclic  						= CommonUtil.isNull(rMap2.get("cyclic"));
							String strCyclicType  					= CommonUtil.isNull(rMap2.get("cyclic_type"));
							String strIntervalSequence				= CommonUtil.isNull(rMap2.get("interval_sequence"));
							String strSpecificTimes					= CommonUtil.isNull(rMap2.get("specific_times"));
							String strCountCyclicFrom				= CommonUtil.isNull(rMap2.get("count_cyclic_from"));
							String strCommand 						= CommonUtil.isNull(rMap2.get("command"));
							String chk_critical  					= CommonUtil.isNull(rMap2.get("critical"));
							String strTaskType 						= CommonUtil.isNull(rMap2.get("task_type"));
							String strNodeId 						= CommonUtil.isNull(rMap2.get("node_id"));
							String strSystemGb 						= CommonUtil.isNull(rMap2.get("systemGb"));
							String strJobTypeGb 					= CommonUtil.isNull(rMap2.get("jobTypeGb"));
							String strJobSchedGb					= CommonUtil.isNull(rMap2.get("jobSchedGb"));
							
							String table_name						= CommonUtil.isNull(rMap2.get("table_name"));
							String strApplication					= CommonUtil.isNull(rMap2.get("application"));
							String strGroupName 					= CommonUtil.isNull(rMap2.get("group_name"));
							String strArgument 						= CommonUtil.isNull(rMap2.get("argument"));
							String strAuthor						= CommonUtil.isNull(rMap2.get("author"));
							String strOwner 						= CommonUtil.isNull(rMap2.get("owner"));
							String strMaxWait						= CommonUtil.isNull(rMap2.get("max_wait"));
							String strTimeFrom 						= CommonUtil.isNull(rMap2.get("time_from"));
							String strTimeUntill 					= CommonUtil.isNull(rMap2.get("time_until"));
							String strPriority 						= CommonUtil.isNull(rMap2.get("priority"));
							String strGeneralDate					= CommonUtil.isNull(rMap2.get("t_general_date"));
							
							strSms1 								= CommonUtil.isNull(rMap2.get("sms_1"));
							strMail1 								= CommonUtil.isNull(rMap2.get("mail_1"));
							strSms2 								= CommonUtil.isNull(rMap2.get("sms_2"));
							strMail2 								= CommonUtil.isNull(rMap2.get("mail_2"));
							strSms3 								= CommonUtil.isNull(rMap2.get("sms_3"));
							strMail3 								= CommonUtil.isNull(rMap2.get("mail_3"));
							strSms4 								= CommonUtil.isNull(rMap2.get("sms_4"));
							strMail4 								= CommonUtil.isNull(rMap2.get("mail_4"));
							strSms5 								= CommonUtil.isNull(rMap2.get("sms_5"));
							strMail5 								= CommonUtil.isNull(rMap2.get("mail_5"));
							strSms6 								= CommonUtil.isNull(rMap2.get("sms_6"));
							strMail6 								= CommonUtil.isNull(rMap2.get("mail_6"));
							strSms7 								= CommonUtil.isNull(rMap2.get("sms_7"));
							strMail7 								= CommonUtil.isNull(rMap2.get("mail_7"));
							strSms8									= CommonUtil.isNull(rMap2.get("sms_8"));
							strMail8 								= CommonUtil.isNull(rMap2.get("mail_8"));
							strSms9									= CommonUtil.isNull(rMap2.get("sms_9"));
							strMail9 								= CommonUtil.isNull(rMap2.get("mail_9"));
							strSms10								= CommonUtil.isNull(rMap2.get("sms_10"));
							strMail10 								= CommonUtil.isNull(rMap2.get("mail_10"));
							strGrpSms1								= CommonUtil.isNull(rMap2.get("grp_sms_1"));
							strGrpMail1								= CommonUtil.isNull(rMap2.get("grp_mail_1"));
							strGrpSms2								= CommonUtil.isNull(rMap2.get("grp_sms_2"));
							strGrpMail2 							= CommonUtil.isNull(rMap2.get("grp_mail_2"));

							//String strErrorDescription				= CommonUtil.isNull(rMap2.get("error_description"));
							String strIndCyclic 					= CommonUtil.isNull(rMap2.get("ind_cyclic"));
							String strTolerance						= CommonUtil.isNull(rMap2.get("tolerance"));
							
							String strMonth1    					= CommonUtil.isNull(rMap2.get("month_1"));                
							String strMonth2    					= CommonUtil.isNull(rMap2.get("month_2"));                
							String strMonth3    					= CommonUtil.isNull(rMap2.get("month_3"));                
							String strMonth4    					= CommonUtil.isNull(rMap2.get("month_4"));                
							String strMonth5    					= CommonUtil.isNull(rMap2.get("month_5"));                
							String strMonth6    					= CommonUtil.isNull(rMap2.get("month_6"));                
							String strMonth7    					= CommonUtil.isNull(rMap2.get("month_7"));                
							String strMonth8    					= CommonUtil.isNull(rMap2.get("month_8"));                
							String strMonth9    					= CommonUtil.isNull(rMap2.get("month_9"));                
							String strMonth10   					= CommonUtil.isNull(rMap2.get("month_10"));                
							String strMonth11   					= CommonUtil.isNull(rMap2.get("month_11"));                
							String strMonth12   					= CommonUtil.isNull(rMap2.get("month_12"));     
							String strScheduleAndOr					= CommonUtil.isNull(rMap2.get("schedule_and_or"));
							
							String strDaysCal 						= CommonUtil.isNull(rMap2.get("days_cal")); 
							String strMonthDays 					= CommonUtil.isNull(rMap2.get("month_days")); 
							String strWeeksCal 						= CommonUtil.isNull(rMap2.get("weeks_cal")); 
							String strWeekDays 						= CommonUtil.isNull(rMap2.get("week_days"));
							
							String strConfCal 						= CommonUtil.isNull(rMap2.get("conf_cal"));
							String strShift 						= CommonUtil.isNull(rMap2.get("shift"));
							String strShiftNum 						= CommonUtil.isNull(rMap2.get("shift_num"));
							
							String strParentTable_name 			= table_name;
							String strSubTable_name 			= "";
							
							// conf_cal
							List calList_conf_cal = new ArrayList();
							if(!strConfCal.equals("")) {
								rMap.put("cal_text", strConfCal);
								
								calList_conf_cal = commonDao.dGetCalCodeList3(rMap);
								if(calList_conf_cal.size() == 0) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", (idx_row+1)+"번째 행 \\nCONF_CAL - 등록된 캘린더가 아닙니다.");
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							// shift
							if (!"".equals(strShift)) {
								String[] shiftArr = CommonUtil.getMessage("JOB.CONF_CAL").split(",");
								boolean validate = false;
								for (String shift : shiftArr) {
									if (strShift.equals(shift)) validate = true;
								}
								if (!validate) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", (idx_row+1)+"번째 행 \\nSHIFT는 "+Arrays.toString(shiftArr)+"만 사용 가능합니다.");
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							// shift_num
							if (!"".equals(strShiftNum)) {
								Integer intShiftNum = null;
								try {
									intShiftNum = Integer.parseInt(strShiftNum);
								} catch (NumberFormatException e) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", (idx_row+1)+"번째 행 \\nSHIFT_NUM은 숫자만 입력 가능합니다.");
									
									throw new DefaultServiceException(rMap3);
								}

								if ( intShiftNum != null && (intShiftNum < -10 || intShiftNum > 10)) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", (idx_row+1)+"번째 행 \\nSHIFT_NUM은 -10에서 10 사이의 숫자만 입력 가능합니다.");
									
									throw new DefaultServiceException(rMap3);
								}
							}
									
							// 해당폴더가 서브폴더인지 확인하는 로직
							if( strParentTable_name.indexOf("/") > -1 ) {
								strParentTable_name 	= table_name.substring(0, table_name.lastIndexOf('/'));
								strSubTable_name 		= table_name.substring(table_name.lastIndexOf('/')+1, table_name.length());
							}
							
							//폴더/어플리케이션/그룹
							if( table_name.equals("") ){
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 폴더는 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
								
							} else {
								
								Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
								appGrpCodeMap.put("SCHEMA", 	rMap2.get("SCHEMA"));
								appGrpCodeMap.put("grp_nm", 	table_name);
								appGrpCodeMap.put("grp_depth", 	"1");
								appGrpCodeMap.put("data_center", CommonUtil.isNull(map.get("data_center")));
								
								List<AppGrpBean> appGrpCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appGrpCodeMap);
								
								if( appGrpCodeList.size() == 0 ) {
									
									int rtn = 0;
									
									// 해당폴더가 서브폴더인지 확인하는 로직
									if( table_name.indexOf("/") > -1 ) {
										Map<String, Object> subTableChkMap = new HashMap<String, Object>();
										
										subTableChkMap.put("SCHEMA",			rMap2.get("SCHEMA"));
										subTableChkMap.put("parent_table_nm",	strParentTable_name);
										subTableChkMap.put("sub_table_nm",		strSubTable_name);
										subTableChkMap.put("data_center",		CommonUtil.isNull(map.get("data_center")));
										
										CommonBean bean = commonDao.dGetSubTableChk(subTableChkMap);
										rtn = bean.getTotal_count();
									}
								
									if(rtn == 0) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "입력한 데이터를 다시 확인해주세요. \\n\\n * " + (idx_row+1)+"번째 열의 폴더 : " + table_name);
										
										throw new DefaultServiceException(rMap3);
									}
								}
							}
							
							if( strApplication.equals("") ){
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 어플리케이션은 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
								
							} else {
								
								Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
								appGrpCodeMap.put("SCHEMA", 		rMap2.get("SCHEMA"));
								appGrpCodeMap.put("tb_nm", 			strParentTable_name);
								appGrpCodeMap.put("grp_nm", 		strApplication);
								appGrpCodeMap.put("grp_depth", 		"2");
								appGrpCodeMap.put("data_center", 	CommonUtil.isNull(map.get("data_center")));
								
								List<AppGrpBean> appGrpCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appGrpCodeMap);
								if( appGrpCodeList.size() == 0 ){
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "입력한 데이터를 다시 확인해주세요. \\n\\n * " + (idx_row+1)+"번째 열의 어플리케이션 : " + strApplication);
									
									throw new DefaultServiceException(rMap3);									
								}
							}
							
							if( strGroupName.equals("") ){
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 그룹은 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
								
							} else {

								Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
								appGrpCodeMap.put("SCHEMA", 		rMap2.get("SCHEMA"));
								appGrpCodeMap.put("tb_nm", 			strParentTable_name);
								appGrpCodeMap.put("ap_nm", 			strApplication);
								appGrpCodeMap.put("grp_nm", 		strGroupName);
								appGrpCodeMap.put("grp_depth", 		"3");
								appGrpCodeMap.put("data_center", 	CommonUtil.isNull(map.get("data_center")));
								
								List<AppGrpBean> appGrpCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appGrpCodeMap);
								if( appGrpCodeList.size() == 0 ){
									//어플리케이션 grp_cd 가져오기
									Map<String, Object> appCodeMap = new HashMap<String, Object>();
									appCodeMap.put("SCHEMA", 		map.get("SCHEMA"));
									appCodeMap.put("grp_eng_nm", 	strApplication);
									appCodeMap.put("grp_depth", 	"2");
									appCodeMap.put("data_center", 	CommonUtil.isNull(map.get("data_center")));

									List<AppGrpBean> appCodeList = worksApprovalDocDao.dGetAppGrpCodeList(appCodeMap);

									int app_grp_cd = Integer.parseInt(appCodeList.get(0).getGrp_cd());
									int grp_cd = commonDao.dGetAppGrpCd(map);

									Map<String, Object> GrpInsMap = new HashMap<String, Object>();

									//시스템관리에 그룹 추가하는 구간 추가   GRP_PARENT_CD
									GrpInsMap.put("SCHEMA", 			map.get("SCHEMA"));
									GrpInsMap.put("flag", 				"ins");
									GrpInsMap.put("grp_cd", 			Integer.toString(grp_cd));
									GrpInsMap.put("grp_parent_cd", 		app_grp_cd);
									GrpInsMap.put("grp_use_yn", 		"Y");
									GrpInsMap.put("grp_depth", 			"3");
									GrpInsMap.put("grp_eng_nm", 		strGroupName);
									GrpInsMap.put("grp_ins_user_cd", 	map.get("s_user_cd"));
									GrpInsMap.put("scode_cd", 			CommonUtil.isNull(map.get("data_center")).split(",")[0]);

									commonDao.dPrcAppGrpInsert(GrpInsMap);
								}
							}
							
							//작업명
							if( strJobName.equals("") ){
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n작업명은 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
							}
							Pattern pattern = Pattern.compile("[ㄱ-ㅎ|ㅏ-ㅣ|가-힣\\$\\\\/*?]");
							Matcher matcher = pattern.matcher(strJobName);
							if(matcher.find()) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 작업명에는 한글 및 특수 문자( \\\\ , $ , / , * , ? )를 입력 할 수 없습니다.");

								throw new DefaultServiceException(rMap3);
							}

							//엑셀등록 시 체크로직
							if( act_gb.equals("C") && !strFlag.equals("v_temp_ins")){
								
								rMap2.put("act_gb", 		"C");
								rMap2.put("data_center", 	org_data_center);
								CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(rMap2);
								CommonBean bean9 = worksApprovalDocDao.dGetChkDoc06JobCnt(rMap2);
								
								if( bean.getTotal_count()>0){
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "중복된 작업명이 있습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : "  + strJobName );
									throw new DefaultServiceException(rMap3);
								}
								
								if(i > 0 && !dupchkinExcel.equals("")){
									
									String [] arrDupchkinExcel = dupchkinExcel.split("[|]");
									
									for (int d=0;d<arrDupchkinExcel.length; d++){
										if( arrDupchkinExcel[d].equals(strJobName) ){
											
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "엑셀파일 안에 중복된 작업명이 있습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : "  + strJobName );
											throw new DefaultServiceException(rMap3);
										}
									}
								}
								
								if(dupchkinExcel.equals("")){
									dupchkinExcel = "";
								}else{
									dupchkinExcel += "|";
								}
								dupchkinExcel +=  strJobName;
								
								if( bean9.getTotal_count()>0 ){
									
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "저장/미결/반영대기 상태의 작업이 있습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " +strJobName );
									throw new DefaultServiceException(rMap3);
								}								
							}
							
							//엑셀수정 시 체크로직
							if( act_gb.equals("U") ){
										
								rMap2.put("act_gb", 		"U");
								rMap2.put("data_center", 	org_data_center);
								CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(rMap2);
								CommonBean bean9 = worksApprovalDocDao.dGetChkDoc06JobCnt(rMap2);
								
								if( bean.getTotal_count() == 0 ){
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "수정할 작업명이 없습니다.\\n\\n * " + (idx_row+1)+"번째 열의 작업명 : "  + strJobName );
									throw new DefaultServiceException(rMap3);
								}
								
								if(i > 0 && !dupchkinExcel.equals("")){
									
									String [] arrDupchkinExcel = dupchkinExcel.split("[|]");
									
									for (int d=0;d<arrDupchkinExcel.length; d++){
										if( arrDupchkinExcel[d].equals(strJobName) ){
											
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "엑셀파일 안에 중복된 작업명이 있습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : "  + strJobName );
											throw new DefaultServiceException(rMap3);
										}
									}
								}
								
								if(dupchkinExcel.equals("")){
									dupchkinExcel = "";
								}else{
									dupchkinExcel += "|";
								}
								dupchkinExcel +=  strJobName;
								
								if( bean9.getTotal_count()>0 ){
									
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "저장/미결/반영대기 상태의 엑셀일괄요청서가 있습니다.\\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " +strJobName );
									throw new DefaultServiceException(rMap3);
								}
								
								CommonBean doc03_bean = worksApprovalDocDao.dGetChkDoc03Cnt(rMap2);
								CommonBean doc04_bean = worksApprovalDocDao.dGetChkDoc04Cnt(rMap2);
								
								if( doc03_bean.getTotal_count() > 0 || doc04_bean.getTotal_count() > 0 ){							
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "저장/미결/반영대기 상태의 요청서가 있습니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업명 : " +strJobName);
									throw new DefaultServiceException(rMap3);
								}
							}
							
							//작업설명 
							if( act_gb.equals("C") || act_gb.equals("U") ) {
								
								if( strDescription.equals("") ){
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", (idx_row+1)+"번째 열 작업설명은 필수 입니다.");
									
									throw new DefaultServiceException(rMap3);
									
								}
							}
							
							String if_name 			= "";
							String if_return 		= "";
							String if_return_msg 	= "";
							
							String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
				
							if( strAuthor.equals("") ){
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 담당자(사번)는 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);								
							}
							
							//최대대기일
							if(strMaxWait.equals("")) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 최대대기일은 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);		
							}
							if(!strMaxWait.equals("")) {
								if(!CommonUtil.NumberChk(strMaxWait)) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "최대대기일은 숫자입니다. \\n\\n * " + (idx_row+1) + "번째 열의 최대대기일 : " + strMaxWait);
									throw new DefaultServiceException(rMap3);		
								}else {
									if(Double.parseDouble(strMaxWait) > 99) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "최대대기일은 최대 99일입니다. \\n\\n * " + (idx_row+1) + "번째 열의 최대대기일 : " + strMaxWait);
										throw new DefaultServiceException(rMap3);	
									}
								}
							}
							
							//작업 타입
							if( strTaskType.equals("") ){
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 작업 타입은 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
								
							}else{
								
								if( strTaskType.equals("script") || strTaskType.equals("command") ||strTaskType.equals("dummy") ){
								}else{
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "작업 타입은 command/script/dummy 입니다. \\n\\n * " + (idx_row+1)+"번째 열의 작업 타입 : " + strTaskType);
									
									throw new DefaultServiceException(rMap3);
								}
								
								//작업유형이 job일 경우 프로그램명,프로그램위치 필수 그 외는 불가
								if( strTaskType.equals("script")) {
									System.out.println("strMemLib : " + strMemLib);
									System.out.println("strMemName : " + strMemName);
									
									if( strMemLib.equals("") || strMemName.equals("")) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "작업 타입이 script일 경우 " + (idx_row+1) + "번째 열의 프로그램명과 프로그램위치는 필수입니다.");
										
										throw new DefaultServiceException(rMap3);
									}
								}
								if( strTaskType.equals("command") || strTaskType.equals("dummy")){
									if( !strMemLib.equals("") || !strMemName.equals("")) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "작업 타입이 command/dummy일 경우 " + (idx_row+1) + "번째 열의 프로그램명과 프로그램위치는 사용할 수 없습니다.");
										
										throw new DefaultServiceException(rMap3);
									}
								}
								
								//작업유형이 command일 경우 작업수행명령 필수 그 외는 불가
								if( strTaskType.equals("command")) {
									if(strCommand.equals("")) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "작업 타입이 command일 경우 작업수행명령은 필수 입니다. \\n\\n * " + (idx_row+1) + "번째 열의 작업수행명령 : " + strCommand);
										
			  							throw new DefaultServiceException(rMap3);
									}
								}
								if( strTaskType.equals("script") || strTaskType.equals("dummy") ){
									if(!strCommand.equals("")) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "작업 타입이 script/dummy일 경우 작업수행명령은 사용할 수 없습니다. \\n\\n * " + (idx_row+1) + "번째 열의 작업수행명령 : " + strCommand);
										
			  							throw new DefaultServiceException(rMap3);
									}
								}
							}


							if(Character.isUpperCase(strTaskType.charAt(0))) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "작업 타입은 소문자로 작성 바랍니다. \\n\\n * " + (idx_row+1) + "번째 열의 작업 타입 : " + strTaskType);
								
								throw new DefaultServiceException(rMap3);
							}

							if( strTaskType.equals("script") ){
								rMap2.put("task_type", 	"job");
							}
							//수행서버
							if( strNodeId.equals("") ){
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 수행서버는 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
							} else {
								Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
								appGrpCodeMap.put("SCHEMA", 	rMap2.get("SCHEMA"));
								appGrpCodeMap.put("node_id",  	strNodeId);

								List<CommonBean> appGrpCodeList = commonDao.dGetMHostList(appGrpCodeMap);
								if( appGrpCodeList.size() == 0 ){
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "해당 수행서버가 존재하지 않습니다. \\n\\n * " + (idx_row+1)+"번째 열의 수행서버 : " + strNodeId);

									throw new DefaultServiceException(rMap3);
								}

								// 코드관리 - 폴더의 수행서버 권한 사용여부(Y일 경우에만 수행서버 권한 체크함)
								Map<String, Object> sCodeMap = new HashMap<String, Object>();

								String scode_nm = "";
								sCodeMap.put("SCHEMA", 	rMap2.get("SCHEMA"));
								sCodeMap.put("mcode_cd", "M96");

								List<CommonBean> sCodeList = commonDao.dGetsCodeList(sCodeMap);
								for(int j = 0; j < sCodeList.size(); j++) {
									CommonBean bean = (CommonBean)sCodeList.get(j);
									scode_nm = CommonUtil.isNull(bean.getScode_nm());
								}

								if(scode_nm.equals("Y")) {
									appGrpCodeMap.put("grp_nm", strParentTable_name);

									appGrpCodeList = commonDao.dGetMHostList(appGrpCodeMap);
									if (appGrpCodeList.size() == 0) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code", "-2");
										rMap3.put("r_msg", "해당 폴더에 수행서버 권한이 없습니다. \\n\\n * " + (idx_row + 1) + "번째 열의 수행서버 : " + strNodeId);

										throw new DefaultServiceException(rMap3);
									}
								}
							}
							
							//계정명
							if( strOwner.equals("") ){
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 계정명은 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
							} else {
								Map<String, Object> appGrpCodeMap = new HashMap<String, Object>();
								appGrpCodeMap.put("SCHEMA", rMap2.get("SCHEMA"));
								appGrpCodeMap.put("node_id", strNodeId);

								List<CommonBean> appGrpCodeList = commonDao.dGetMHostList(appGrpCodeMap);
								if (appGrpCodeList.size() == 0) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code", "-2");
									rMap3.put("r_msg", "해당 수행서버에 계정명이 존재하지 않습니다. \\n\\n * " + (idx_row + 1) + "번째 열의 수행서버 : " + strNodeId);

									throw new DefaultServiceException(rMap3);
								}
							}
						
							//반복작업
							if(chk_cyclic.equals("1") || chk_cyclic.equals("0")){
								if(chk_cyclic.equals("1")) {
									if(!strCyclicType.equals("C") && !strCyclicType.equals("V") && !strCyclicType.equals("S")) {
										
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "반복구분은 C(반복주기), V(반복주기(불규칙)), S(시간지정) 입니다. \\n\\n * " + (idx_row+1) + "번째 열의 반복구분 : " + strCyclicType);
										
										throw new DefaultServiceException(rMap3);	
									}
									if(strCyclicType.equals("C")){
										if ( strCyclicType.equals("C") && chk_cyclic.equals("1") && (rerun_interval.equals("") || !CommonUtil.NumberChk(rerun_interval)) ) {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "반복주기는 1(분) 이상의 숫자형식입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복주기 : " + rerun_interval);
											
											throw new DefaultServiceException(rMap3);	
										}
										
										if ( strCyclicType.equals("C") && chk_cyclic.equals("1") && (rerun_interval.equals("") || CommonUtil.NumberChk(rerun_interval)) ) {
											if(Double.parseDouble(rerun_interval) <= 0){
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "반복주기는 1(분) 이상입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복주기 : " + rerun_interval);
												
												throw new DefaultServiceException(rMap3);	
											}
										}
										
										if(rerun_interval.length() > 6 && chk_cyclic.equals("1")) {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "반복주기는 6자리 이하 숫자입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복주기 : " + rerun_interval);
											
											throw new DefaultServiceException(rMap3);	
										}
										
										if(!strIndCyclic.equals("S") && !strIndCyclic.equals("E") && !strIndCyclic.equals("T")){
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "반복기준은 S or E or T 입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복기준 : " + strIndCyclic);
											
											throw new DefaultServiceException(rMap3);	
										}
										
										if(strIndCyclic.equals("S")) {
											strCountCyclicFrom = "start";
										}else if(strIndCyclic.equals("E")) {
											strCountCyclicFrom = "end";
										}else if(strIndCyclic.equals("T")) {
											strCountCyclicFrom = "target";
										}
										
									}else if(strCyclicType.equals("V")){
										String[] interval_sequence = strIntervalSequence.split(",");
										for(int itv =0; itv < interval_sequence.length; itv++){
											if(CommonUtil.NumberChk(interval_sequence[itv])){
												if ( strCyclicType.equals("V") && chk_cyclic.equals("1") && (strIntervalSequence.equals("") || (Double.parseDouble(interval_sequence[itv]) <= 0)) ) {
													Map rMap3 = new HashMap();
													rMap3.put("r_code","-2");
													rMap3.put("r_msg", "반복주기(불규칙)는 1(분) 이상입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복주기(불규칙) : " + strIntervalSequence);
													
													throw new DefaultServiceException(rMap3);	
												}
											}else{
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "반복주기(불규칙)는 숫자형식입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복주기(불규칙) : " + strIntervalSequence);
												
												throw new DefaultServiceException(rMap3);	
											}
											if(interval_sequence[itv].length() > 6 && chk_cyclic.equals("1")) {
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "반복주기(불규칙)은 6자리 이하 숫자입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복주기(불규칙) : " + strIntervalSequence);
												
												throw new DefaultServiceException(rMap3);	
											}
										}
										if(strIndCyclic.equals("T")){
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "반복주기(불규칙)은 반복기준 [T]를 사용 할 수 없습니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복기준 : " + strIndCyclic);
											
											throw new DefaultServiceException(rMap3);	
										}
										if(!strIndCyclic.equals("S") && !strIndCyclic.equals("E")){
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "반복주기(불규칙)의 반복기준은 S or E입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복기준 : " + strIndCyclic);
											
											throw new DefaultServiceException(rMap3);	
										}
										if(strIndCyclic.equals("S")) {
											strCountCyclicFrom = "start";
										}else if(strIndCyclic.equals("E")) {
											strCountCyclicFrom = "end";
										}
										
									}else if(strCyclicType.equals("S")){
										String[] specific_times = strSpecificTimes.split(",");
										
										if(strSpecificTimes.equals("")) {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "반복주기(시간지정) 항목의 규칙은 'HHMM' 입니다.(ex : 1000) \\n\\n * " + (idx_row+1)+"번째 열의 반복주기(시간지정) : " + strSpecificTimes);
											
											throw new DefaultServiceException(rMap3);
										}
										for(int st =0; st < specific_times.length; st++){
											if ( strCyclicType.equals("S") && chk_cyclic.equals("1") && !specific_times[st].equals("")) {
												if ( !DateUtil.checkHHMM(specific_times[st]) || specific_times[st].equals("")) {
													Map rMap3 = new HashMap();
													rMap3.put("r_code","-2");
													rMap3.put("r_msg", "반복주기(시간지정) 항목의 규칙은 'HHMM' 입니다.(ex : 1000) \\n\\n * " + (idx_row+1)+"번째 열의 반복주기(시간지정) : " + strSpecificTimes);
													
													throw new DefaultServiceException(rMap3);
												}
												
												if(specific_times[st].length() > 6) {
													Map rMap3 = new HashMap();
													rMap3.put("r_code","-2");
													rMap3.put("r_msg", "반복주기(시간지정)는 6자리 이하 숫자 입니다." + (idx_row+1)+"번째 열의 반복주기(시간지정) : " + strSpecificTimes);
													
													throw new DefaultServiceException(rMap3);	
												}
											}
											
										}
										if(strTolerance.length() > 5 && !CommonUtil.NumberChk(strTolerance)) {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "허용오차는 5자리 이하 숫자형식입니다. \\n\\n * " + (idx_row+1)+"번째 열의 허용오차 : " + strTolerance);
											
											throw new DefaultServiceException(rMap3);	
										}
									}else if(strCyclicType == null || strCyclicType.equals("")){
											
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "반복작업일 경우 반복구분은 필수입니다. (예 : C(반복주기), V(반복주기(불규칙)), S(시간지정)) \\n\\n * " + (idx_row+1) + "번째 열의 반복구분 : " + strCyclicType);
										
										throw new DefaultServiceException(rMap3);	
									}
								//반복작업이 아닐 경우 관련 항목 리셋
								}else if(chk_cyclic.equals("0")) {
									rMap2.put("cyclic_type", "");
									rMap2.put("rerun_interval",  "");
									rMap2.put("interval_sequence",  "");
									rMap2.put("specific_times",  "");
									rMap2.put("ind_cyclic",	"");
									rMap2.put("tolerance", "");
									rMap2.put("rerun_max", "");
									rMap2.put("count_cyclic_from", "");
								}
								
							}else{
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "반복작업은 0(일반) 또는 1(사이클)입니다. \\n\\n * " + (idx_row+1)+"번째 열의 반복작업 : " + chk_cyclic);
								
								throw new DefaultServiceException(rMap3);								
							}
							
							//작업시작시간
							if( !strTimeFrom.equals("") ){
								if ( !DateUtil.checkHHMM(strTimeFrom) ) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "작업시작시간 항목의 규칙은 'HHMM'입니다.(ex : 1000) \\n\\n * " + (idx_row+1) + "번째 열의 작업시작시간 : " + strTimeFrom);
									
									throw new DefaultServiceException(rMap3);
								}								
							}
							
							//작업종료시간
							strTimeUntill = strTimeUntill.replace("&gt;", ">");
							if( !strTimeUntill.equals("") && !strTimeUntill.equals(">")){
								if ( !DateUtil.checkHHMM(strTimeUntill) ) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "작업종료시간 항목의 규칙은 'HHMM'입니다.(ex : 1000) \\n\\n * " + (idx_row+1) + "번째 열의 작업종료시간 : " + strTimeUntill);
									
									throw new DefaultServiceException(rMap3);
								}								
							}
							
							//반복작업이여도 작업종료시간 체크 제외
//							if(chk_cyclic.equals("1") && (strTimeUntill.length() < 4 || strTimeUntill.equals(">"))){
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", "반복작업의 경우 작업종료시간 필수입니다. \\n\\n * " + (idx_row+1) + "번째 열의 종료시간 : " + strTimeUntill);
//								
//								throw new DefaultServiceException(rMap3);	
//							}
							
							//수행 범위일
							if(!strActiveDay.equals("")) {
								if(!DateUtil.checkYYYYMMDD(strActiveFrom) || !DateUtil.checkYYYYMMDD(strActiveTill) ) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "수행 범위일 항목의 규칙은 'YYYYMMDD~YYYYMMDD'입니다.(ex : 20230822~20230826) \\n\\n * " + (idx_row+1) + "번째 열의 작업종료시간 : " + strActiveDay);
									
									throw new DefaultServiceException(rMap3);
								}else if(strActiveDay.length() != 17) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "수행 범위일 항목의 규칙은 'YYYYMMDD~YYYYMMDD'입니다.(ex : 20230822~20230826) \\n\\n * " + (idx_row+1) + "번째 열의 작업종료시간 : " + strActiveDay);
									
									throw new DefaultServiceException(rMap3);
								}
								
								if(DateUtil.diffOfDate(strActiveFrom, strActiveTill) < 0) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "수행 범위일의 시작 및 종료 날짜를 다시 입력하세요. \\n\\n * " + (idx_row+1) + "번째 열의 작업종료시간 : " + strActiveDay);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							//캘린더
							List calList = new ArrayList();
							if(!strDaysCal.equals("")) {
								rMap.put("cal_text", strDaysCal);
								
								calList = commonDao.dGetCalCodeList3(rMap);
								if(calList.size() == 0) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "등록된 월캘린더가 아닙니다. \\n\\n * " + (idx_row+1)+"번째 열의 월캘린더 : " + strDaysCal);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							if(!strMonth1.equals("")) {
								if(!strMonth1.equals("0") && !strMonth1.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "1월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 1월 : " + strMonth1);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth2.equals("")) {
								if(!strMonth2.equals("0") && !strMonth2.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "2월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 2월 : " + strMonth2);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth3.equals("")) {
								if(!strMonth3.equals("0") && !strMonth3.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "3월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 3월 : " + strMonth3);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth4.equals("")) {
								if(!strMonth4.equals("0") && !strMonth4.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "4월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 4월 : " + strMonth4);
								
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth5.equals("")) {
								if(!strMonth5.equals("0") && !strMonth5.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "5월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 5월 : " + strMonth5);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth6.equals("")) {
								if(!strMonth6.equals("0") && !strMonth6.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "6월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 6월 : " + strMonth6);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth7.equals("")) {
								if(!strMonth7.equals("0") && !strMonth7.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "7월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 7월 : " + strMonth7);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth8.equals("")) {
								if(!strMonth8.equals("0") && !strMonth8.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "8월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 8월 : " + strMonth8);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth9.equals("")) {
								if(!strMonth9.equals("0") && !strMonth9.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "9월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 9월 : " + strMonth9);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth10.equals("")) {
								if(!strMonth10.equals("0") && !strMonth10.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "10월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 10월 : " + strMonth10);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth11.equals("")) {
								if(!strMonth11.equals("0") && !strMonth11.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "11월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 11월 : " + strMonth11);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							
							if(!strMonth12.equals("")) {
								if(!strMonth12.equals("0") && !strMonth12.equals("1")) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "12월의 경우 0(NO) 또는 1(YES)만 가능합니다. \\n\\n * " + (idx_row+1)+"번째 열의 12월 : " + strMonth12);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							/*
							 * if( !strDaysCal.equals("") && !strWeeksCal.equals("") ){ if(
							 * strScheduleAndOr.equals("")){ Map rMap3 = new HashMap();
							 * rMap3.put("r_code","-2"); rMap3.put("r_msg",
							 * (idx_row)+"번째 열 \\n조건은 필수 값 입니다.");
							 * 
							 * throw new DefaultServiceException(rMap3); } }
							 */
							
							if( !strScheduleAndOr.equals("")){
								if(strScheduleAndOr.equals("1") || strScheduleAndOr.equals("0")){
									
								}else{
									
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "조건은 0(or) 또는 1(and)만 가능합니다. \\n\\n * " + (idx_row+1) + "번째 열 조건 : " + strScheduleAndOr);
									
									throw new DefaultServiceException(rMap3);
									
								}
							}
							//일캘린더
							if(!strWeeksCal.equals("")) {
								rMap.put("cal_text", strWeeksCal);
								
								calList = commonDao.dGetCalCodeList3(rMap);
								if(calList.size() == 0) {
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "등록된 일캘린더가 아닙니다. \\n\\n * " + (idx_row+1) + "번째 열 일캘린더 : " + strWeeksCal);
									
									throw new DefaultServiceException(rMap3);
								}
							}
							//실행요일
//							if(!strWeekDays.equals("")) {
//								String[] week_days = strWeekDays.split(",");
//								for(int st =0; st < week_days.length; st++){
//									if(!CommonUtil.NumberChk(week_days[st])) {
//										Map rMap3 = new HashMap();
//										rMap3.put("r_code","-2");
//										rMap3.put("r_msg", "실행요일은 0(일)에서 6(토)사이의 값만 가능합니다. \\n\\n * " + (idx_row+1) + "번째 열 실행요일 : " + strWeekDays);
//										
//										throw new DefaultServiceException(rMap3);
//									}
//									if(CommonUtil.NumberChk(week_days[st])) {
//										if(Double.parseDouble(week_days[st]) < 0 || Double.parseDouble(week_days[st]) > 6) {
//											Map rMap3 = new HashMap();
//											rMap3.put("r_code","-2");
//											rMap3.put("r_msg", "실행요일은 0(일)에서 6(토)사이의 값만 가능합니다. \\n\\n * " + (idx_row+1) + "번째 열 실행요일 : " + strWeekDays);
//											
//											throw new DefaultServiceException(rMap3);
//										}
//									}
//								}
//							}
							//특정실행날짜
							if(!strGeneralDate.equals("")) {
								String[] strGeneralDate_array = strGeneralDate.split(",");
								for(int gd =0; gd <strGeneralDate_array.length; gd ++ ) {
									if(CommonUtil.NumberChk(strGeneralDate_array[gd].trim())) {
										if(strGeneralDate_array[gd].trim().length() > 4) {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "특정실행날짜는 mmdd형식의 숫자값만 가능합니다.(예: 0505, 0304) : " + strGeneralDate);
											
											throw new DefaultServiceException(rMap3);
										}else {
											System.out.println("strGeneralDate_array[gd].substring(0,2) : " + strGeneralDate_array[gd].substring(0,2));
											System.out.println("strGeneralDate_array[gd].substring(2,4) : " + strGeneralDate_array[gd].substring(2,4));
											if(Integer.valueOf(strGeneralDate_array[gd].trim().substring(0,2)) < 1 || Integer.valueOf(strGeneralDate_array[gd].trim().substring(0,2)) > 12) {
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "특정실행날짜는 mmdd형식의 숫자값만 가능합니다.(예: 0505, 0304) : " + strGeneralDate);
												
												throw new DefaultServiceException(rMap3);
											}
											
											if(Integer.valueOf(strGeneralDate_array[gd].trim().substring(2,4)) < 1 || Integer.valueOf(strGeneralDate_array[gd].trim().substring(2,4)) > 31) {
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "특정실행날짜는 mmdd형식의 숫자값만 가능합니다.(예: 0505, 0304) : " + strGeneralDate);
												
												throw new DefaultServiceException(rMap3);
											}
										}
									}else {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "특정실행날짜는 mmdd형식의 숫자값만 가능합니다.(예: 0505, 0304) : " + strGeneralDate);
										
										throw new DefaultServiceException(rMap3);
									}
								}
							}
							
							if(chk_confirm_flag.equals("") || chk_confirm_flag.equals("1") || chk_confirm_flag.equals("0")){
								
							}else{
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "Confirm Flag는 0[일반] 또는 1[컨펌]만 사용가능합니다. \\n\\n * " + (idx_row+1) + "번째 열의 Confirm Flag : " + chk_confirm_flag);
								
								throw new DefaultServiceException(rMap3);
								
							}
							
							if( chk_cyclic.equals("1") ){
								rMap2.put("max_wait", "0");
							}else{
								// 오픈데일리 작업은 MAX_WAIT 99 설정
								if ( strJobSchedGb.equals("O") ) {
									rMap2.put("max_wait", "99");
								} else {
									rMap2.put("max_wait", strMaxWait);
									logger.info("#T WorksApprovalDocServiceImpl | dPrcDoc06 | " + strMaxWait);
									
								}
							}
							//선행작업조건
							if( !in_cond.equals("") ){
								
								if( in_cond.indexOf("\n") > -1 ) {
								
									Map rMap3 = new HashMap();
									rMap3.put("r_code","-2");
									rMap3.put("r_msg", "IN_CONDITION은 줄바꿈을 사용할 수 없습니다. \\n\\n * " + (idx_row+1) + "번째 열의 IN_CONDITION : " + in_cond);
									
									throw new DefaultServiceException(rMap3);
									
								} else {
								
									String[] t_conditions_in = in_cond.split("[|]");
								    if ( t_conditions_in != null && t_conditions_in.length > 0 ) {
								    	for ( int ii = 0; ii < t_conditions_in.length; ii++ ) {
											String[] aTmp = t_conditions_in[ii].split(",",3);
											
											if ( aTmp.length != 3 ) {
												
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "IN_CONDITION은 [컨디션명,일자유형,구분] 형식으로 사용해야 합니다. \\n\\n * " + (idx_row+1) + "번째 열의 IN_CONDITION : " + in_cond);
												
												throw new DefaultServiceException(rMap3);
											}
											
											if ( !CommonUtil.isNull(aTmp[1]).equals("") ) {
												if ( !(CommonUtil.isNull(aTmp[1]).equals("ODAT") || CommonUtil.isNull(aTmp[1]).equals("NEXT") || CommonUtil.isNull(aTmp[1]).equals("STAT") || CommonUtil.isNull(aTmp[1]).equals("PREV")) ) {
													
													Map rMap3 = new HashMap();
													rMap3.put("r_code","-2");
													rMap3.put("r_msg", "IN_CONDITION의 일자유형은 ODAT, NEXT, STAT, PREV 중 하나를 사용해야 합니다.[대문자] \\n\\n * " + (idx_row+1) + "번째 열의 IN_CONDITION : " + in_cond);
											
													throw new DefaultServiceException(rMap3);
												}
											}
											
											if ( !CommonUtil.isNull(aTmp[2]).equals("") ) {
												if ( !(CommonUtil.isNull(aTmp[2]).equals("and") || CommonUtil.isNull(aTmp[2]).equals("or") ) ) {
													
													Map rMap3 = new HashMap();
													rMap3.put("r_code","-2");
													rMap3.put("r_msg", "IN_CONDITION의 구분은 and, or 중 하나를 사용해야 합니다.[소문자] \\n\\n * " + (idx_row+1) + "번째 열의 IN_CONDITION : " + in_cond);
													
													throw new DefaultServiceException(rMap3);
												}
											}
								    	}							    	
								    }
								}
							} 
							//후행작업조건
							if( out_cond.equals("") ) {
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 OUT_CONDITION은 필수 입니다.");
								
								throw new DefaultServiceException(rMap3);
								
							} else if( out_cond.indexOf("\n") > -1 ) {
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "OUT_CONDITION은 줄바꿈을 사용할 수 없습니다. \\n\\n * " + (idx_row+1) + "번째 열의 OUT_CONDITION : " + out_cond);
								
								throw new DefaultServiceException(rMap3);
								
							}else{
								
								boolean bOutCondNameCheck = false;
								
								String[] t_conditions_out = out_cond.split("[|]");
								String strCondSuffix = CommonUtil.isNull(CommonUtil.getMessage("COND_SUFFIX"));
							    if ( t_conditions_out != null && t_conditions_out.length > 0 ) {
							    	for ( int ii = 0; ii < t_conditions_out.length; ii++ ) {
										String[] aTmp = t_conditions_out[ii].split(",",3);
										
										if ( aTmp.length != 3 ) {
											
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "OUT_CONDITION은 [컨디션명,일자유형,구분] 형식으로 사용해야 합니다. \\n\\n * " + (idx_row+1) + "번째 열의 OUT_CONDITION : " + out_cond);
											
											throw new DefaultServiceException(rMap3);
										}
										
										if ( !CommonUtil.isNull(aTmp[0]).equals("") ) {
											
											if ( CommonUtil.isNull(aTmp[0]).equals(strJobName + strCondSuffix) ) {
												bOutCondNameCheck = true;
											}
										}

										if ( !bOutCondNameCheck ) {
										    	
										    	Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", (idx_row+1)+"번째 열 \\nOUT_CONDITION에는 자기작업 CONDITION" + strCondSuffix + "가 필수입니다.");
												
												throw new DefaultServiceException(rMap3);
										}

										if ( !CommonUtil.isNull(aTmp[1]).equals("") ) {
											if ( !(CommonUtil.isNull(aTmp[1]).equals("ODAT") || CommonUtil.isNull(aTmp[1]).equals("NEXT") || CommonUtil.isNull(aTmp[1]).equals("STAT") || CommonUtil.isNull(aTmp[1]).equals("PREV")) ) {
												
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "OUT_CONDITION의 일자유형은 ODAT, NEXT, STAT, PREV 중 하나를 사용해야 합니다.[대문자] \\n\\n * " + (idx_row+1) + "번째 열의 OUT_CONDITION : " + out_cond);
												
												throw new DefaultServiceException(rMap3);
											}
										}
										
										if ( !CommonUtil.isNull(aTmp[2]).equals("") ) {
											if ( !(CommonUtil.isNull(aTmp[2]).equals("add") || CommonUtil.isNull(aTmp[2]).equals("delete") ) ) {
												
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "OUT_CONDITION의 구분은 add, delete 중 하나를 사용해야 합니다.[소문자] \\n\\n * " + (idx_row+1) + "번째 열의 OUT_CONDITION : " + out_cond);
												
												throw new DefaultServiceException(rMap3);
											}
										}
							    	}							    	
							    }
							}
						}
						
						String strJobName 			= CommonUtil.isNull(rMap2.get("job_name"));
						String strJobTypeGb 		= CommonUtil.isNull(rMap2.get("jobTypeGb"));
						String strMonthDays			= CommonUtil.isNull(rMap2.get("month_days"));
						String strDaysCal			= CommonUtil.isNull(rMap2.get("days_cal"));
						String strMonth1			= CommonUtil.isNull(rMap2.get("month_1" ));
						String strMonth2			= CommonUtil.isNull(rMap2.get("month_2" ));
						String strMonth3			= CommonUtil.isNull(rMap2.get("month_3" ));
						String strMonth4			= CommonUtil.isNull(rMap2.get("month_4" ));
						String strMonth5			= CommonUtil.isNull(rMap2.get("month_5" ));
						String strMonth6			= CommonUtil.isNull(rMap2.get("month_6" ));
						String strMonth7			= CommonUtil.isNull(rMap2.get("month_7" ));
						String strMonth8			= CommonUtil.isNull(rMap2.get("month_8" ));
						String strMonth9			= CommonUtil.isNull(rMap2.get("month_9" ));
						String strMonth10			= CommonUtil.isNull(rMap2.get("month_10"));
						String strMonth11			= CommonUtil.isNull(rMap2.get("month_11"));
						String strMonth12			= CommonUtil.isNull(rMap2.get("month_12"));
						String strScheduleAndOr		= CommonUtil.isNull(rMap2.get("schedule_and_or"));
						String strWeekDays			= CommonUtil.isNull(rMap2.get("week_days"));
						String strWeekCal			= CommonUtil.isNull(rMap2.get("weeks_cal"));
						String strJobSchedGb		= CommonUtil.isNull(rMap2.get("jobSchedGb"));
						String strTpostproc			= CommonUtil.isNull(rMap2.get("t_postproc"));
						String strLateSub			= CommonUtil.isNull(rMap2.get("late_sub"));
						String strLateTime			= CommonUtil.isNull(rMap2.get("late_time"));
						String strLateExec			= CommonUtil.isNull(rMap2.get("late_exec"));
						String strTimeUtil			= CommonUtil.isNull(rMap2.get("time_until"));
						String strCyclic			= CommonUtil.isNull(rMap2.get("cyclic"));
						String strBatchJobGrade		= CommonUtil.isNull(rMap2.get("batchjobGrade"));
						String strTConditionOut		= CommonUtil.isNull(rMap2.get("t_conditions_out"));
						String strTsteps			= CommonUtil.isNull(rMap2.get("t_steps"));

						String strSuccessSmsYn		= CommonUtil.isNull(rMap2.get("success_sms_yn"));
						
						String strTresourceQ 		=  CommonUtil.isNull(rMap2.get("t_resources_q"));
						
						List defaultResource		= (List)map.get("resourceDefaultList");
						List defaultVariable		= (List)map.get("variableDefaultList");
						
						String strResourceDefaultValue 		= "";
						String strResourceDefaultName		= "";
						String strResourceDefaultNameList 	= "";
						
						String strVariableDefaultValue 		= "";
						String strVariableDefaultName		= "";
						String strVariableDefaultNameList 	= "";
						
						
						if ( defaultResource != null ) {
							for ( int k = 0; k < defaultResource.size(); k++ ) {
								CommonBean commonBean 	= (CommonBean) defaultResource.get(k);
								strResourceDefaultValue = CommonUtil.isNull(commonBean.getScode_nm());
								strResourceDefaultName 	= CommonUtil.isNull(commonBean.getScode_eng_nm());
								
								if(strResourceDefaultName!=null&&strResourceDefaultValue!=null) {
									strResourceDefaultNameList += strResourceDefaultName;
									strResourceDefaultNameList += ",";
									strResourceDefaultNameList += strResourceDefaultValue;
									strResourceDefaultNameList += "|";
								}
							}
						}
						
						
						if ( defaultVariable != null ) {
							for ( int kk = 0; kk < defaultVariable.size(); kk++ ) {
								CommonBean commonBean = (CommonBean) defaultVariable.get(kk);
								strVariableDefaultValue = CommonUtil.isNull(commonBean.getScode_nm());
								strVariableDefaultName 	= CommonUtil.isNull(commonBean.getScode_eng_nm());
								
								if(strVariableDefaultName!=null&&strVariableDefaultValue!=null) {
									strVariableDefaultNameList += strVariableDefaultName;
									strVariableDefaultNameList += ",";
									strVariableDefaultNameList += strVariableDefaultValue;
									strVariableDefaultNameList += "|";
								}
							}
						}
						
						//RESOURCE
						if( strTresourceQ.indexOf("\n") > -1 ) {
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "RESOURCE에는 줄바꿈을 사용할 수 없습니다. \\n\\n * " + (idx_row+1) + "번째 열의 RESOURCE : " + strTresourceQ);
							
							throw new DefaultServiceException(rMap3);
							
						}else{
							String[] t_resources_q = strTresourceQ.split("[|]");
							String[] arrResourceDefaultNameList = null;
						
							//코드관리 -> 리소스 기본값의 이름을 불러와서 맨끌에 붙여진 (,)를 제거해주고 ,를 기준으로 잘라줌(2개이상일 경우를 위함)
							if( !strResourceDefaultNameList.equals("")) {
								strResourceDefaultNameList = strResourceDefaultNameList.substring(0, strResourceDefaultNameList.length()-1);
								arrResourceDefaultNameList = strResourceDefaultNameList.split("[|]");							
							}
						
						    if ( t_resources_q != null && t_resources_q.length > 0 ) {
						    	for ( int ii = 0; ii < t_resources_q.length; ii++ ) {
							    	String[] aTmp = t_resources_q[ii].split(",", 2);
							    	String resName = aTmp[0];
									
							    	if(arrResourceDefaultNameList != null) {
							    		for (int k = 0; k < arrResourceDefaultNameList.length; k++) {
							    			String[] aTmp2 = arrResourceDefaultNameList[k].split(",", 2);
							    			String defaultResName = aTmp2[0];
							    			if (resName.equals(defaultResName)) {
							    				strTresourceQ = strTresourceQ.replace(t_resources_q[ii], "");
							    			}
							    			strTresourceQ = strTresourceQ.replaceAll("^\\||\\|$", "");
							    		}							    		
							    	}
							    	if(!strTresourceQ.equals("")) {
							    									    		
							    		Pattern pattern = Pattern.compile("[ㄱ-ㅎ|ㅏ-ㅣ|가-힣|a-z|A-Z\\$\\\\/*?]");
										Matcher matcher = pattern.matcher(aTmp[1]);
										if(matcher.find()) {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n RESOURCE의 값 Required Usage에는 문자를 입력 할 수 없습니다.");

											throw new DefaultServiceException(rMap3);
										}
										
										for(int j = 0; j<aTmp.length; j++) {
											if ( aTmp.length != 2 || aTmp[j].contains(",") || aTmp[j].contains("|") ) {
												
												Map rMap3 = new HashMap();
												rMap3.put("r_code","-2");
												rMap3.put("r_msg", "RESOURCE는 [Name,Required Usage] 형식으로 사용해야 합니다.\\n\\n * " + (idx_row+1) + "번째 열의 RESOURCE : " + strTresourceQ);
												
												throw new DefaultServiceException(rMap3);
											}											
										}
							    		
										
										if ( !CommonUtil.isNull(aTmp[0]).equals("") ) {
											
										}else {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "RESOURCE는 [Name,Required Usage] 형식으로 사용해야 합니다.\\n\\n * " + (idx_row+1) + "번째 열의 RESOURCE : " + strTresourceQ);
	
											throw new DefaultServiceException(rMap3);
										}
										
										if ( !CommonUtil.isNull(aTmp[1]).equals("") ) {
											
										}else {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "RESOURCE는 [Name,Required Usage] 형식으로 사용해야 합니다.\\n\\n * " + (idx_row+1) + "번째 열의 RESOURCE : " + strTresourceQ);
										
											throw new DefaultServiceException(rMap3);
										}
							    	}
						    	}
						    }
					
						    if(!strTresourceQ.equals("")) {
						    	strTresourceQ	= strResourceDefaultNameList + "|" + strTresourceQ;									
							} else {
								strTresourceQ	= strResourceDefaultNameList;
							}
						    strTresourceQ = strTresourceQ.replaceAll("^\\||\\|$", "");	
					    	rMap2.put("t_resources_q",	strTresourceQ);
						}
						
						//고정 변수 t_set 설정 하기
						String strServerGb 		= CommonUtil.isNull(CommonUtil.getMessage("SERVER_GB"));
						
//						String strParamValue	= "/app/ctm/ctmcore/ENV/Set_Env.txt";
//						String t_set_Tmp 		= CommonUtil.isNull(rMap2.get("t_set"));
//						t_set_Tmp				= CommonUtil.replaceStrHtml(t_set_Tmp);
//						System.out.println(":::::::::::::::::::strParamValue" +  strParamValue);
//						System.out.println(":::::::::::::::::::t_set_Tmp" +  t_set_Tmp);
//						if(t_set_Tmp.equals("")){
//							rMap2.put("t_set", strParamValue);
//						}else if(t_set_Tmp.indexOf(strParamValue) > -1){
//							rMap2.put("t_set", t_set_Tmp);
//						}else{
//							rMap2.put("t_set", strParamValue + "|" + t_set_Tmp);
//						}
//						System.out.println(":::::::::::::::::::" +  CommonUtil.isNull(rMap2.get("t_set")));
						
						String strTSet = CommonUtil.isNull(rMap2.get("t_set"));
						
							if( strTSet.indexOf("\n") > -1 ) {
								
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "변수에는 줄바꿈을 사용할 수 없습니다. \\n\\n * " + (idx_row+1) + "번째 열의 변수 : " + strTSet);
								
								throw new DefaultServiceException(rMap3);
								
							}else{
							String[] t_set = strTSet.split("[|]");
							String[] arrVariableDefaultNameList = null;
							
							//코드관리 -> 변수 기본값의 이름을 불러와서 맨끌에 붙여진 (,)를 제거해주고 ,를 기준으로 잘라줌(2개이상일 경우를 위함)
							if ( !strVariableDefaultNameList.equals("")) {
								strVariableDefaultNameList = strVariableDefaultNameList.substring(0, strVariableDefaultNameList.length()-1);   
								arrVariableDefaultNameList = strVariableDefaultNameList.split("[|]");
							}
							    if ( t_set != null && t_set.length > 0 ) {
							    	for ( int ii = 0; ii < t_set.length; ii++ ) {
										String[] aTmp = t_set[ii].split(",",2);
							    	String varName = aTmp[0];
							    	
							    	if(arrVariableDefaultNameList != null) {
								    	for (int k = 0; k < arrVariableDefaultNameList.length; k++) {
								    		String[] aTmp2 = arrVariableDefaultNameList[k].split(",", 2);
									    	String defaultVarName = aTmp2[0];
									    	if ( varName.equals(defaultVarName) ) {
									    		strTSet = strTSet.replace(t_set[ii], "");
									    	}
									    	strTSet = strTSet.replaceAll("^\\||\\|$", "");
								    	}
							    	}
						    		
							    	if(!strTSet.equals("")) {
										if ( aTmp.length != 2 ) {
											
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "변수는 [변수명,변수값] 형식으로 사용해야 합니다.\\n\\n * " + (idx_row+1) + "번째 열의 변수 : " + strTSet);
											
											throw new DefaultServiceException(rMap3);
										}
										
										if ( !CommonUtil.isNull(aTmp[0]).equals("") ) {
											
										}else {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "변수는 [변수명,변수값] 형식으로 사용해야 합니다.\\n\\n * " + (idx_row+1) + "번째 열의 변수 : " + strTSet);

											throw new DefaultServiceException(rMap3);
										}
										
										if ( !CommonUtil.isNull(aTmp[1]).equals("") ) {
											
										}else {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "변수는 [변수명,변수값] 형식으로 사용해야 합니다.\\n\\n * " + (idx_row+1) + "번째 열의 변수 : " + strTSet);
											
											throw new DefaultServiceException(rMap3);
										}	
							    	}
						    	}							    	
							
							
								if(!strTSet.equals("")) {
									strTSet	= strVariableDefaultNameList + "|" + strTSet;									
								} else {
									strTSet	= strVariableDefaultNameList;
								}
								strTSet = strTSet.replaceAll("^\\||\\|$", "");
								
					    	rMap2.put("t_set",	strTSet);
							}
						}
						
						// ON/DO 체크로직
						if(strTsteps.indexOf("\n") > -1 ) {
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "ON/DO에는 줄바꿈을 사용할 수 없습니다. \\n\\n * " + (idx_row+1) + "번째 열의 ON/DO : " + strTsteps);
							
											throw new DefaultServiceException(rMap3);
							
						} else {
							String[] t_steps	= strTsteps.split("[|]");
							String sTmpchk		= "";
							if(t_steps != null && t_steps.length > 0) {
								for(int k = 0; k < t_steps.length; k++) {
									
									if(k < t_steps.length - 1 ){
										sTmpchk = t_steps[k+1];
										}
									
									if(t_steps[k].startsWith("O") && sTmpchk.startsWith("O")) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "ON은 연속적으로 사용할 수 없습니다.");
										throw new DefaultServiceException(rMap3);
							    	}							    	
									
									if(t_steps[0].startsWith("A") || t_steps[t_steps.length - 1].startsWith("O")) {
										Map rMap3 = new HashMap();
										rMap3.put("r_code","-2");
										rMap3.put("r_msg", "ON이 첫번째, DO가 마지막이어야합니다");
										throw new DefaultServiceException(rMap3);
									}
									
									if(t_steps[k].startsWith("A") && t_steps[k].indexOf("SPCYC") > -1) {
										if(strCyclic.equals("0")) {
											Map rMap3 = new HashMap();
											rMap3.put("r_code","-2");
											rMap3.put("r_msg", "반복작업이 아닌경우 DO에 Stop Cyclic를 사용할 수 없습니다 \\n" + (idx_row+1) + "번째 열의 ON/DO를 확인해주세요.");
											throw new DefaultServiceException(rMap3);
										}
									}
								}
							}
						}
						
						StringBuffer stringB = new StringBuffer();
						
						//임계시간
						if( strLateExec.equals("0") ) {
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "수행임계시간은 1 이상입니다. \\n\\n * " +(idx_row+1)+"번째 열의 수행임계시간 : " + strLateExec);
							
							throw new DefaultServiceException(rMap3);
						}		
						
						if ( !strLateExec.equals("") && strLateExec.length() > 3 ) {
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "수행임계시간 항목의 규칙은 '분단위' 입니다.(ex :60) \\n\\n * " +(idx_row+1)+"번째 열의 수행임계시간 : " + strLateExec);
							
							throw new DefaultServiceException(rMap3);
						}
						
						if ( !strLateSub.equals("") && !DateUtil.checkHHMM(strLateSub) ) {
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "시작임계시간 항목의 규칙은 'HHMM' 입니다.(ex : 1000) \\n\\n * " +(idx_row+1)+"번째 열의 시작임계시간 : " + strLateSub);
							
							throw new DefaultServiceException(rMap3);
						}
						
						if ( !strLateTime.equals("") && !DateUtil.checkHHMM(strLateTime) ) {
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "종료임계시간 항목의 규칙은 'HHMM' 입니다.(ex : 1000) \\n\\n * " +(idx_row+1)+"번째 열의 종료임계시간 : " + strLateTime);
							
							throw new DefaultServiceException(rMap3);
						}
						
//						if( strTimeUtil.equals("") && strCyclic.equals("1") ){
//
//							Map rMap3 = new HashMap();
//							rMap3.put("r_code","-2");
//							rMap3.put("r_msg",  "반복작업의 경우 작업종료시간 필수입니다. \\n\\n * " + (idx_row+1) + "번째 열의 종료시간 : " + strTimeUtil);
//
//							throw new DefaultServiceException(rMap3);
//						}
						if( strTimeUtil.equals("") && !strCyclic.equals("1")){
							
							rMap2.put("time_until", ">");
						}
						
						if ( !strTpostproc.equals("") ) {
							stringB.append(strTpostproc);
							stringB.append("|");
						}
						
						if ( !strLateSub.equals("") && stringB.indexOf("late_submission") == -1) {
							stringB.append("late_submission,"+strLateSub+",EM,urgent,LATE_SUB");
							stringB.append("|");
						}
						
						if ( !strLateTime.equals("") && stringB.indexOf("late_time") == -1) {
							stringB.append("late_time,"+strLateTime+",EM,urgent,LATE_TIME");
							stringB.append("|");
						}
	
						if ( !strLateExec.equals("") && stringB.indexOf("strLateExec") == -1) {
							strLateExec = ">"+strLateExec;
							stringB.append("execution_time,"+strLateExec+",EM,urgent,LATE_EXEC");
							stringB.append("|");
						}
												
						if ( strSuccessSmsYn.equals("Y") ) {
							stringB.append("ok,,EM,urgent,Ended OK");
							stringB.append("|");
						}
						
						String strShout = stringB.toString();
						
						if ( !strShout.equals("") ) {
							if ( strShout.substring(strShout.length()-1, strShout.length()).equals("|") ) {
								strShout = strShout.substring(0, strShout.length()-1);
							}
							rMap2.put("t_postproc", strShout);
						}
						
						// 성공 시 알람 발송
						if( strSuccessSmsYn.equals("") && !strSuccessSmsYn.equals("Y") && !strSuccessSmsYn.equals("N") ){
							
							Map rMap3 = new HashMap();
							rMap3.put("r_code","-2");
							rMap3.put("r_msg", "성공 시 알람 발송 값은 'Y','N' 만 가능 합니다. \\n\\n * " + (idx_row+1) + "번째 열의 성공 시 알람 발송 값 : " + strSuccessSmsYn);
							
							throw new DefaultServiceException(rMap3);
						}
						
						String table_name = CommonUtil.isNull(rMap2.get("table_name"));
						
						// Default 값 설정.
						rMap2.put("retro", 					"0");
						rMap2.put("multiagent",				"0");
						rMap2.put("rerun_interval_time",	"M");
						rMap2.put("doc_cd", 				r_doc_cd);
						rMap2.put("table_name", 			table_name);
						rMap2.put("data_center", 			data_center);
						rMap2.put("flag", 					"detail_ins");
						rMap2.put("month_days", 			strMonthDays.replace("&amp;lt;","<").replace("&lt;","<").replace("&amp;gt;",">").replace("&gt;",">"));
						rMap2.put("week_days", 				strWeekDays.replace("&amp;lt;","<").replace("&lt;","<").replace("&amp;gt;",">").replace("&gt;",">"));
						rMap2.put("time_until", 			strTimeUtil.replace("&gt;", ">"));
												
						rMapDetail = worksApprovalDocDao.dPrcDoc06(rMap2);
						
						// 엑셀 파일 삭제.
						FileUtil fu = new FileUtil();
						fu.delDir(new File(file_path + save_file_nm));
		
						if( !"1".equals(CommonUtil.isNull(rMapDetail.get("r_code"))) ) {
							String r_msg = (idx_row+1)+"번째 열에서 에러 발생";
							
							
							r_msg += CommonUtil.isNull(rMapDetail.get("r_msg"));
							rMapDetail.put("r_msg", r_msg);
							
							throw new DefaultServiceException(rMapDetail);
						}
						
						//매퍼 등록(담당자 : user_id를 가지고 user_cd 찾는다/그룹 : grp_nm을 가지고 grp_cd를 찾는다)
						//담당자1
						if(!CommonUtil.isNull(rMap2.get("author")).equals("")){
							
							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("author")));
							DefJobBean defJobBean = worksApprovalDocDao.dGetUserCd(rMap2);
							
							if( defJobBean  == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자1_사번은 존재 하지 않습니다.\\n" + (idx_row+1)+"번째 열의 담당자1_사번 : "  + rMap2.get("author") );
								throw new DefaultServiceException(rMap3);
							}
			
							if ( !(strSms1.equals("Y") || strSms1.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자1 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail1.equals("Y") || strMail1.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자1 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms1.equals("Y") || strMail1.equals("Y")) ) {
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자1의 SMS, MAIL 중 한개는 무조건 'Y'로 해야 합니다.");
//								throw new DefaultServiceException(rMap3);
//							}
							
							map.put("user_cd_1", 			CommonUtil.isNull(defJobBean.getUser_cd()));
							map.put("sms_1", 				strSms1);
							map.put("mail_1", 				strMail1);
						}  
						
						//담당자2 
						if(!CommonUtil.isNull(rMap2.get("user_cd_2")).equals("")){
							
							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_2")));
							DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
			
							if( defJobBean2  == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자2_사번은 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자2_사번 : "  + rMap2.get("user_cd_2") );
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strSms2.equals("Y") || strSms2.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자2 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail2.equals("Y") || strMail2.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자2 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms2.equals("Y") || strMail2.equals("Y")) ) {
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자2의 SMS, MAIL 중 한개는 'Y' 입니다.");
//								throw new DefaultServiceException(rMap3);
//							}
							
							map.put("user_cd_2", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
							map.put("sms_2", 				strSms2);
							map.put("mail_2", 				strMail2);
						} else {
							map.put("user_cd_2", 			"");
							map.put("sms_2", 				"N");
							map.put("mail_2", 				"N");
						}
						
						if(!CommonUtil.isNull(rMap2.get("user_cd_3")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_3")));
							DefJobBean defJobBean3 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean3 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자3이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자3_사번 : "  + rMap2.get("user_cd_3") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strSms3.equals("Y") || strSms3.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자3의 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail3.equals("Y") || strMail3.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자3의 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms3.equals("Y") || strMail3.equals("Y")) ) {
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자3의 SMS, MAIL 중 한개는 'Y' 입니다.");
//								throw new DefaultServiceException(rMap3);
//							}

							map.put("user_cd_3", 			CommonUtil.isNull(defJobBean3.getUser_cd()));
							map.put("sms_3", 				strSms3);
							map.put("mail_3", 				strMail3);
						} else {
							map.put("user_cd_3", 			"");
							map.put("sms_3", 				"N");
							map.put("mail_3", 				"N");
						}

						if(!CommonUtil.isNull(rMap2.get("user_cd_4")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_4")));
							DefJobBean defJobBean4 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean4 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자4는 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자4_사번 : "  + rMap2.get("user_cd_4") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strSms4.equals("Y") || strSms4.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자4 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail4.equals("Y") || strMail4.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자4 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms4.equals("Y") || strMail4.equals("Y")) ) {
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자4 SMS, MAIL 중 한개는 'Y' 입니다.");
//								throw new DefaultServiceException(rMap3);
//							}
							
							map.put("user_cd_4", 			CommonUtil.isNull(defJobBean4.getUser_cd()));
							map.put("sms_4", 				strSms4);
							map.put("mail_4", 				strMail4);
						} else {
							map.put("user_cd_4", 			"");
							map.put("sms_4", 				"N");
							map.put("mail_4", 				"N");
						}

						if(!CommonUtil.isNull(rMap2.get("user_cd_5")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_5")));
							DefJobBean defJobBean5 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean5 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자5이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자5_사번 : "  + rMap2.get("user_cd_5") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strSms5.equals("Y") || strSms5.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자5 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail5.equals("Y") || strMail5.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자5 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms5.equals("Y") || strMail5.equals("Y")) ) {
//								
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자5 항목에서 SMS, MAIL 중 한개는 'Y' 입니다.");
//								
//								throw new DefaultServiceException(rMap3);
//							}
							
							map.put("user_cd_5", 			CommonUtil.isNull(defJobBean5.getUser_cd()));
							map.put("sms_5", 				strSms5);
							map.put("mail_5", 				strMail5);
						} else {
							map.put("user_cd_5", 			"");
							map.put("sms_5", 				"N");
							map.put("mail_5", 				"N");
						}

						if(!CommonUtil.isNull(rMap2.get("user_cd_6")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_6")));
							DefJobBean defJobBean6 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean6 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자6이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자6_사번 : "  + rMap2.get("user_cd_6") );
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strSms6.equals("Y") || strSms6.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자6 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail6.equals("Y") || strMail6.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자6 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms6.equals("Y") || strMail6.equals("Y")) ) {
//								
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자6의 SMS, MAIL 중 한개는 'Y' 입니다.");
//								
//								throw new DefaultServiceException(rMap3);
//							}
							
							map.put("user_cd_6", 			CommonUtil.isNull(defJobBean6.getUser_cd()));
							map.put("sms_6", 				strSms6);
							map.put("mail_6", 				strMail6);
						} else {
							map.put("user_cd_6", 			"");
							map.put("sms_6", 				"N");
							map.put("mail_6", 				"N");
						}

						if(!CommonUtil.isNull(rMap2.get("user_cd_7")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_7")));
							DefJobBean defJobBean7 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean7 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자7이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자7_사번 : "  + rMap2.get("user_cd_7") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strSms7.equals("Y") || strSms7.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자7 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail7.equals("Y") || strMail7.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자7 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms7.equals("Y") || strMail7.equals("Y")) ) {
//								
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자7의 SMS, MAIL 중 한개는 'Y' 입니다.");
//								
//								throw new DefaultServiceException(rMap3);
//							}
							
							map.put("user_cd_7", 			CommonUtil.isNull(defJobBean7.getUser_cd()));
							map.put("sms_7", 				strSms7);
							map.put("mail_7", 				strMail7);
						} else {
							map.put("user_cd_7", 			"");
							map.put("sms_7", 				"N");
							map.put("mail_7", 				"N");
						}

						if(!CommonUtil.isNull(rMap2.get("user_cd_8")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_8")));
							DefJobBean defJobBean8 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean8 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자8이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자8_사번 : "  + rMap2.get("user_cd_8") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strSms8.equals("Y") || strSms8.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자8 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							
							if ( !(strMail8.equals("Y") || strMail8.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자8 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms8.equals("Y") || strMail8.equals("Y")) ) {
//								
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자8의 SMS, MAIL 중 한개는 'Y' 입니다.");
//								
//								throw new DefaultServiceException(rMap3);
//							}
							
							map.put("user_cd_8", 			CommonUtil.isNull(defJobBean8.getUser_cd()));
							map.put("sms_8", 				strSms8);
							map.put("mail_8", 				strMail8);
						} else {
							map.put("user_cd_8", 			"");
							map.put("sms_8", 				"N");
							map.put("mail_8", 				"N");
						}

						if(!CommonUtil.isNull(rMap2.get("user_cd_9")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_9")));
							DefJobBean defJobBean9 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean9 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자9이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자9_사번 : "  + rMap2.get("user_cd_9") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strSms9.equals("Y") || strSms9.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자9 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strMail9.equals("Y") || strMail9.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자9 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms9.equals("Y") || strMail9.equals("Y")) ) {
//
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자9의 SMS, MAIL 중 한개는 'Y' 입니다.");
//
//								throw new DefaultServiceException(rMap3);
//							}

							map.put("user_cd_9", 			CommonUtil.isNull(defJobBean9.getUser_cd()));
							map.put("sms_9", 				strSms9);
							map.put("mail_9", 				strMail9);
						} else {
							map.put("user_cd_9", 			"");
							map.put("sms_9", 				"N");
							map.put("mail_9", 				"N");
						}

						if(!CommonUtil.isNull(rMap2.get("user_cd_10")).equals("")){

							rMap2.put("user_id", CommonUtil.isNull(rMap2.get("user_cd_10")));
							DefJobBean defJobBean10 = worksApprovalDocDao.dGetUserCd(rMap2);

							if( defJobBean10 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "담당자10이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 담당자10_사번 : "  + rMap2.get("user_cd_10") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strSms10.equals("Y") || strSms10.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자10 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strMail10.equals("Y") || strMail10.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자10 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strSms10.equals("Y") || strMail10.equals("Y")) ) {
//
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 담당자10의 SMS, MAIL 중 한개는 'Y' 입니다.");
//
//								throw new DefaultServiceException(rMap3);
//							}

							map.put("user_cd_10", 			CommonUtil.isNull(defJobBean10.getUser_cd()));
							map.put("sms_10", 				strSms10);
							map.put("mail_10", 				strMail10);
						} else {
							map.put("user_cd_10", 			"");
							map.put("sms_10", 				"N");
							map.put("mail_10", 				"N");
						}

						//담당자 그룹 체크로직
						if(!CommonUtil.isNull(rMap2.get("grp_nm_1")).equals("")){

							rMap2.put("group_line_grp_nm", CommonUtil.isNull(rMap2.get("grp_nm_1")));
							CommonBean defJobBean11 = worksApprovalDocDao.dGetGroupUserCd(rMap2);

							if( defJobBean11 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "그룹1이 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 그룹1 : "  + rMap2.get("grp_nm_1") );
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strGrpSms1.equals("Y") || strGrpSms1.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 그룹1 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strGrpMail1.equals("Y") || strGrpMail1.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 그룹1 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strGrpSms1.equals("Y") || strGrpMail1.equals("Y")) ) {
//
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 그룹1의 SMS, MAIL 중 한개는 'Y' 입니다.");
//
//								throw new DefaultServiceException(rMap3);
//							}

							map.put("grp_cd_1", 			CommonUtil.isNull(defJobBean11.getGroup_line_grp_cd()));
							map.put("grp_sms_1", 			strGrpSms1);
							map.put("grp_mail_1", 			strGrpMail1);
						} else {
							map.put("grp_cd_1", 			"");
							map.put("grp_sms_1", 			"N");
							map.put("grp_mail_1", 			"N");
						}

						if(!CommonUtil.isNull(rMap2.get("grp_nm_2")).equals("")){

							rMap2.put("group_line_grp_nm", CommonUtil.isNull(rMap2.get("grp_nm_2")));
							CommonBean defJobBean12 = worksApprovalDocDao.dGetGroupUserCd(rMap2);

							if( defJobBean12 == null ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", "그룹2가 존재 하지 않습니다.\\n\\n * " + (idx_row+1)+"번째 열의 그룹2 : "  + rMap2.get("grp_nm_2") );
								throw new DefaultServiceException(rMap3);
							}


							if ( !(strGrpSms2.equals("Y") || strGrpSms2.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 그룹2 SMS 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}

							if ( !(strGrpMail2.equals("Y") || strGrpMail2.equals("N")) ) {
								Map rMap3 = new HashMap();
								rMap3.put("r_code","-2");
								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 그룹2의 MAIL 정보는 'Y','N' 만 가능 합니다.");
								throw new DefaultServiceException(rMap3);
							}
							//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//							if ( !(strGrpSms2.equals("Y") || strGrpMail2.equals("Y")) ) {
//
//								Map rMap3 = new HashMap();
//								rMap3.put("r_code","-2");
//								rMap3.put("r_msg", (idx_row+1)+"번째 열 \\n 그룹2의 SMS, MAIL 중 한개는 'Y' 입니다.");
//
//								throw new DefaultServiceException(rMap3);
//							}

							map.put("grp_cd_2", 			CommonUtil.isNull(defJobBean12.getGroup_line_grp_cd()));
							map.put("grp_sms_2", 			strGrpSms2);
							map.put("grp_mail_2", 			strGrpMail2);
						} else {
							map.put("grp_cd_2", 			"");
							map.put("grp_sms_2", 			"N");
							map.put("grp_mail_2", 			"N");
						}
						
						map.put("flag", 					"one_update_doc");
						map.put("doc_cd", 					r_doc_cd);
						map.put("job", 						rMap2.get("job_name"));
						map.put("description", 				rMap2.get("description"));

						map.put("late_sub", 				rMap2.get("late_sub"));
						map.put("late_time", 				rMap2.get("late_time"));
						map.put("late_exec", 				rMap2.get("late_exec"));

						map.put("batchJobGrade", 			rMap2.get("batchjobGrade"));
						map.put("error_description", 		rMap2.get("error_description"));
						map.put("jobSchedGb", 				rMap2.get("jobSchedGb"));

						map.put("success_sms_yn", 			rMap2.get("success_sms_yn"));
						map.put("cc_count", 				rMap2.get("cc_count"));
						// 정기, 수시 체크
						// 스케줄 정보가 입력 안되면 수시로 간주 (2020.07.20. 강명준)
						if ( CommonUtil.isNull(rMap2.get("month_days")).equals("") && CommonUtil.isNull(rMap2.get("days_cal")).equals("") && CommonUtil.isNull(rMap2.get("week_days")).equals("") && CommonUtil.isNull(rMap2.get("weeks_cal")).equals("")) {
							map.put("jobSchedGb","2");
						} else {
							map.put("jobSchedGb","1");
						}
						System.out.println("::::::::::::::::::::::::::::::::::::::"+map);
						Map rMapMapper 	= worksUserDao.dPrcJobMapper(map);
						
						if( !"1".equals(CommonUtil.isNull(rMapMapper.get("r_code"))) ) throw new DefaultServiceException(rMapMapper);
						
						// flag 원복
						map.put("flag", strFlag);
					}
					
				}
			}else if(strPostApprovalYn.equals("Y")){
				r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"));

				Map rMap3 = new HashMap();
				rMap3.put("doc_cd",		r_doc_cd);
				rMap3.put("SCHEMA", 	CommonUtil.isNull(map.get("SCHEMA")));

				// 결재자 체크해서 모든 결재선이 후결일 경우 API 호출.
				CommonBean bean3 = worksApprovalDocDao.dGetChkPostApprovalLineCnt(rMap3);

				String strPostApprovalCnt = CommonUtil.isNull(bean3.getTotal_count());

				if( Integer.parseInt(strPostApprovalCnt) == 0 ) {
					map.put("doc_cd", r_doc_cd);
					map.put("flag", "post_draft");
					map.put("doc_cnt", "0");
					map.put("group_yn", "N");

					rMap = this.dPrcDocApproval(map);
					r_code = CommonUtil.isNull(rMap.get("r_code"));
					if( !"1".equals(r_code) ) throw new DefaultServiceException(rMap);
				}
			}
		} else {
			throw new DefaultServiceException(rMap);
		}



		
		
		

		logger.info("#T WorksApprovalDocServiceImpl | dPrcDoc06 | End~~~");

		return rMap;
	}
	
	public Map dPrcDoc06Admin(Map map) throws Exception {
		
		Map rMap = null;
		String r_code = "";
		
		rMap = this.dPrcDoc06(map);
		r_code = CommonUtil.isNull(rMap.get("r_code"));
		if( !"1".equals(r_code) ) throw new DefaultServiceException(rMap);
		
		String  r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"));
		map.put("doc_cd", r_doc_cd);
		map.put("approval_cd", "02");
		map.put("approval_seq", "1");		
		
		rMap = this.dPrcDocApproval(map);
		r_code = CommonUtil.isNull(rMap.get("r_code"));
		if( !"1".equals(r_code) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public Doc06Bean dGetDoc06(Map map){
    	return worksApprovalDocDao.dGetDoc06(map);
    }
	
	public List<Doc06Bean> dGetDoc06DetailList(Map map){
		return worksApprovalDocDao.dGetDoc06DetailList(map);
	}

	public List<Doc06Bean> dGetDoc06DetailList2(Map map){
		return worksApprovalDocDao.dGetDoc06DetailList2(map);
	}

	public List<Doc01Bean> dGetDocSetList(Map map){
		return worksApprovalDocDao.dGetDocSetList(map);
	}
	
	public CommonBean dGetActiveGroupJobListCnt(Map map){
		return worksApprovalDocDao.dGetActiveGroupJobListCnt(map);
	}
	public List<ActiveJobBean> dGetActiveGroupJobList(Map map){
		return worksApprovalDocDao.dGetActiveGroupJobList(map);
	}

	public Doc01Bean dGetGroupDocInfo(Map map){
		return worksApprovalDocDao.dGetGroupDocInfo(map);
	}

	public CommonBean dGetMainDocInfoListCnt(Map map){
		return worksApprovalDocDao.dGetMainDocInfoListCnt(map);
	}
	public List<DocInfoBean> dGetMainDocInfoList(Map map){
		
		CommonBean commonBean 		= emBatchResultTotalDao.dGetDataCenterInfo(map);
		String strActiveNetName 	= CommonUtil.isNull(commonBean.getActive_net_name());
		map.put("active_net_name", 	strActiveNetName);
		
		return worksApprovalDocDao.dGetMainDocInfoList(map);
	}
	public List<DocInfoBean> dGetMainDocInfoList2(Map map){

		CommonBean commonBean 		= emBatchResultTotalDao.dGetDataCenterInfo(map);
		String strActiveNetName 	= CommonUtil.isNull(commonBean.getActive_net_name());
		map.put("active_net_name", 	strActiveNetName);

		return worksApprovalDocDao.dGetMainDocInfoList2(map);
	}

	public Map dPrcUploadTable(Map map) throws Exception {
		
		Map rMap = emJobUploadDao.defUploadJobs(map);
		
		return rMap;
	}
	
	public List<DocInfoBean> dGetApprovalLineInfoList(Map map){
		return worksApprovalDocDao.dGetApprovalLineInfoList(map);
	}
	
	public Map dSchedTableJob(Map map) throws Exception {
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Doc01Bean doc01Bean			= new Doc01Bean();		
		
		String data_center 	= CommonUtil.isNull(map.get("data_center"));
		String table_name 	= CommonUtil.isNull(map.get("table_name"));
		String application 	= CommonUtil.isNull(map.get("application"));
		String group_name 	= CommonUtil.isNull(map.get("group_name"));
		String user_daily 	= CommonUtil.isNull(map.get("user_daily"));
		
		// 중복된 테이블 이름이 있는지 체크.
		CommonBean bean = worksApprovalDocDao.dGetChkSchedTableCnt(map);
		
		if( bean.getTotal_count()>0){
			Map rMap2 = new HashMap();
			rMap2.put("r_code","-1");
			rMap2.put("r_msg","ERROR.42");
			throw new DefaultServiceException(rMap2);
		}
		
		doc01Bean.setTask_type("job");
		doc01Bean.setUser_daily(user_daily);
		doc01Bean.setData_center(data_center);
		doc01Bean.setTable_name(table_name);
		doc01Bean.setApplication(application);
		doc01Bean.setGroup_name(group_name);
		doc01Bean.setJob_name("EZ_"+table_name);
		doc01Bean.setMem_name("test");
		doc01Bean.setMem_lib("test");
		doc01Bean.setOwner("test");
		doc01Bean.setAuthor("test");
		
		// 스케줄 셋팅.
		doc01Bean.setDays_cal(CommonUtil.isNull(map.get("days_cal")));
		doc01Bean.setMonth_days(CommonUtil.isNull(map.get("month_days")));
		doc01Bean.setWeeks_cal(CommonUtil.isNull(map.get("weeks_cal")));
		doc01Bean.setWeek_days(CommonUtil.isNull(map.get("week_days")));
		doc01Bean.setSchedule_and_or(CommonUtil.isNull(map.get("schedule_and_or")));
		doc01Bean.setMonth_1(CommonUtil.isNull(map.get("month_1")));
		doc01Bean.setMonth_2(CommonUtil.isNull(map.get("month_2")));
		doc01Bean.setMonth_3(CommonUtil.isNull(map.get("month_3")));
		doc01Bean.setMonth_4(CommonUtil.isNull(map.get("month_4")));
		doc01Bean.setMonth_5(CommonUtil.isNull(map.get("month_5")));
		doc01Bean.setMonth_6(CommonUtil.isNull(map.get("month_6")));
		doc01Bean.setMonth_7(CommonUtil.isNull(map.get("month_7")));
		doc01Bean.setMonth_8(CommonUtil.isNull(map.get("month_8")));
		doc01Bean.setMonth_9(CommonUtil.isNull(map.get("month_9")));
		doc01Bean.setMonth_10(CommonUtil.isNull(map.get("month_10")));
		doc01Bean.setMonth_11(CommonUtil.isNull(map.get("month_11")));
		doc01Bean.setMonth_12(CommonUtil.isNull(map.get("month_12")));
		doc01Bean.setActive_from(CommonUtil.isNull(map.get("active_from")));
		doc01Bean.setActive_till(CommonUtil.isNull(map.get("active_till")));
		
		doc01Bean.setTable_cnt("0");
		
		map.put("doc01", doc01Bean);
		
		// 작업 신규 등록
		rMap = emJobDefinitionDao.prcDefCreateJobs(map);
		
		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		if( !"1".equals(rCode)){
			rMap.put("r_code", "-2");
			throw new DefaultServiceException(rMap);
		}else{
			Doc01Bean docBean		= (Doc01Bean)map.get("doc01");
			
			map.put("data_center", docBean.getData_center());
			map.put("table_name", docBean.getTable_name());
			map.put("job_name", docBean.getJob_name());
			
			emJobUploadDao.defUploadJobs(map);
			
			rMap.put("r_code", "1");
			rMap.put("r_msg", "DEBUG.03");
		}
		
		return rMap;
	}

	public List<DefJobBean> dGetQrList(Map map){
		return worksApprovalDocDao.dGetQrList(map);
	}
	
	public Map dQrResource(Map map) throws Exception {
		
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Doc01Bean doc01Bean			= new Doc01Bean();
		
		String strDataCenter 	= CommonUtil.isNull(map.get("data_center"));
		String strFlag		 	= CommonUtil.isNull(map.get("flag"));
		String strQresname 		= CommonUtil.isNull(map.get("qresname"));
		String strQrtotal 		= CommonUtil.isNull(map.get("qrtotal"));
		String strReturnMsg		= "";
		
		String cmd				= "";
		String hostname 		= CommonUtil.isNull(CommonUtil.getHostIp());
		
		// Host 정보 가져오는 서비스.			
		map.put("server_gubun"	, "S");
		
		CommonBean bean = commonDao.dGetHostInfo(map);
		
		String strHost 				= "";
		String strAccessGubun		= "";
		int iPort 					= 0;
		String strUserId 			= "";
		String strUserPw 			= "";
		
		if ( bean != null ) {
		
			strHost 			= CommonUtil.isNull(bean.getNode_id());
			strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
			iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
			strUserId 			= CommonUtil.isNull(bean.getAgent_id());
			strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
		}
		
		String strGubun = "";
		if ( strFlag.equals("ins") ) {
			cmd = "ecaqrtab ADD " + strQresname + " " + strQrtotal;
		} else if ( strFlag.equals("udt") ) {
			cmd = "ecaqrtab UPDATE " + strQresname + " " + strQrtotal;
		} else if ( strFlag.equals("del") ) {
			cmd = "ecaqrtab DELETE " + strQresname;
		}
		
		if(!"".equals(strHost)){
			
			if ( hostname.toUpperCase().indexOf(strDataCenter.toUpperCase()) > -1 ) {
				
				Process proc 					= null;
				InputStream inputStream 		= null;
				BufferedReader bufferedReader 	= null;
				String[] cmd2					= null;
				String osName 					= System.getProperty("os.name");
				
				if(osName.toLowerCase().startsWith("window")) {
					cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
				} else {
					cmd2 = new String[] { "/bin/sh", "-c", cmd };
				}
				
				proc = Runtime.getRuntime().exec(cmd2);			
				inputStream = proc.getInputStream();
				bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
				
				String line 		= "";
				
				while (( line = bufferedReader.readLine()) != null ) {
					strReturnMsg += line;
					//strReturnMsg += (line + "<br>");				
				}
				
				bufferedReader.close();
				inputStream.close();
				
			} else {
				
				if( "S".equals(strAccessGubun) ){
					Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
					System.out.println("Ssh2Util OK.");
					strReturnMsg = su.getOutput();
				}else{
					TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
					System.out.println("TelnetUtil OK.");
					strReturnMsg = tu.getOutput();
				}
			}
		}
		
		
		// 리턴 값에 홑따옴표 있으면 따로 처리 해줘야 함.
		strReturnMsg = strReturnMsg.replaceAll("\'", "\\\\'");
		
		System.out.println("strReturnMsg : " + strReturnMsg);
		
		rMap.put("r_code", "1");
		rMap.put("r_msg", strReturnMsg);
		
		return rMap;
	}

	@Override
	public Map dPrcDoc09(Map map) throws Exception {

		Map rMap = null;

		rMap = worksApprovalDocDao.dPrcDoc09(map);

		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);

		return rMap;
	}

	private boolean emPrcTimeUpdate(Doc09Bean doc09Bean) {
		
//		String strCommand 			= FILE_READ_CMD + filePath;
		Map<String, Object> searhMap = new HashMap<String, Object>();
		searhMap.put("order_id", doc09Bean.getOrder_id());
		searhMap.put("active_net_name", doc09Bean.getActive_net_name());
		JobDefineInfoBean jobDefineInfoBean = popupDefJobDao.dGetAjobInfo(searhMap);
		
		String strTconditionIn = jobDefineInfoBean.getT_conditions_in();
		String strTconditionOut = jobDefineInfoBean.getT_conditions_out();
		String strTset = jobDefineInfoBean.getT_set();
		String[] aTmpT = null;
		
		String strReturnMsg 		= "";
		
		StringBuffer sb 			= new StringBuffer();
		
		try {
			sb.append("ctmpsm -FULLUPDATE " + doc09Bean.getOrder_id());
			if (!doc09Bean.getAfter_time_from().equals("") ) {
				sb.append("\t -TIMEFROM \t" + "'" + doc09Bean.getAfter_time_from() + "' \\" 		+ "\n");
			} else {
				// 시작시간 TIMEFROM을 제거하면 NEWDAY 시간 구해서 밖아준다.
				Map<String,String> map = new HashMap<String,String>();
				map.put("data_center" , doc09Bean.getData_center());
				CtmInfoBean ctmInfoBean = worksApprovalDocDao.dGetEmCommInfo(map);
				String defTimeFrom = ctmInfoBean.getCtm_daily_time().substring(1, 5);
				
				sb.append("\t -TIMEFROM \t" + "'" + defTimeFrom + "' \\" 		+ "\n");
			}
			if (!doc09Bean.getAfter_time_until().equals("") ) {
				sb.append("\t -TIMEUNTIL \t" + "'" + doc09Bean.getAfter_time_until() + "' \\" 		+ "\n");
			}
			
			if (!strTconditionIn.equals("") ) {
				aTmpT = strTconditionIn.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",3);					
					sb.append("\t -INCOND \t" + "'" + aTmpT1[0] + "' '" + aTmpT1[1] + "' '" + aTmpT1[2].toUpperCase() + "' \\" 		+ "\n");
				}
			}
			if (!strTconditionOut.equals("") ) {
				aTmpT = strTconditionOut.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",3);					
					sb.append("\t -OUTCOND \t" + "'" + aTmpT1[0] + "' '" + aTmpT1[1] + "' '" + aTmpT1[2].toUpperCase() + "' \\" 		+ "\n");
				}
			}
			
			if (!strTset.equals("") ) {
				aTmpT = strTset.split("[|]");
				
				for ( int t = 0; null != aTmpT && t < aTmpT.length; t++ ) {
					String[] aTmpT1 = aTmpT[t].split(",",2);
					
					sb.append("\t -AUTOEDIT \t" + "'%%" + aTmpT1[0] + "' '" + aTmpT1[1] + "' \\" 		+ "\n");
				}
			}
			
			String cmd = sb.toString();
			String hostname = CommonUtil.isNull(CommonUtil.getHostIp());
			
			// Host 정보 가져오는 서비스.
			Map<String,String> map = new HashMap<String,String>();
			map.put("server_gubun"	, "S");
			
			CommonBean bean = commonDao.dGetHostInfo(map);
			
			String strHost 				= "";
			String strAccessGubun		= "";
			int iPort 					= 0;
			String strUserId 			= "";
			String strUserPw 			= "";
			
			if ( bean != null ) {
				
				strHost 			= CommonUtil.isNull(bean.getNode_id());
				strAccessGubun		= CommonUtil.isNull(bean.getAccess_gubun());
				iPort 				= Integer.parseInt(CommonUtil.isNull(bean.getAccess_port()));
				strUserId 			= CommonUtil.isNull(bean.getAgent_id());
				strUserPw 			= SeedUtil.decodeStr(CommonUtil.isNull(bean.getAgent_pw()));
			}
			
			if(!"".equals(strHost)){
				if ( hostname.toUpperCase().indexOf(doc09Bean.getData_center().toUpperCase()) > -1 ) {
					
					Process proc 					= null;
					InputStream inputStream 		= null;
					BufferedReader bufferedReader 	= null;
					String[] cmd2					= null;
					String osName 					= System.getProperty("os.name");
					
					if(osName.toLowerCase().startsWith("window")) {
						cmd2 = new String[] { "cmd.exe", "/y", "/c", cmd };
					} else {
						cmd2 = new String[] { "/bin/sh", "-c", cmd };
					}
					
					proc = Runtime.getRuntime().exec(cmd2);			
					inputStream = proc.getInputStream();
					bufferedReader = new BufferedReader( new InputStreamReader( inputStream, "UTF-8"));
					
					String line 		= "";
					
					while (( line = bufferedReader.readLine()) != null ) {
						strReturnMsg += line;
						//strReturnMsg += (line + "<br>");				
					}
					
					bufferedReader.close();
					inputStream.close();
					
				} else {
					
					if( "S".equals(strAccessGubun) ){
						Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
						System.out.println("Ssh2Util OK.");
						strReturnMsg = su.getOutput();
					}else{
						TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);
						System.out.println("TelnetUtil OK.");
						strReturnMsg = tu.getOutput();
					}
				}
			}
			
			if (strReturnMsg.indexOf("has been saved successfully") > -1) {
				return true;
			} else {
				return false;
			}
			
		} catch(Exception e) {
			return false;
		}
		
	}

	@Override
	public List<Doc02Bean> dGetDoc02List2(Map<String, Object> map) {

		return worksApprovalDocDao.dGetDoc02List2(map);
	}
	
	@Override
	public List<Doc02Bean> dGetDoc02JobList2(Map<String, Object> map) {
		
		return worksApprovalDocDao.dGetDoc02JobList2(map);
	}

	@Override
	public Map<String, Object> dPrcReRunDoc(Map<String, Object> map) {
		String doc_cd = CommonUtil.isNull(map.get("doc_cd"));
		String seq = CommonUtil.isNull(map.get("seq"));
		int chk_cnt = 0;
		Map<String, Object> rMap = new HashMap<>();
		
		try{
			
			String [] arr_doc_cd = doc_cd.split("[|]");
			String [] arr_seq = seq.split("[|]");
			
			for(int i = 0; i<arr_doc_cd.length; i++){
				String v_doc_cd = CommonUtil.isNull(arr_doc_cd[i]);
				String v_seq = CommonUtil.isNull(arr_seq[i]);
				map.put("doc_cd", v_doc_cd);
				map.put("seq", v_seq);
				
				chk_cnt += worksApprovalDocDao.dPrcReRunDoc(map);
			
				
			}
			
			rMap.put("r_code", 	"1");
			rMap.put("chk_cnt", chk_cnt);
			rMap.put("r_msg", 	"DEBUG.01");
			rMap.put("doc_cd", 	CommonUtil.isNull(arr_doc_cd[0]));
			
			
		}catch(Exception e){
			rMap.put("r_code", "-1");
			rMap.put("r_msg","ERROR.01");
			rMap.put("doc_cd", "");
			
		}
	
		return rMap;
	}	
	
	public Map dPrcDocApprovalStateUpdate(Map map) throws Exception {

		CommonBean commonBean 		= emBatchResultTotalDao.dGetDataCenterInfo(map);
		String strActiveNetName 	= CommonUtil.isNull(commonBean.getActive_net_name());
		map.put("active_net_name", 	strActiveNetName);
		
		// 일괄요청서 메인 외의 요청서를 클릭했을 경우 가장 처음 처리하기 위해.
		// 화면에서 받아온 파라미터 처리 때문에.		
		map.put("order", "1");
		List mainDocInfoList = worksApprovalDocDao.dGetMainDocInfoList(map);
		
		//map.put("order", "2");
		//List mainDocInfoList2 = worksApprovalDocDao.dGetMainDocInfoList(map);
		
		//mainDocInfoList.addAll(mainDocInfoList2);
		
		if ( mainDocInfoList.size() == 0 ) {
			map.put("order", "");
			map.put("doc_cnt", "1");
			mainDocInfoList = worksApprovalDocDao.dGetMainDocInfoList(map);	
		}
		
		String strTaskType			= CommonUtil.isNull(map.get("task_type"));
		String strDataCenter		= CommonUtil.isNull(map.get("data_center"));
		String strTableName			= CommonUtil.isNull(map.get("table_name"));
		String strFlag				= CommonUtil.isNull(map.get("flag"));
		//String doc_gb				= CommonUtil.isNull(map.get("doc_gb"));
		String strPostApprovalYn	= CommonUtil.isNull(map.get("post_approval_yn"));
		String strPostApprovalEnd	= CommonUtil.isNull(map.get("post_approval_end"));
		
		StringBuffer upload_sb		= new StringBuffer();
		
		String r_code				= "";
		String r_state_cd			= "";
		
		Map rMap = null;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
				
		StringBuffer sb 	= new StringBuffer();
		
		for ( int j = 0; j < mainDocInfoList.size(); j++ ) {
			
			DocInfoBean docInfoBean = (DocInfoBean)mainDocInfoList.get(j);
			
			String doc_gb 			= CommonUtil.isNull(docInfoBean.getDoc_gb());
			String doc_cd 			= CommonUtil.isNull(docInfoBean.getDoc_cd());
			String strTableId	 	= CommonUtil.isNull(docInfoBean.getTable_id());
			String strJobId		 	= CommonUtil.isNull(docInfoBean.getJob_id());
			String strJobName	 	= CommonUtil.isNull(docInfoBean.getJob_name());
			
			map.put("doc_cd", 		doc_cd);
			map.put("table_id", 	strTableId);
			map.put("job_id",	 	strJobId);
			map.put("job_name",	 	strJobName);
			
			rMap = worksApprovalDocDao.dPrcDocApproval(map);
		}
		return rMap;
	}

	public Map dPrcMyWork(Map map){
		return worksApprovalDocDao.dPrcMyWork(map);
	}
	public CommonBean dGetInsUserMail(Map map){
		return worksApprovalDocDao.dGetInsUserMail(map);
	}
	public CommonBean dGetApprovalUserMail(Map map){
		return worksApprovalDocDao.dGetApprovalUserMail(map);
	}
	public List<CommonBean> dGetApprovalAdminGroupMailList(Map map){
		return worksApprovalDocDao.dGetApprovalAdminGroupMailList(map);
	}
	
	public Map dPrcDocApprovalFlagUpdate(Map map) throws Exception {
	
		Map rMap = null;
		
		rMap = worksApprovalDocDao.dPrcDocApproval(map);		
		return rMap;
	}
	
	public CommonBean dGetDocApprovalStartCnt(Map map){
		return worksApprovalDocDao.dGetDocApprovalStartCnt(map);
	}

	public CommonBean dGetDocApprovalStartChk(Map map){
		return worksApprovalDocDao.dGetDocApprovalStartChk(map);
	}

	public CommonBean dGetCurApprovalCnt(Map map){
    	return worksApprovalDocDao.dGetCurApprovalCnt(map);
    }
	
	public Map deleteCondition(Map map) throws Exception {
		
		int rtn = 0;
		// 해당 작업의 발행 컨디션을 제거 후 CREATION.
		String strCondition = CommonUtil.isNull(map.get("condition"));
		String strOdate     = CommonUtil.isNull(map.get("odate"));
		Map<String, Object> rMap = new HashMap<String, Object>();
		String[] condition = strCondition.split(",");
		String[] odate = strOdate.split(",");
		
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String strUserToken = "";

		CommonUtil.emLogin(request);
		strUserToken = CommonUtil.isNull(request.getSession().getAttribute("USER_TOKEN"));
		
		map.put("userToken", CommonUtil.isNull(strUserToken));

		for(int i=0; i<condition.length; i++) {
			map.put("condition", condition[i]);
			map.put("odate", odate[i]);
			
			rMap = emDeleteConditionDao.deleteCondition(map);
			if(!"1".equals(CommonUtil.isNull(rMap.get("rCode")))) {
				logger.error("deleteCondition FAIL");
				rMap.put("r_code", "-1");
				rMap.put("r_msg", CommonUtil.getMessage("ERROR.01"));
				throw new DefaultServiceException(rMap);
			}
			
			// 발행컨디션 삭제이력 저장
			map.put("flag", "cond_log");
			map.put("send_gubun", "DEL");
			map.put("t_conditions_in", condition[i]);
			map.put("odate", odate[i]);
			commonDao.dPrcLog(map);
		}
		
		
		map.put("r_code", "1");
		rMap.put("r_msg", CommonUtil.getMessage("DEBUG.01"));
		
		return map;
	}
	
	//Forcast(일별오더목록) 결재요청.
	public Map dPrcDoc08(Map map) throws Exception {
			
		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Map<String, Object> ArrMap 	= new HashMap<String, Object>();
		
		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		String strPostApprovalYn	= CommonUtil.isNull(map.get("post_approval_yn"));
		String strTitle				= CommonUtil.isNull(map.get("title"));
		String s_user_gb 			= CommonUtil.isNull(map.get("s_user_gb"));
		
		String strPostApprovalCnt	= "";
		logger.info("#WorksApprovalDocServiceImpl | dPrcDoc08 | post_approval_yn : " + strPostApprovalYn);
		
		// 작업 오더 시 삭제/수정 요청서[미결]가 존재하면 불가
		//CommonBean bean = worksApprovalDocDao.dGetChkApprovalDocDelCnt(map);
		
		
		//if( bean.getTotal_count() > 0 ) {
		//	Map rMap2_return = new HashMap();
		//	rMap2_return.put("r_code","-1");
		//	rMap2_return.put("r_msg","ERROR.44");
		//	throw new DefaultServiceException(rMap2_return);
		//}
		
		logger.info("#WorksApprovalDocServiceImpl | dPrcDoc08 Proc Start~~~~~~");
		
		String job_name[]			= CommonUtil.isNull(map.get("job_name")).split(",");
		String table_name[]			= CommonUtil.isNull(map.get("table_name")).split(",");
		String application[]		= CommonUtil.isNull(map.get("application")).split(",");
		String group_name[]			= CommonUtil.isNull(map.get("group_name")).split(",");
		String odate[]	 			= CommonUtil.isNull(map.get("order_date")).split(",");
		String data_center_name[]	= CommonUtil.isNull(map.get("data_center_name")).split(",");
		String description[] 		= CommonUtil.isNull(map.get("description")).split(",");
		String order_id[] 			= CommonUtil.isNull(map.get("order_id")).split(",");

		for(int i=0; i<job_name.length; i++ ){

			String strJobName = CommonUtil.isNull(job_name[i]);
			
			String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
			// 후결 시간 체크
			//String bPostApprovalTimeCheckMent = CommonUtil.checkPostApprovalTimeCheck(strDataCenter);

			if(job_name.length > 0 && !job_name[i].equals(""))					ArrMap.put("job_name", 				job_name[i]);
			if(table_name.length > 0 && !table_name[i].equals(""))				ArrMap.put("table_name", 			table_name[i]);
			if(application.length > 0 && !application[i].equals(""))			ArrMap.put("application", 			application[i]);
			if(group_name.length > 0 && !group_name[i].equals(""))				ArrMap.put("group_name", 			group_name[i]);
			if(odate[i].contains("/")) {
				if(odate.length > 0 && !odate[i].equals(""))					ArrMap.put("order_date", 			odate[i].replaceAll("/", ""));
			}else {
				if(odate.length > 0 && !odate[i].equals(""))					ArrMap.put("order_date", 			odate[i]);
			}
			if(data_center_name.length > 0 && !data_center_name[i].equals(""))	ArrMap.put("data_center_name", 		data_center_name[i]);
			if(description.length > 0 && !description[i].equals(""))			ArrMap.put("description", 			description[i]);
			if(order_id.length > 0 && !order_id[i].equals(""))					ArrMap.put("order_id", 			order_id[i]);

			ArrMap.put("group_status", 			CommonUtil.isNull(map.get("group_status")));
			ArrMap.put("from_time", 			CommonUtil.isNull(map.get("from_time")));
			ArrMap.put("e_order_date", 			CommonUtil.isNull(map.get("e_order_date")));
			ArrMap.put("s_user_cd", 			CommonUtil.isNull(map.get("s_user_cd")));
			ArrMap.put("data_center",			CommonUtil.isNull(map.get("data_center")));
			ArrMap.put("s_user_ip", 			CommonUtil.isNull(map.get("s_user_ip")));
			ArrMap.put("SCHEMA", 				CommonUtil.isNull(map.get("SCHEMA")));
			ArrMap.put("force_gubun", 			CommonUtil.isNull(map.get("force_gubun")));
			ArrMap.put("order_cnt", 			CommonUtil.isNull(map.get("order_cnt")));
			ArrMap.put("flag", 					strFlag);
			ArrMap.put("doc_gb", 				CommonUtil.isNull(map.get("doc_gb")));
			ArrMap.put("userToken", 			CommonUtil.isNull(map.get("userToken")));
			ArrMap.put("check_job_names", 		CommonUtil.isNull(map.get("check_job_names")));
			ArrMap.put("check_job_ids", 		CommonUtil.isNull(map.get("check_job_ids")));
			ArrMap.put("check_sched_tables", 	CommonUtil.isNull(map.get("check_sched_tables")));
			ArrMap.put("active_net_name", 		CommonUtil.isNull(map.get("active_net_name")));
			ArrMap.put("data_center_code", 		CommonUtil.isNull(map.get("data_center_code")));
			ArrMap.put("check_table_ids", 		CommonUtil.isNull(map.get("check_table_ids"))); 
			//ArrMap.put("post_approval_time", 	bPostApprovalTimeCheckMent);
			ArrMap.put("title", 				strTitle);
			ArrMap.put("grp_approval_userList", CommonUtil.isNull(map.get("grp_approval_userList")));
			ArrMap.put("grp_alarm_userList", 	CommonUtil.isNull(map.get("grp_alarm_userList")));
			ArrMap.put("post_approval_yn", 		CommonUtil.isNull(map.get("post_approval_yn")));
			
			System.out.println("strFlag : " + strFlag);
			System.out.println("s_user_gb : " + s_user_gb);
			System.out.println("ArrMapArrMapArrMapArrMap : " + ArrMap);
			
//			if((strFlag.equals("insert") || strFlag.equals("insert_post_approval")) && s_user_gb.equals("01")) {
//				String strFolderAuth = "";
//				List authList = worksUserDao.dGetUserAuthList(map);
//				if(authList == null || authList.size() < 1) {
//					rMap.put("r_code","-1");                
//					rMap.put("r_msg","ERROR.57");           
//					throw new DefaultServiceException(rMap);
//				}else {
//					for(int l=0; l<authList.size(); l++) {
//						UserBean userBean = (UserBean) authList.get(l);
//						
//						strFolderAuth += "'"+CommonUtil.isNull(userBean.getFolder_auth())+"',";
//					}
//					strFolderAuth = strFolderAuth.substring(0, strFolderAuth.length()-1);
//					if(strFolderAuth.indexOf(table_name[i]) == -1) {
//						rMap.put("r_code","-1");                
//						rMap.put("r_msg","ERROR.57");           
//						throw new DefaultServiceException(rMap);
//					}
//				}
//			}
			
			// 중복된 잡 이름이 있는지 체크.
			CommonBean ChkBean = worksApprovalDocDao.dGetChkForecastJobCnt(ArrMap);
			
			if( ChkBean.getTotal_count()>0){
				Map rMap2 = new HashMap();
				rMap2.put("r_code","-1");
				rMap2.put("r_msg","ERROR.65");
				throw new DefaultServiceException(rMap2);
			}

			rMap = worksApprovalDocDao.dPrcDoc08(ArrMap);
			
			if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
			
			String r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"));

			// 후결 처리.
			if ( strPostApprovalYn.equals("Y") ) {

				Map rMap3 = new HashMap();
				rMap3.put("doc_cd",		r_doc_cd);
				rMap3.put("SCHEMA", 	CommonUtil.isNull(map.get("SCHEMA")));
				
				// 결재자 체크해서 모든 결재선이 후결일 경우 API 호출.
				CommonBean bean = worksApprovalDocDao.dGetChkPostApprovalLineCnt(rMap3);
				
				strPostApprovalCnt = CommonUtil.isNull(bean.getTotal_count());
				
				System.out.println("strPostApprovalCnt : " + strPostApprovalCnt);
				
				if( Integer.parseInt(strPostApprovalCnt) == 0 ) {
				
					map.put("doc_cd", 		r_doc_cd);
					map.put("flag", 		strFlag);
					map.put("table_name", 	table_name[i]);
					map.put("table_name", table_name[i]);
					
					rMap = this.dPrcDocApproval(map);
					
					String r_code = CommonUtil.isNull(rMap.get("r_code"));
					if( !"1".equals(r_code) ) throw new DefaultServiceException(rMap);
				}
			}

			logger.info("#WorksApprovalDocServiceImpl | dPrcDoc08 Proc End ~~~~~~`");
		}
		
		return rMap;
	}
		
	public Map dPrcDoc08Admin(Map map) throws Exception {

		Map<String, Object> rMap 	= new HashMap<String, Object>();
		Map<String, Object> ArrMap 	= new HashMap<String, Object>();
		
		String strFlag 				= CommonUtil.isNull(map.get("flag"));
		String strPostApprovalYn	= CommonUtil.isNull(map.get("post_approval_yn"));
		String strTitle				= CommonUtil.isNull(map.get("title"));
		String s_user_gb 			= CommonUtil.isNull(map.get("s_user_gb"));

		logger.info("#WorksApprovalDocServiceImpl | dPrcDoc08admin Proc Start~~~~~~");
		
		String job_name[]			= CommonUtil.isNull(map.get("job_name")).split(",");
		String table_name[]			= CommonUtil.isNull(map.get("table_name")).split(",");
		String application[]		= CommonUtil.isNull(map.get("application")).split(",");
		String group_name[]			= CommonUtil.isNull(map.get("group_name")).split(",");
		String odate[]	 			= CommonUtil.isNull(map.get("order_date")).split(",");
		String data_center_name[]	= CommonUtil.isNull(map.get("data_center_name")).split(",");
		String description[] 		= CommonUtil.isNull(map.get("description")).split(",");
		String order_id[] 			= CommonUtil.isNull(map.get("order_id")).split(",");
		
		String doc_cds 				= "";

		for(int i=0; i<job_name.length; i++ ){

			String strJobName = CommonUtil.isNull(job_name[i]);
			
			String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));

			if(job_name.length > 0 && !job_name[i].equals(""))					ArrMap.put("job_name", 				job_name[i]);
			if(table_name.length > 0 && !table_name[i].equals(""))				ArrMap.put("table_name", 			table_name[i]);
			if(application.length > 0 && !application[i].equals(""))			ArrMap.put("application", 			application[i]);
			if(group_name.length > 0 && !group_name[i].equals(""))				ArrMap.put("group_name", 			group_name[i]);
			if(odate[i].contains("/")) {
				if(odate.length > 0 && !odate[i].equals(""))					ArrMap.put("order_date", 			odate[i].replaceAll("/", ""));
			}else {
				if(odate.length > 0 && !odate[i].equals(""))					ArrMap.put("order_date", 			odate[i]);
			}
			if(data_center_name.length > 0 && !data_center_name[i].equals(""))	ArrMap.put("data_center_name", 		data_center_name[i]);
			if(description.length > 0 && !description[i].equals(""))			ArrMap.put("description", 			description[i]);
			if(order_id.length > 0 && !order_id[i].equals(""))					ArrMap.put("order_id", 			order_id[i]);

			ArrMap.put("group_status", 			CommonUtil.isNull(map.get("group_status")));
			ArrMap.put("from_time", 			CommonUtil.isNull(map.get("from_time")));
			ArrMap.put("e_order_date", 			CommonUtil.isNull(map.get("e_order_date")));
			ArrMap.put("s_user_cd", 			CommonUtil.isNull(map.get("s_user_cd")));
			ArrMap.put("data_center",			CommonUtil.isNull(map.get("data_center")));
			ArrMap.put("s_user_ip", 			CommonUtil.isNull(map.get("s_user_ip")));
			ArrMap.put("SCHEMA", 				CommonUtil.isNull(map.get("SCHEMA")));
			ArrMap.put("force_gubun", 			CommonUtil.isNull(map.get("force_gubun")));
			ArrMap.put("order_cnt", 			CommonUtil.isNull(map.get("order_cnt")));
			ArrMap.put("flag", 					strFlag);
			ArrMap.put("doc_gb", 				CommonUtil.isNull(map.get("doc_gb")));
			ArrMap.put("userToken", 			CommonUtil.isNull(map.get("userToken")));
			ArrMap.put("check_job_names", 		CommonUtil.isNull(map.get("check_job_names")));
			ArrMap.put("check_job_ids", 		CommonUtil.isNull(map.get("check_job_ids")));
			ArrMap.put("check_sched_tables", 	CommonUtil.isNull(map.get("check_sched_tables")));
			ArrMap.put("active_net_name", 		CommonUtil.isNull(map.get("active_net_name")));
			ArrMap.put("data_center_code", 		CommonUtil.isNull(map.get("data_center_code")));
			ArrMap.put("check_table_ids", 		CommonUtil.isNull(map.get("check_table_ids"))); 
			//ArrMap.put("post_approval_time", 	bPostApprovalTimeCheckMent);
			ArrMap.put("title", 				strTitle);
			ArrMap.put("grp_approval_userList", CommonUtil.isNull(map.get("grp_approval_userList")));
			ArrMap.put("grp_alarm_userList", 	CommonUtil.isNull(map.get("grp_alarm_userList")));
			ArrMap.put("post_approval_yn", 		CommonUtil.isNull(map.get("post_approval_yn")));
			
			System.out.println("strFlag : " + strFlag);
			System.out.println("s_user_gb : " + s_user_gb);
			System.out.println("ArrMapArrMapArrMapArrMap : " + ArrMap);		
			
			// 중복된 잡 이름이 있는지 체크.
			CommonBean ChkBean = worksApprovalDocDao.dGetChkForecastJobCnt(ArrMap);
			
			if( ChkBean.getTotal_count()>0){
				Map rMap2 = new HashMap();
				rMap2.put("r_code","-1");
				rMap2.put("r_msg","ERROR.65");
				throw new DefaultServiceException(rMap2);
			}

			rMap = worksApprovalDocDao.dPrcDoc08(ArrMap);
			
			if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
			
			String r_doc_cd = CommonUtil.isNull(rMap.get("r_doc_cd"));
			
			//반영 대기로 처리
			map.put("doc_cd", 		r_doc_cd);
			map.put("flag", 		"doc08_admin");
			map.put("apply_check", 	"01");
			worksApprovalDocDao.dPrcDocApproval(map);
		}
		
		return rMap;
		
	}
	
	//업무그룹 등록&삭제
	public Map dPrcWorkGroup(Map map) throws Exception {
		
		Map rMap = null;
		
		String strFlag 	= CommonUtil.isNull(map.get("flag"));
		
		if ( strFlag.equals("detail_delete") || strFlag.equals("detail_insert") ) {
			String strCheckFolderNames 	= CommonUtil.isNull(map.get("check_folder_names"));
			String arrstrCheckFolderName[] = CommonUtil.isNull(strCheckFolderNames).split(",");
			
			for ( int z = 0; z < arrstrCheckFolderName.length; z++) {
				map.put("grp_eng_nm"		, arrstrCheckFolderName[z]);
				rMap = worksApprovalDocDao.dPrcWorkGroup(map);
			}
			
		} else if ( strFlag.equals("group_delete") || strFlag.equals("group_insert") || strFlag.equals("group_update") ) {
			
			rMap = worksApprovalDocDao.dPrcWorkGroup(map);
		}
		
		if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
		
		return rMap;
	}
	
	public CommonBean dGetWorkGroupDetail(Map map){
		return worksApprovalDocDao.dGetWorkGroupDetail(map);
	}
	
	public List<DefJobBean> dGetFolderGroupList(Map map){
    	return worksApprovalDocDao.dGetFolderGroupList(map);
    }
	
	public DocInfoBean dGetChkApprovalStatus(Map map){
		return worksApprovalDocDao.dGetChkApprovalStatus(map);
	}

	public DocInfoBean dGetApprovalNotiInfo(Map map){
		return worksApprovalDocDao.dGetApprovalNotiInfo(map);
	}

	public CommonBean dGetDocApprovalAlreadyCnt(Map map){ return worksApprovalDocDao.dGetDocApprovalAlreadyCnt(map); }
	//담당자엑셀일괄변경
	public Map dPrcExcelUserChange(Map map) throws Exception {
		Map<String, Object> rMap = new HashMap<String, Object>();
		
		String change_user = CommonUtil.isNull(map.get("change_user_list"));
		if(!change_user.equals("")) {
			String[] split_excel_data = change_user.split("[|]");
			System.out.println("split_excel_data.length ::: " + split_excel_data.length);
 			for(int i = 0; i < split_excel_data.length; i++) {
 				int n = 0;
 				Map<String, Object> rMap2 = new HashMap<String, Object>();
 				rMap2.put("SCHEMA", CommonUtil.isNull(map.get("SCHEMA")));
 				String[] items = split_excel_data[i].split("★", -1);
 				
 				String data_center = CommonUtil.isNull(map.get("data_center"));
 				
 				String strJobName = items[n++];
 				
 				String strAuthor  = items[n++];
 				String strSms1    = items[n++];
 				String strMail1   = items[n++];
 				
 				String strUserId2 = items[n++];
 				String strSms2    = items[n++];
 				String strMail2   = items[n++];
 				
 				String strUserId3 = items[n++];
 				String strSms3    = items[n++];
 				String strMail3   = items[n++];
 				
 				String strUserId4 = items[n++];
 				String strSms4    = items[n++];
 				String strMail4   = items[n++];
 				
 				String strUserId5 = items[n++];
 				String strSms5    = items[n++];
 				String strMail5   = items[n++];
 				
 				String strUserId6 = items[n++];
 				String strSms6    = items[n++];
 				String strMail6   = items[n++];
 				
 				String strUserId7 = items[n++];
 				String strSms7    = items[n++];
 				String strMail7   = items[n++];
 				
 				String strUserId8 = items[n++];
 				String strSms8    = items[n++];
 				String strMail8   = items[n++];
 				
 				String strUserId9 = items[n++];
 				String strSms9    = items[n++];
 				String strMail9   = items[n++];
 				
 				String strUserId10 = items[n++];
 				String strSms10    = items[n++];
 				String strMail10   = items[n++];
 				
 				String strGrpNm1   = items[n++];
 				String strGrpSms1  = items[n++];
 				String strGrpMail1 = items[n++];
 				
 				String strGrpNm2   = items[n++];
 				String strGrpSms2  = items[n++];
 				String strGrpMail2 = items[n++];
 				
 				rMap.put("flag", CommonUtil.isNull(map.get("flag")));
 				rMap.put("SCHEMA", CommonUtil.isNull(map.get("SCHEMA")));
 				rMap.put("data_center", data_center);
 				
 				//작업명
				if( !strJobName.equals("") ){
					rMap.put("job", strJobName);
				}else {
					Map rMap3 = new HashMap();
					rMap3.put("r_code","-2");
					rMap3.put("r_msg", (i+1)+"번째 열 \\n작업명은 필수 입니다.");
					
					throw new DefaultServiceException(rMap3);
				}
				
				if(!strAuthor.equals("")) {
					rMap2.put("user_id", strAuthor);
					DefJobBean defJobBean = worksApprovalDocDao.dGetUserCd(rMap2);
					
					if( defJobBean  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자_사번은 존재 하지 않습니다.\\n" + (i+1)+"번째 열의 담당자_사번 : "  + strAuthor);
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms1.equals("Y") || strSms1.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail1.equals("Y") || strMail1.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms1.equals("Y") || strMail1.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자의 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_1", 			CommonUtil.isNull(defJobBean.getUser_cd()));
					rMap.put("sms_1", 				strSms1);
					rMap.put("mail_1", 				strMail1);
				}else {
					Map rMap3 = new HashMap();
					rMap3.put("r_code","-2");
					rMap3.put("r_msg", (i+1)+"번째 열 담당자(사번)는 필수 입니다.");
					
					throw new DefaultServiceException(rMap3);	
				}
				
				//담당자2 
				if(!strUserId2.equals("")){
					
					rMap2.put("user_id", strUserId2);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자2_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자2_사번 : "  + strUserId2 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms2.equals("Y") || strSms2.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자2 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail2.equals("Y") || strMail2.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자2 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms2.equals("Y") || strMail2.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자2 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_2", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_2", 				strSms2);
					rMap.put("mail_2", 				strMail2);
				} else {
					rMap.put("user_cd_2", 			"");
					rMap.put("sms_2", 				"");
					rMap.put("mail_2", 				"");
				}
				
				//담당자3
				if(!strUserId3.equals("")){
					
					rMap2.put("user_id", strUserId3);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자3_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자3_사번 : "  + strUserId3 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms3.equals("Y") || strSms3.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자3 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail3.equals("Y") || strMail3.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자3 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms3.equals("Y") || strMail3.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자3 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_3", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_3", 				strSms3);
					rMap.put("mail_3", 				strMail3);
				} else {
					rMap.put("user_cd_3", 			"");
					rMap.put("sms_3", 				"");
					rMap.put("mail_3", 				"");
				}
				
				// 담당자4
				if(!strUserId4.equals("")){
					
					rMap2.put("user_id", strUserId4);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자4_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자4_사번 : "  + strUserId4 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms4.equals("Y") || strSms4.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자4 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail4.equals("Y") || strMail4.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자4 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms4.equals("Y") || strMail4.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자4 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_4", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_4", 				strSms4);
					rMap.put("mail_4", 				strMail4);
				} else {
					rMap.put("user_cd_4", 			"");
					rMap.put("sms_4", 				"");
					rMap.put("mail_4", 				"");
				}
				
				//담당자5
				if(!strUserId5.equals("")){
					
					rMap2.put("user_id", strUserId5);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자5_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자5_사번 : "  + strUserId5 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms5.equals("Y") || strSms5.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자5 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail5.equals("Y") || strMail5.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자5 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms5.equals("Y") || strMail5.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자5 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_5", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_5", 				strSms5);
					rMap.put("mail_5", 				strMail5);
				} else {
					rMap.put("user_cd_5", 			"");
					rMap.put("sms_5", 				"");
					rMap.put("mail_5", 				"");
				}
				
				//담당자6
				if(!strUserId6.equals("")){
					
					rMap2.put("user_id", strUserId6);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자6_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자6_사번 : "  + strUserId6 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms6.equals("Y") || strSms6.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자6 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail6.equals("Y") || strMail6.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자6 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms6.equals("Y") || strMail6.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자6 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_6", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_6", 				strSms6);
					rMap.put("mail_6", 				strMail6);
				} else {
					rMap.put("user_cd_6", 			"");
					rMap.put("sms_6", 				"");
					rMap.put("mail_6", 				"");
				}
				
				//담당자7
				if(!strUserId7.equals("")){
					
					rMap2.put("user_id", strUserId7);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자7_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자7_사번 : "  + strUserId7 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms7.equals("Y") || strSms7.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자7 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail7.equals("Y") || strMail7.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자7 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
//					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms7.equals("Y") || strMail7.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자7 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_7", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_7", 				strSms7);
					rMap.put("mail_7", 				strMail7);
				} else {
					rMap.put("user_cd_7", 			"");
					rMap.put("sms_7", 				"");
					rMap.put("mail_7", 				"");
				}
				
				//담당자8
				if(!strUserId8.equals("")){
					
					rMap2.put("user_id", strUserId8);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자8_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자8_사번 : "  + strUserId8 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms8.equals("Y") || strSms8.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자8 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail8.equals("Y") || strMail8.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자8 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms8.equals("Y") || strMail8.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자8 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_8", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_8", 				strSms8);
					rMap.put("mail_8", 				strMail8);
				} else {
					rMap.put("user_cd_8", 			"");
					rMap.put("sms_8", 				"");
					rMap.put("mail_8", 				"");
				}
				
				//담당자9
				if(!strUserId9.equals("")){
					
					rMap2.put("user_id", strUserId9);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자9_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자9_사번 : "  + strUserId9 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms9.equals("Y") || strSms9.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자9 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail9.equals("Y") || strMail9.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자9 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms9.equals("Y") || strMail9.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자9 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_9", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_9", 				strSms9);
					rMap.put("mail_9", 				strMail9);
				} else {
					rMap.put("user_cd_9", 			"");
					rMap.put("sms_9", 				"");
					rMap.put("mail_9", 				"");
				}
				
				//담당자10
				if(!strUserId10.equals("")){
					
					rMap2.put("user_id", strUserId10);
					DefJobBean defJobBean2 = worksApprovalDocDao.dGetUserCd(rMap2);
	
					if( defJobBean2  == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "담당자10_사번은 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 담당자10_사번 : "  + strUserId10 );
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strSms10.equals("Y") || strSms10.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자10 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					
					if ( !(strMail10.equals("Y") || strMail10.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자10 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strSms10.equals("Y") || strMail10.equals("Y")) ) {
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 담당자10 SMS, MAIL 중 한개는 'Y' 입니다.");
//						throw new DefaultServiceException(rMap3);
//					}
					
					rMap.put("user_cd_10", 			CommonUtil.isNull(defJobBean2.getUser_cd()));
					rMap.put("sms_10", 				strSms10);
					rMap.put("mail_10", 			strMail10);
				} else {
					rMap.put("user_cd_10", 			"");
					rMap.put("sms_10", 				"");
					rMap.put("mail_10", 			"");
				}
				
				//담당자 그룹 체크로직
				if(!strGrpNm1.equals("")){

					rMap2.put("group_line_grp_nm", strGrpNm1);
					CommonBean defJobBean11 = worksApprovalDocDao.dGetGroupUserCd(rMap2);

					if( defJobBean11 == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "그룹1이 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 그룹1 : "  + strGrpNm1 );
						throw new DefaultServiceException(rMap3);
					}

					if ( !(strGrpSms1.equals("Y") || strGrpSms1.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 그룹1 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}

					if ( !(strGrpMail1.equals("Y") || strGrpMail1.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 그룹1 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strGrpSms1.equals("Y") || strGrpMail1.equals("Y")) ) {
//
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 그룹1의 SMS, MAIL 중 한개는 'Y' 입니다.");
//
//						throw new DefaultServiceException(rMap3);
//					}

					rMap.put("grp_cd_1", 			CommonUtil.isNull(defJobBean11.getGroup_line_grp_cd()));
					rMap.put("grp_sms_1", 			strGrpSms1);
					rMap.put("grp_mail_1", 			strGrpMail1);
				} else {
					rMap.put("grp_cd_1", 			"");
					rMap.put("grp_sms_1", 			"N");
					rMap.put("grp_mail_1", 			"N");
				}

				if(!strGrpNm2.equals("")){

					rMap2.put("group_line_grp_nm", strGrpNm2);
					CommonBean defJobBean12 = worksApprovalDocDao.dGetGroupUserCd(rMap2);

					if( defJobBean12 == null ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", "그룹2가 존재 하지 않습니다.\\n\\n * " + (i+1)+"번째 열의 그룹2 : "  + strGrpNm2);
						throw new DefaultServiceException(rMap3);
					}


					if ( !(strGrpSms2.equals("Y") || strGrpSms2.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 그룹2 SMS 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}

					if ( !(strGrpMail2.equals("Y") || strGrpMail2.equals("N")) ) {
						Map rMap3 = new HashMap();
						rMap3.put("r_code","-2");
						rMap3.put("r_msg", (i+1)+"번째 열 \\n 그룹2의 MAIL 정보는 'Y','N' 만 가능 합니다.");
						throw new DefaultServiceException(rMap3);
					}
					//2024.02.26 최호연 담당자 SMS,MAIL 체크로직 제거
//					if ( !(strGrpSms2.equals("Y") || strGrpMail2.equals("Y")) ) {
//
//						Map rMap3 = new HashMap();
//						rMap3.put("r_code","-2");
//						rMap3.put("r_msg", (i+1)+"번째 열 \\n 그룹2의 SMS, MAIL 중 한개는 'Y' 입니다.");
//
//						throw new DefaultServiceException(rMap3);
//					}

					rMap.put("grp_cd_2", 			CommonUtil.isNull(defJobBean12.getGroup_line_grp_cd()));
					rMap.put("grp_sms_2", 			strGrpSms2);
					rMap.put("grp_mail_2", 			strGrpMail2);
				} else {
					rMap.put("grp_cd_2", 			"");
					rMap.put("grp_sms_2", 			"N");
					rMap.put("grp_mail_2", 			"N");
				}
				
				rMap = worksUserDao.dPrcJobMapper(rMap);
				if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) {
					rMap.put("r_msg", (i+1)+"번째 열 \\n " + CommonUtil.isNull(rMap.get("r_msg")));
					throw new DefaultServiceException(rMap);
				}
			}
		}
		
		return rMap;
	}
	
	// 결재 처리.
	public Map excel_verify(Map map) throws Exception {

		String strDocGb				= CommonUtil.isNull(map.get("doc_gb"));
		String strTaskType			= CommonUtil.isNull(map.get("task_type"));
		String strDataCenter		= CommonUtil.isNull(map.get("data_center"));
		//String strTableName			= CommonUtil.isNull(map.get("table_name"));
		String strFlag				= CommonUtil.isNull(map.get("flag"));
		String strPostApprovalYn	= CommonUtil.isNull(map.get("post_approval_yn"));
		String strPostApprovalEnd	= CommonUtil.isNull(map.get("post_approval_end"));
		String group_approval		= CommonUtil.isNull(map.get("group_approval"));
		String approval_seq			= CommonUtil.isNull(map.get("approval_seq"));
		String strGroupMain			= CommonUtil.isNull(map.get("group_main"));
		String doc_cnt				= CommonUtil.isNull(map.get("doc_cnt"));
		String doc_cd 				= CommonUtil.isNull(map.get("doc_cd"));

		String r_msg				= "";
		String r_code				= "";
		String r_state_cd			= "";
		String r_apply_cd			= "";
		String rMsg					= "";

		String doc_gb				= "";

		String strTableId			= "";
		String strJobId				= "";
		String strJobName			= "";
		String strVJobName			= "";
		String strTableName			= "";
		String strJobgroupId		= "";
		String strMainDocCd			= "";
		String strDescription		= "";
		
		String deployGetJson 		= "";
		String vDeployGetJson 		= "";
		Map rMap = null;

		Map<String, Object> paramMap = new HashMap<String, Object>();
		Map<String, Object> rMap3 = new HashMap<String, Object>();

		StringBuffer sb 	= new StringBuffer();
		// 결재통보 발송 체크로직
		String bJobApprovalChk = "N";
		// 반영완료 발송 체크로직
		String bJobExcChk = "N";

		int successCnt = 0;
		int failCnt = 0;

		CommonBean commonBean 		= emBatchResultTotalDao.dGetDataCenterInfo(map);

		String strActiveNetName 	= CommonUtil.isNull(commonBean.getActive_net_name());
		map.put("active_net_name", 	strActiveNetName);

		map.put("order", "");


		//결재 처리 후 반영 시점에 그룹 내 문서도 조회 후 반영한다.
		map.put("doc_cnt", doc_cnt);
		//메인문서만 결재 처리해줘야 함/단건도마찬가지
		List mainDocInfoList = worksApprovalDocDao.dGetMainDocInfoList(map);

		//문서가 승인취소/삭제됐을 때 대비해서 체크로직 추가
		if (mainDocInfoList.size() == 0) {
			Map rMap2 = new HashMap();
			//rMap2.put("r_code",	"-1");
			rMap2.put("r_code", "-2");
			rMap2.put("r_msg", "ERROR.82");
			rMap2.put("rMsg", "ERROR.82");    // 일괄 결재 시 rMsg로 설정해야 정상적으로 오류 출력??
			throw new DefaultServiceException(rMap2);
		}
		
		for (int j = 0; j < mainDocInfoList.size(); j++) {

			DocInfoBean docInfo = (DocInfoBean) mainDocInfoList.get(j);

			doc_gb 				= CommonUtil.isNull(docInfo.getDoc_gb());
			doc_cd 				= CommonUtil.isNull(docInfo.getDoc_cd());
			strTableId 			= CommonUtil.isNull(docInfo.getTable_id());
			strJobId 			= CommonUtil.isNull(docInfo.getJob_id());
			strTableName 		= CommonUtil.isNull(docInfo.getTable_name());
			strJobName 			= CommonUtil.isNull(docInfo.getJob_name());
			strDataCenter 		= CommonUtil.isNull(docInfo.getData_center());
			strMainDocCd 		= CommonUtil.isNull(docInfo.getMain_doc_cd());
			strDescription 		= CommonUtil.isNull(docInfo.getDescription());
			
			map.put("flag"		,"exec");
			map.put("doc_cd"	,doc_cd);
			map.put("doc_gb"	,doc_gb);
			map.put("table_id"	,strTableId);
			map.put("table_name", strTableName);
			map.put("p_sched_table", strTableName);
			map.put("job_id", strJobId);
			map.put("job_name", strJobName);
			map.put("data_center", strDataCenter);
			map.put("description", strDescription);
			
			rMap = worksApprovalDocDao.dPrcDocApproval(map);

			try{
				if ("06".equals(doc_gb)) {

					Doc01Bean doc01 = new Doc01Bean();
					Doc06Bean doc06 = worksApprovalDocDao.dGetDoc06(map);

					doc01.setData_center(CommonUtil.isNull(doc06.getData_center()));
					doc01.setTable_name(CommonUtil.isNull(doc06.getTable_name()));
					doc01.setTable_cnt(CommonUtil.isNull(doc06.getTable_cnt()));
					doc01.setUser_daily(CommonUtil.isNull(doc06.getUser_daily()));
					doc01.setDoc_cd(CommonUtil.isNull(doc06.getDoc_cd()));
					
					map.put("doc01", doc01);

					List<Doc06Bean> alDocList = new ArrayList();
					alDocList = worksApprovalDocDao.dGetDoc06DetailList(map);

					String act_gb = CommonUtil.isNull(doc06.getAct_gb());

					// 쿼츠에 있는 로직 가져와서 즉시 반영으로 변경
					String docCd = CommonUtil.isNull(map.get("doc_cd"));

					Map<String, Object> quartz_map = new HashMap<String, Object>();
					quartz_map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

					logger.info("#EzExcelBatchQuartzServiceImpl | Start~~~");

					quartz_map.put("flag", act_gb);
					quartz_map.put("doc_cd", docCd);

					Map<String, Object> quartz_rMap = new HashMap<>();
					Map<String, Object> quartz_rTokenMap = new HashMap<String, Object>();

					logger.info("#EzExcelBatchQuartzServiceImpl | flag ::" + act_gb);

					try {

						List<Doc06Bean> dt_list = quartzDao.dGetExcelVerifyBatchExecuteGroup(quartz_map);

						if (dt_list.size() > 0) {

							//ConnectionManager cm = new ConnectionManager();
							//quartz_rTokenMap = cm.login(map);

							HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
							String strUserToken = "";

							CommonUtil.emLogin(request);
							strUserToken = CommonUtil.isNull(request.getSession().getAttribute("USER_TOKEN"));

							quartz_map.put("userToken", CommonUtil.isNull(strUserToken));

							logger.info("#EzExcelBatchQuartzServiceImpl | userToken ::" + CommonUtil.isNull(strUserToken));

							for (int h = 0; h < dt_list.size(); h++) {

								Doc06Bean dt_bean = dt_list.get(h);

								quartz_map.put("data_center", dt_bean.getData_center());
								quartz_map.put("table_name", dt_bean.getTable_name());
								strTableName = dt_bean.getTable_name();
								List<Doc06Bean> list = quartzDao.dGetExcelBatchList(quartz_map);

								int list_cnt = 0;
								list_cnt = list.size();

								if (list_cnt > 0) {

									T_Manager5 t = new T_Manager5();


									StringBuffer quartz_sb = new StringBuffer();

									for (int i = 0; i < list_cnt; i++) {
										Doc06Bean bean = list.get(i);

										try {

											Map<String, Object> checkMap = new HashMap<>();

											checkMap.put("job_name", "V_"+CommonUtil.isNull(bean.getJob_name()));
											checkMap.put("data_center", CommonUtil.isNull(bean.getData_center()));
											checkMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

											// 작업이 Control-M에 등록되어 있는지 확인.
											CommonBean quartz_commonBean = worksApprovalDocDao.dGetChkDefJobCnt(checkMap);

											if (quartz_commonBean.getTotal_count() == 0) {
												bean.setT_conditions_out(CommonUtil.isNull(bean.getT_conditions_out()).replace(CommonUtil.isNull(bean.getJob_name()), "V_"+CommonUtil.isNull(bean.getJob_name())));
												bean.setJob_name("V_"+CommonUtil.isNull(bean.getJob_name()));
												//CTM api Call
												quartz_map.put("doc06", bean);
												quartz_rMap = t.defCreateJobs(quartz_map);

												String rApiCode = CommonUtil.isNull(quartz_rMap.get("rCode"));
												String rApiMsg = CommonUtil.isNull(quartz_rMap.get("rMsg"));

												logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |job_name ::" + CommonUtil.isNull(bean.getJob_name()));
												logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |rApiCode ::" + rApiCode);
												logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |rApiMsg ::" + rApiMsg);

												String strUploadDataCenter = CommonUtil.isNull(bean.getData_center());
												if (strUploadDataCenter.indexOf(",") > -1) {
													strUploadDataCenter = strUploadDataCenter.split(",")[1];
												}

												// 업로드 테이블 추출
												quartz_sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
												quartz_sb.append(",");
												upload_sb.append(bean.getTable_name() + "|" + strUploadDataCenter);
												upload_sb.append(",");                                             
												// EZ_DOC_06_DETAIL 플래그 업데이트
												if (rApiCode.equals("1")) {
													
													// EM API 호출 시 서브 폴더에 넣어도 최상단 스마트 폴더에 들어가는 버그 있는 듯.
													// DB 업데이트로 진행 해본다. (2024.05.02 강명준)
													String strParentTable = CommonUtil.isNull(bean.getTable_name());
													
													// EM API 호출 시 서브 폴더에 넣어도 최상단 스마트 폴더에 들어가는 버그 있는 듯.
													// DB 업데이트로 진행 해본다. (2024.05.02 강명준)
													if ( strParentTable.indexOf("/") > -1 ) {
														
														Connection conn			= null;
														PreparedStatement ps 	= null;
														
														com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
														conn = DbUtil.getConnection(ds);
														
														StringBuffer sql = new StringBuffer();
														
														sql.setLength(0);
														sql.append(" UPDATE DEF_JOB SET parent_table = '" + strParentTable + "' WHERE job_name = '" + strJobName + "' ");					
															
														ps = conn.prepareStatement(sql.toString());
														ps.executeUpdate();
														
														ps.close();
														conn.close();
													}
													
													quartz_map.put("apply_check", "Y");
													quartz_map.put("r_msg", "등록성공");
													quartz_map.put("doc_cd", bean.getDoc_cd());
													quartz_map.put("seq", bean.getSeq());

													quartzDao.dPrcExcelBatchApplyUpdate(quartz_map);

													// 최종 반영 후 JOB_MAPPER에 등록
													CommonUtil.jobMapperInsertPrc(bean.getDoc_cd(), CommonUtil.isNull(bean.getJob_name()));
													
												} else {

													quartz_map.put("r_msg", rApiMsg);
													quartz_map.put("doc_cd", bean.getDoc_cd());
													quartz_map.put("seq", bean.getSeq());

													quartzDao.dGetExcelBatchErrMsgUpdate(quartz_map);

													logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |ERRORLOG ::" + quartz_map.get("r_msg"));
												}

											} else {

												quartz_map.put("r_msg", "중복 작업 존재");
												quartz_map.put("doc_cd", bean.getDoc_cd());
												quartz_map.put("seq", bean.getSeq());

												quartzDao.dGetExcelBatchErrMsgUpdate(quartz_map);

												logger.info("#EzExcelBatchQuartzServiceImpl | CREATE |ERRORLOG ::" + quartz_map.get("r_msg"));
											}

										} catch (Exception e) {

											logger.info("#EzExcelBatchQuartzServiceImpl | CREATE | Execute | Error :::" + e.getMessage());
										}
									}
									System.out.println("quartz_sb.toString() : " + quartz_sb.toString());
									
									// 추출한 테이블 업로드
									String strUploadTable = CommonUtil.dupStringCheck(quartz_sb.toString());
									if (!strUploadTable.equals("")) {

										String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");

										for (int jj = 0; jj < arrUploadTable.length; jj++) {

											quartz_map.put("table_name", arrUploadTable[jj].split("[|]")[0]);
											quartz_map.put("data_center", arrUploadTable[jj].split("[|]")[1]);

											// 실제 업로드 수행
											t.defUploadjobs(quartz_map);
										}
									}
								}
							}
						}

					} catch (Exception e) {
						logger.info("#EzExcelBatchQuartzServiceImpl | Error :::" + e.getMessage());
					} finally {
					}
					logger.info("#EzExcelBatchQuartzServiceImpl | End~~~");
				}

			} finally {
				if ("1".equals(CommonUtil.isNull(rMap.get("r_code"))))  {
					successCnt++;
				}else{
					failCnt++;
				}


			}
			
			
			
		}

		if (mainDocInfoList.size() != successCnt) {
			sb.append("\n");
		}

			//if(failCnt > 0) sb.insert(4,"\n\n" + mainDocInfoList.size() + "건의 작업 중 " + successCnt + "건 반영 완료 " + failCnt +"건 반영 실패");
			//if(failCnt == 0) sb.insert(4,"\n\n" + mainDocInfoList.size() + "건의 작업 중 " + successCnt + "건 반영 완료");

		rMap.put("r_msg",sb);
		rMap.put("doc_cd", doc_cd);
		rMap.put("sendInsUserNoti" , bJobExcChk);
		rMap.put("sendApprovalNoti" , bJobApprovalChk);
		System.out.println("upload_sb.toString() : " + upload_sb.toString());
		// 일괄 결재일 경우 Controller에서 업로드 수행.
		// 일괄 결재일 경우 업로드를 한번에 하기 위해 r_table 셋팅.
		if ( doc_gb.equals("01") || doc_gb.equals("03") || doc_gb.equals("04") || doc_gb.equals("06") ) {
			
			paramMap.put("userToken", 	CommonUtil.isNull(map.get("userToken")));

			String strUploadTable = CommonUtil.dupStringCheck(upload_sb.toString());
			
			logger.info("(" + doc_cd + ")" + "업로드 대상 폴더 : " + strUploadTable);

			if ( !strUploadTable.equals("") ) {

				String arrUploadTable[] = CommonUtil.isNull(strUploadTable).split(",");
				Map upload_Map = new HashMap();

				for ( int j = 0; j < arrUploadTable.length; j++ ) {

					paramMap.put("table_name", 	arrUploadTable[j].split("[|]")[0]);
					paramMap.put("data_center", arrUploadTable[j].split("[|]")[1]);

					// 실제 업로드 수행
					upload_Map = emJobUploadDao.defUploadJobs(paramMap);
					
					//업로드 수행 후 에러 발생시 예외 처리
					if(!upload_Map.get("rCode").equals("1")) {
						
						logger.info("폴더 upload 작업 실패 ::: " + paramMap.get("table_name"));
						
						upload_Map.put("r_msg", "폴더 upload 작업 실패");
						
						//업로드 수행 실패 후 업로드 초기화
						upload_sb.setLength(0);
						
						throw new DefaultServiceException(upload_Map);
					}
				}
			}
			
			//업로드 수행 후 업로드 초기화
			upload_sb.setLength(0);
		}
		
		Doc06Bean doc06 = worksApprovalDocDao.dGetDoc06(map);
		
		String act_gb = CommonUtil.isNull(doc06.getAct_gb());
		String docCd = CommonUtil.isNull(map.get("doc_cd"));
		
		Map<String, Object> quartz_map = new HashMap<String, Object>();
		quartz_map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		logger.info("#EzExcelBatchQuartzServiceImpl | Start~~~");

		quartz_map.put("flag", act_gb);
		quartz_map.put("doc_cd", docCd);
		
		List<Doc06Bean> list = worksApprovalDocDao.dGetDoc06DetailList(map);
		
		int list_cnt = 0;
		list_cnt = list.size();
		for (int i = 0; i < list_cnt; i++) {
			Doc06Bean bean = list.get(i);
			strTableName = CommonUtil.isNull(bean.getTable_name());
			String AAPI_URL 	= CommonUtil.isNull(CommonUtil.getMessage("AAPI_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			
			/*===================original job=================*/
			String strCtm		= strDataCenter.split(",")[1];						// CTM
			String strFolder	= strTableName;		// FOLDER
			String strJob		= CommonUtil.isNull(bean.getJob_name());		// JOBNAME
			
			String REST_URL		= AAPI_URL + "/deploy/jobs?format=json&folder=" + strFolder + "&job=" + strJob + "&server=" + strCtm;
			
			String oriJson		= AAPI_Util.restApiDeployGet(AAPI_URL, REST_URL, "GET", strFolder);
			
			JSONObject jsonObject = new JSONObject(oriJson);
			
			if (jsonObject.has("errors") && jsonObject.getJSONArray("errors").length() > 0) {
				// "errors" 배열에서 첫 번째 "message" 값을 가져오기
	            JSONArray errorsArray = jsonObject.getJSONArray("errors");
	            String message = errorsArray.getJSONObject(0).getString("message");
	            
	            rMap.put("v_r_code", "-1");
				rMap.put("v_rCode", "-1");
				rMap.put("v_r_msg", "엑셀 검증 중 오류가 발생하였습니다.\n"+message);
				
			}else {
				deployGetJson = deployGetJson +","+oriJson.replaceFirst("\\{", "\\{\"Job\":").replace(": {    \"Type\"", ", \"Type\"").replace("}}", "}");
			}
			/*===================original job=================*/
			
			/*===================verify job=================*/
			String strVCtm		= strDataCenter.split(",")[1];						// CTM
			String strVFolder	= strTableName;		// FOLDER
			String strVJob		= "V_"+CommonUtil.isNull(bean.getJob_name());		// JOBNAME
			
			String V_REST_URL	= AAPI_URL + "/deploy/jobs?format=json&folder=" + strVFolder + "&job=" + strVJob + "&server=" + strVCtm;
			
			String oriVJson		= AAPI_Util.restApiDeployGet(AAPI_URL, V_REST_URL, "GET", strVFolder);
			
			JSONObject jsonVObject = new JSONObject(oriVJson);
			
			if (jsonVObject.has("errors") && jsonVObject.getJSONArray("errors").length() > 0) {
				// "errors" 배열에서 첫 번째 "message" 값을 가져오기
	            JSONArray errorsVArray = jsonVObject.getJSONArray("errors");
	            String vMessage = errorsVArray.getJSONObject(0).getString("message");
	            
	            Doc03Bean doc03Bean = new Doc03Bean();

				doc03Bean.setTable_name(strVFolder);
				doc03Bean.setData_center(strVCtm);
				doc03Bean.setJob_name(strVJob);
				map.put("doc03", doc03Bean);
				rMap = emJobDeleteDao.deleteJobs(map);
	            
				map.put("flag", "del");
				map.put("doc_cd", doc_cd);
				rMap = worksApprovalDocDao.dPrcDocApproval(map);	
				
	            rMap.put("v_r_code", "-1");
				rMap.put("v_rCode", "-1");
				rMap.put("v_r_msg", "엑셀 검증 중 오류가 발생하였습니다.\n"+vMessage);
				
				
			}else {
				vDeployGetJson = vDeployGetJson +","+oriVJson.replaceFirst("\\{", "\\{\"Job\":").replace(": {    \"Type\"", ", \"Type\"").replace("}}", "}");
				
				Doc03Bean doc03Bean = new Doc03Bean();

				doc03Bean.setTable_name(strVFolder);
				doc03Bean.setData_center(strVCtm);
				doc03Bean.setJob_name(strVJob);
				map.put("doc03", doc03Bean);
				rMap = emJobDeleteDao.deleteJobs(map);
				
				String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
				
				if ( !"1".equals(rCode) ) {
					
					rMap.put("r_code", "-1");
					throw new DefaultServiceException(rMap);
				}
				
				map.put("flag", "del");
				map.put("doc_cd", doc_cd);
				rMap = worksApprovalDocDao.dPrcDocApproval(map);	
			}
			/*===================verify job=================*/
			
		}
		System.out.println("rMap : " + rMap);
		String v_r_code 	= CommonUtil.isNull(rMap.get("v_r_code"));
		String v_r_msg 	= CommonUtil.isNull(rMap.get("v_r_msg"));
		
		if (v_r_code != null && !v_r_code.isEmpty() && !v_r_code.equals("1") && !v_r_code.equals("")) {
		//if ( !"".equals(v_r_code) && !"1".equals(v_r_code)) {
			rMap.put("r_code", "-1");
			rMap.put("r_msg", v_r_msg);
			throw new DefaultServiceException(rMap);
		}
		
		deployGetJson = deployGetJson.substring(1, deployGetJson.length());
		vDeployGetJson = vDeployGetJson.substring(1, vDeployGetJson.length());
		
		rMap.put("r_ori_con", "["+deployGetJson+"]");
		rMap.put("r_new_con", "["+vDeployGetJson+"]");
		
        JSONArray jsonArray = new JSONArray(CommonUtil.isNull(rMap.get("r_ori_con")));
        JSONArray jsonVArray = new JSONArray(CommonUtil.isNull(rMap.get("r_new_con")));
        
		return rMap;
	}
	
}