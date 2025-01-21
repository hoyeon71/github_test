package com.ghayoun.ezjobs.common.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TreeSet;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import javax.crypto.Cipher;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilderFactory;

import com.ghayoun.ezjobs.a.repository.EmAlertDao;
import com.ghayoun.ezjobs.a.service.EmAlertService;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import com.bmc.ctmem.schema900.ErrorListType;
import com.bmc.ctmem.schema900.FaultOrderForceWithJobsType;
import com.bmc.ctmem.schema900.ResponseUserRegistrationType;
import com.ghayoun.ezjobs.comm.domain.CommonBean;
import com.ghayoun.ezjobs.comm.repository.CommonDao;
import com.ghayoun.ezjobs.comm.repository.CommonDaoImpl;
import com.ghayoun.ezjobs.comm.repository.QuartzDao;
import com.ghayoun.ezjobs.comm.service.CommonService;
import com.ghayoun.ezjobs.comm.service.EzSmsJobServiceImpl;
import com.ghayoun.ezjobs.m.domain.JobGraphBean;
import com.ghayoun.ezjobs.m.service.PopupJobGraphService;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;
import com.ghayoun.ezjobs.t.domain.CompanyBean;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc07Bean;
import com.ghayoun.ezjobs.t.domain.DocInfoBean;
import com.ghayoun.ezjobs.t.domain.JobMapperBean;
import com.ghayoun.ezjobs.t.repository.EmDeleteConditionDao;
import com.ghayoun.ezjobs.t.repository.EmJobActionDao;
import com.ghayoun.ezjobs.t.repository.EmJobCreateDao;
import com.ghayoun.ezjobs.t.repository.EmJobDefinitionDao;
import com.ghayoun.ezjobs.t.repository.EmJobDeleteDao;
import com.ghayoun.ezjobs.t.repository.EmJobOrderDao;
import com.ghayoun.ezjobs.t.repository.WorksApprovalDocDao;
import com.ghayoun.ezjobs.t.repository.WorksUserDao;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocService;
import com.ghayoun.ezjobs.t.service.WorksApprovalDocServiceImpl;
import com.ghayoun.ezjobs.t.service.WorksCompanyService;
import com.ghayoun.ezjobs.t.service.WorksUserService;
import com.jcraft.jsch.Logger;

import net.sf.json.JSONArray;


@SuppressWarnings({ "unused", "unchecked" })
public class CommonWorksUtil {
	
	private static WorksApprovalDocDao worksApprovalDocDao;
	private static WorksUserDao worksUserDao;
	private static EmJobDefinitionDao emJobDefinitionDao;
	private static EmJobCreateDao emJobCreateDao;
	private static EmJobDeleteDao emJobDeleteDao;
	private static EmJobActionDao emJobActionDao;
	private static EmDeleteConditionDao emDeleteConditionDao;
	private static EmJobOrderDao emJobOrderDao;
	private static CommonDao commonDao;
	private static EmAlertDao emAlertDao;
	
	private static final Log logger = LogFactory.getLog(CommonWorksUtil.class);
	
	// 특수문자 처리
	public static Map jobInfoReplaceStrHtml(Map<String, Object> map) {
	
		String t_set		= CommonUtil.isNull(map.get("t_set"));
		String command		= CommonUtil.isNull(map.get("command"));
		String month_days	= CommonUtil.isNull(map.get("month_days"));
		String week_days	= CommonUtil.isNull(map.get("week_days"));
		String time_until	= CommonUtil.isNull(map.get("time_until"));
		String description	= CommonUtil.isNull(map.get("description"));

		String active_yn	= CommonUtil.isNull(map.get("active_yn"));
		String active_from	= CommonUtil.isNull(map.get("active_from"));
		String active_till	= CommonUtil.isNull(map.get("active_till"));

		if (active_yn.equals("N")) {
			map.put("active_from", active_till);
			map.put("active_till", active_from);
		}
		
		
		if(!CommonUtil.isNull(map.get("description")).equals("")){
			description = CommonUtil.replaceStrHtml(description);
		}
		map.put("description",description);

		if(!CommonUtil.isNull(map.get("command")).equals("")){
			command = CommonUtil.replaceStrHtml(command);
		}
		map.put("command",command);

		if(!CommonUtil.isNull(map.get("month_days")).equals("")){
			month_days = CommonUtil.replaceStrHtml(month_days);
		}
		map.put("month_days",month_days);

		if(!CommonUtil.isNull(map.get("week_days")).equals("")){
			week_days = CommonUtil.replaceStrHtml(week_days);
		}
		map.put("week_days",week_days);

		if (!time_until.equals("")) {
			time_until = CommonUtil.replaceStrHtml(time_until);
		}
		map.put("time_until",time_until);

		if(!CommonUtil.isNull(map.get("t_set")).equals("")){
			t_set = CommonUtil.replaceStrHtml(t_set);
		}
		map.put("t_set",t_set);

		// 정기, 수시 체크
		// 스케줄 정보가 입력 안되면 수시로 간주 (2020.07.20. 강명준)
		if ( CommonUtil.isNull(map.get("month_days")).equals("") && CommonUtil.isNull(map.get("days_cal")).equals("") && CommonUtil.isNull(map.get("week_days")).equals("") && CommonUtil.isNull(map.get("weeks_cal")).equals("")) {
			map.put("jobSchedGb","2");
		} else {
			map.put("jobSchedGb","1");
		}
	
		return map;
	}
	
	// 최종 반영 후 JOB_MAPPER에 등록
	public static Map jobMapperOneUpdateDoc(Map<String, Object> map) {
	
		Map<String, Object> rMap = new HashMap<>();
		
		String strJobName = CommonUtil.isNull(map.get("job_name"));
		
		try{
			
			WorksUserService worksUserService = (WorksUserService) CommonUtil.getSpringBean("tWorksUserService");
			
			map.put("flag", 		"one_update_doc");	
			
			if ( !strJobName.equals("") ) {
				
				map.put("job", 					strJobName);
				map.put("doc_cd", 				CommonUtil.isNull(map.get("doc_cd")));
				map.put("description", 			CommonUtil.isNull(map.get("description")));

				map.put("user_cd_1", 			CommonUtil.isNull(map.get("user_cd_1_0")));
				map.put("user_cd_2", 			CommonUtil.isNull(map.get("user_cd_2_0")));
				map.put("user_cd_3", 			CommonUtil.isNull(map.get("user_cd_3_0")));
				map.put("user_cd_4", 			CommonUtil.isNull(map.get("user_cd_4_0")));
				map.put("user_cd_5", 			CommonUtil.isNull(map.get("user_cd_5_0")));
				map.put("user_cd_6", 			CommonUtil.isNull(map.get("user_cd_6_0")));
				map.put("user_cd_7", 			CommonUtil.isNull(map.get("user_cd_7_0")));
				map.put("user_cd_8", 			CommonUtil.isNull(map.get("user_cd_8_0")));
				map.put("user_cd_9", 			CommonUtil.isNull(map.get("user_cd_9_0")));
				map.put("user_cd_10", 			CommonUtil.isNull(map.get("user_cd_10_0")));
				map.put("sms_1", 				CommonUtil.isNull(map.get("sms_1_0")));
				map.put("sms_2", 				CommonUtil.isNull(map.get("sms_2_0")));
				map.put("sms_3", 				CommonUtil.isNull(map.get("sms_3_0")));
				map.put("sms_4", 				CommonUtil.isNull(map.get("sms_4_0")));
				map.put("sms_5", 				CommonUtil.isNull(map.get("sms_5_0")));
				map.put("sms_6", 				CommonUtil.isNull(map.get("sms_6_0")));
				map.put("sms_7", 				CommonUtil.isNull(map.get("sms_7_0")));
				map.put("sms_8", 				CommonUtil.isNull(map.get("sms_8_0")));
				map.put("sms_9", 				CommonUtil.isNull(map.get("sms_9_0")));
				map.put("sms_10", 				CommonUtil.isNull(map.get("sms_10_0")));
				map.put("mail_1", 				CommonUtil.isNull(map.get("mail_1_0")));
				map.put("mail_2", 				CommonUtil.isNull(map.get("mail_2_0")));
				map.put("mail_3", 				CommonUtil.isNull(map.get("mail_3_0")));
				map.put("mail_4", 				CommonUtil.isNull(map.get("mail_4_0")));
				map.put("mail_5", 				CommonUtil.isNull(map.get("mail_5_0")));
				map.put("mail_6", 				CommonUtil.isNull(map.get("mail_6_0")));
				map.put("mail_7", 				CommonUtil.isNull(map.get("mail_7_0")));
				map.put("mail_8", 				CommonUtil.isNull(map.get("mail_8_0")));
				map.put("mail_9", 				CommonUtil.isNull(map.get("mail_9_0")));
				map.put("mail_10", 				CommonUtil.isNull(map.get("mail_10_0")));

				map.put("grp_cd_1", 			CommonUtil.isNull(map.get("grp_cd_1_0")));
				map.put("grp_cd_2", 			CommonUtil.isNull(map.get("grp_cd_2_0")));
				map.put("grp_sms_1", 			CommonUtil.isNull(map.get("grp_sms_1_0")));
				map.put("grp_sms_2", 			CommonUtil.isNull(map.get("grp_sms_2_0")));
				map.put("grp_mail_1", 			CommonUtil.isNull(map.get("grp_mail_1_0")));
				map.put("grp_mail_2", 			CommonUtil.isNull(map.get("grp_mail_2_0")));

				map.put("calendar_nm", 			CommonUtil.isNull(map.get("cal_nm")));
				map.put("late_sub", 			CommonUtil.isNull(map.get("late_sub")));
				map.put("late_time", 			CommonUtil.isNull(map.get("late_time")));
				map.put("late_exec", 			CommonUtil.isNull(map.get("late_exec")));
				map.put("batchJobGrade", 		CommonUtil.isNull(map.get("batchJobGrade")));
				map.put("error_description", 	CommonUtil.isNull(map.get("error_description")));
				map.put("jobSchedGb", 			CommonUtil.isNull(map.get("jobSchedGb")));
				map.put("success_sms_yn",		CommonUtil.isNull(map.get("success_sms_yn")));

				rMap 	= worksUserService.dPrcJobMapper(map);

				if( !"1".equals(CommonUtil.isNull(rMap.get("r_code"))) ) throw new DefaultServiceException(rMap);
			}
			
		}catch(Exception e){
			rMap.put("r_code", "-1");
			rMap.put("r_msg","ERROR.01");
		}
	
		return rMap;
	}
	
	// 정기 작업 등록
	public static Map prcDefCreateJobs(Map<String, Object> map, Doc01Bean oriDoc01Bean) throws Exception {
		
		worksApprovalDocDao = (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emJobDefinitionDao 	= (EmJobDefinitionDao) CommonUtil.getSpringBean("tEmJobDefinitionDao");
		
		String strDocCd = CommonUtil.isNull(map.get("doc_cd"));
		String strDocGb = CommonUtil.isNull(map.get("doc_gb"));
		String strOrg 	= CommonUtil.isNull(map.get("org"));
		
		Map rMap = null;
		Doc01Bean doc01Bean = new Doc01Bean();
		
		// 중복된 잡 이름이 있는지 체크.
		CommonBean bean = worksApprovalDocDao.dGetChkDefJobCnt(map);
		
		if( bean.getTotal_count()>0){
			Map rMap2 = new HashMap();
			rMap2.put("r_code","-1");
			rMap2.put("r_msg","ERROR.17");
			throw new DefaultServiceException(rMap2);
		}

		//테이블 동기화체크 대비 체크로직(6초까지 체크 후 lock이 안풀리면 반영실패)
		CommonBean tableStatusBean = null;
		for(int i=0; i < 7; i++) {
			Thread.sleep(1000);
			tableStatusBean = worksApprovalDocDao.dGetChkDefTablesLockCnt(map);
			
			if (tableStatusBean.getTotal_count() == 0) {
				logger.info("table lock이 풀림:::::::::::::");
				break;
			} else {
				logger.info("table lock이 걸림:::::::::::::");
				if(i == 6) {
					Map rMap2 = new HashMap();
					rMap2.put("r_code", "-1");
					rMap2.put("r_msg", "ERROR.54");
					throw new DefaultServiceException(rMap2);
				}
			}
		}

		if ( strDocGb.equals("01") ) {
			
			doc01Bean = worksApprovalDocDao.dGetDoc01(map);	
			
		} else if ( strDocGb.equals("04") && strOrg.equals("") ) {
			
			doc01Bean = worksApprovalDocDao.dGetDoc04(map);
		
		} else if ( strDocGb.equals("04") && strOrg.equals("Y") ) { // 수정 원복

			//map.put("p_sched_table", map.get("table_name"));
			//doc01Bean = worksApprovalDocDao.dGetJobModifyInfo(map);
			CommonUtil.beanTobean(oriDoc01Bean, doc01Bean);
		}
		
		// PostProc 공통
		CommonWorksUtil.setPostProc(doc01Bean);
		
		String strCommand = CommonUtil.isNull(doc01Bean.getCommand());
		
		if(!strCommand.equals("")){
			strCommand = strCommand.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
		}
		
		doc01Bean.setCommand(strCommand);
		
		map.put("doc01", doc01Bean);
		
		logger.debug(">>>>>prcDefCreateJobs 시작<<<<<");
		
		rMap = emJobDefinitionDao.prcDefCreateJobs(map);

		logger.debug(">>>>>prcDefCreateJobs 종료<<<<<");
		
		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		String rMsg 	= CommonUtil.isNull(rMap.get("rMsg"));

		if ( !"1".equals(rCode) ) {

			logger.error("prcDefCreateJobs 오류 발생 : " + rMsg);

			rMap.put("r_code", "-1");
			rMap.put("r_msg", rMsg);
			//throw new DefaultServiceException(rMap);

		} else {
			
			Doc01Bean docBean = (Doc01Bean)map.get("doc01");
			
			String strTableName = CommonUtil.isNull(docBean.getTable_name());
			String strJobName 	= CommonUtil.isNull(docBean.getJob_name());
			
			// EM API 호출 시 서브 폴더에 넣어도 최상단 스마트 폴더에 들어가는 버그 있는 듯.
			// DB 업데이트로 진행 해본다. (2024.05.02 강명준)
			if ( strTableName.indexOf("/") > -1 ) {
				
				Connection conn			= null;
				PreparedStatement ps 	= null;
				
				com.ghayoun.ezjobs.common.util.CryptoDataSource ds = CommonUtil.getDataSourceWorks();
				conn = DbUtil.getConnection(ds);
				
				StringBuffer sql = new StringBuffer();
				
				sql.setLength(0);
				sql.append(" UPDATE DEF_JOB SET parent_table = '" + strTableName + "' WHERE job_name = '" + strJobName + "' ");					
					
				ps = conn.prepareStatement(sql.toString());
				ps.executeUpdate();
				
				ps.close();
				conn.close();
			}
			
			map.put("data_center", 	docBean.getData_center());
			map.put("table_name", 	docBean.getTable_name());
			map.put("job_name", 	docBean.getJob_name());
			
			String data_center = CommonUtil.isNull(docBean.getData_center());							
			if ( data_center.indexOf(",") > -1 ) {
				data_center = data_center.split(",")[1];
			}
			
			// 업로드 폴더 셋팅
			WorksApprovalDocServiceImpl.upload_sb.append(docBean.getTable_name() + "|" + data_center);
			WorksApprovalDocServiceImpl.upload_sb.append(",");
			
			// 수정 요청이 완료 되면 table_id, job_id 가 바뀐다.
			// 그룹작업안의 작업을 table_id, job_id 로 매핑하였기 때문에 해당 작업의 필드를 업데이트 해줘서 동기화 시켜준다.
			if ( strDocGb.equals("04") ) {
				
				Map map2 = new HashMap();
				map2.put("SCHEMA", 			CommonUtil.isNull(map.get("SCHEMA")));
//				map2.put("flag", 			"update_job_id");
				map2.put("data_center", 	data_center);
				map2.put("job_name", 		CommonUtil.isNull(doc01Bean.getJob_name()));
				
//				worksApprovalDocDao.dPrcJobGroup(map2);
			}
			
			// 최종 반영 후 JOB_MAPPER에 등록
			CommonUtil.jobMapperInsertPrc(strDocCd, docBean.getJob_name());
		}
	
		return rMap;
	}
	
	// 일회성 작업 등록
	public static Map createJobs(Map<String, Object> map) throws Exception {
		
		worksApprovalDocDao = (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emJobCreateDao 		= (EmJobCreateDao) CommonUtil.getSpringBean("tEmJobCreateDao");
		
		String strDocCd = CommonUtil.isNull(map.get("doc_cd"));
		
		Map rMap = null;
		
		Doc01Bean doc02bean = worksApprovalDocDao.dGetDoc02(map);
		
		// PostProc 공통
		CommonWorksUtil.setPostProc(doc02bean);
		
		String strCommand = CommonUtil.isNull(doc02bean.getCommand());
		
		if(!strCommand.equals("")){
			strCommand = strCommand.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
		}
		
		doc02bean.setCommand(strCommand);
		
		map.put("doc02", doc02bean);
		
		rMap = emJobCreateDao.createJobs(map);

		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		
		if ( !"1".equals(rCode) ) {
			
			rMap.put("r_code", "-1");
			throw new DefaultServiceException(rMap);
			
		} else {
			
			// 최종 반영 후 JOB_MAPPER에 등록
			CommonUtil.jobMapperInsertPrc(strDocCd, doc02bean.getJob_name());
		}
	
		return rMap;
	}
	
	// 정기 작업 삭제
	public static Map deleteJobs(Map<String, Object> map) throws Exception {
		
		worksApprovalDocDao = (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emJobDeleteDao 		= (EmJobDeleteDao) CommonUtil.getSpringBean("tEmJobDeleteDao");
		worksUserDao 		= (WorksUserDao) CommonUtil.getSpringBean("tWorksUserDao");
		String strDocCd = CommonUtil.isNull(map.get("doc_cd"));
		String strDocGb = CommonUtil.isNull(map.get("doc_gb"));
		
		Map rMap = null;
		Doc03Bean doc03Bean = new Doc03Bean();


		if ( strDocGb.equals("03") ) {

			Doc01Bean bean04_org = worksApprovalDocDao.dGetJobDefCheck(map);

			if( bean04_org == null){
				Map rMap2 = new HashMap();
				rMap2.put("r_code","-1");
				rMap2.put("r_msg","ERROR.80");
				throw new DefaultServiceException(rMap2);
			}

			doc03Bean = worksApprovalDocDao.dGetDoc03(map);
			
		} else if ( strDocGb.equals("04") ) {
			
			Doc01Bean bean04 = worksApprovalDocDao.dGetDoc04(map);
			
			map.put("p_sched_table", map.get("table_name"));
			Doc01Bean bean04_org = worksApprovalDocDao.dGetJobModifyInfo(map);
			
			//String strRealDataCenter 	= strDataCenter.split(",")[1];

			doc03Bean.setData_center(bean04.getData_center());
			doc03Bean.setJob_name(bean04.getJob_name());
			doc03Bean.setMem_name(bean04.getMem_name());
			
			// application, table_name, group_name은 기존의 값으로 넣어줘야 삭제가 정상적으로 이뤄지므로.
			doc03Bean.setTable_name(bean04.getBefore_table_name());
			doc03Bean.setApplication(bean04.getBefore_application());
			doc03Bean.setGroup_name(bean04.getBefore_group_name());
		}

		map.put("doc03", doc03Bean);
		rMap = emJobDeleteDao.deleteJobs(map);
		
		String rCode 	= CommonUtil.isNull(rMap.get("rCode"));
		
		if ( !"1".equals(rCode) ) {
			
			rMap.put("r_code", "-1");
			throw new DefaultServiceException(rMap);
			
		} else {
			
			Doc03Bean docBean		= (Doc03Bean)map.get("doc03");
			
			map.put("data_center", 	docBean.getData_center());
			map.put("table_name", 	docBean.getTable_name());
			map.put("job_name", 	docBean.getJob_name());
					
			String data_center = CommonUtil.isNull(docBean.getData_center());
			if ( data_center.indexOf(",") > -1 ) {
				data_center = data_center.split(",")[1];
			}
			
			// 업로드 폴더 셋팅
			WorksApprovalDocServiceImpl.upload_sb.append(docBean.getTable_name() + "|" + data_center);
			WorksApprovalDocServiceImpl.upload_sb.append(",");
			
			// 삭제 요청이 완료 되면 그룹작업안의 작업도 삭제한다.
			if ( strDocGb.equals("03") ) {
				Map map2 = new HashMap();
				Map rMapperMap = new HashMap();
				
				map2.put("SCHEMA", 			CommonUtil.isNull(map.get("SCHEMA")));
				map2.put("flag", 			"mapper_del");
				map2.put("data_center", 	CommonUtil.isNull(docBean.getData_center()));
				map2.put("job", 			CommonUtil.isNull(docBean.getJob_name()));
				
				rMapperMap = worksUserDao.dPrcJobMapper(map2);
				if ( !"1".equals(CommonUtil.isNull(rMapperMap.get("r_code"))) ) {rMap.put("r_code", "-1");throw new DefaultServiceException(rMap);}
				
				map2.put("data_center", 	data_center);
				map2.put("flag", 			"delete_job_id");
				map2.put("job_name", 		CommonUtil.isNull(docBean.getJob_name()));
				
				worksApprovalDocDao.dPrcJobGroup(map2);
			}
		}
	
		return rMap;
	}
	
	// 작업 컨디션 제거
	public static Map jobsDeleteCondition(Map<String, Object> map) throws Exception, DefaultServiceException, IOException {
		
		worksApprovalDocDao 	= (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emDeleteConditionDao	= (EmDeleteConditionDao) CommonUtil.getSpringBean("emDeleteConditionDao");
		emJobOrderDao 			= (EmJobOrderDao) CommonUtil.getSpringBean("tEmJobOrderDao");
		
		String strDocCd 		= CommonUtil.isNull(map.get("doc_cd"));
		String strDocGb 		= CommonUtil.isNull(map.get("doc_gb"));
		String strOrg 			= CommonUtil.isNull(map.get("org"));

		Map rMap = null;
		
		List<Doc01Bean> bean04_org = worksApprovalDocDao.dGetJobDefCheckList(map);

		if( bean04_org.size() == 0){

			Map rMap2 = new HashMap();
			rMap2.put("r_code","-1");
			rMap2.put("r_msg","ERROR.80");
			throw new DefaultServiceException(rMap2);
			//주석을했었는데왜?
		}else if(bean04_org.size() > 1){

			Map rMap2 = new HashMap();
			rMap2.put("r_code","-1");
			rMap2.put("r_msg","ERROR.17");
			throw new DefaultServiceException(rMap2);

		}

		Doc05Bean doc05 = worksApprovalDocDao.dGetDoc05(map);

		String strOrgHoldYn		= CommonUtil.isNull(doc05.getHold_yn());
		String strOrgDataCenter	= CommonUtil.isNull(doc05.getData_center());
		String strOrgJobName	= CommonUtil.isNull(doc05.getJob_name());
		String strDaysCal		= CommonUtil.isNull(doc05.getDays_cal());
		String strDaysCnt 		= "";
		String strOrgOrderDate	= "";
		
		String[] arr_conditions_out = CommonUtil.isNull(doc05.getT_conditions_out()).split(",");
		String[] arr_sign_out 		= CommonUtil.isNull(doc05.getOut_sign()).split(",");
		
		map.put("doc05", doc05);
		
		String strOrderDate		= CommonUtil.isNull(doc05.getOrder_date());
		String strEorderDate	= CommonUtil.isNull(doc05.getE_order_date());

		if ( strOrderDate.equals("")) {
			Map rMap2 = new HashMap();
			rMap2.put("r_code", "-1");
			rMap2.put("r_msg", "ERROR.74");
			throw new DefaultServiceException(rMap2);
		}
		if ( strEorderDate.equals("") ) {
			strEorderDate = strOrderDate;
		}

		int iDiffOfDate = (int) DateUtil.diffOfDate(strOrderDate, strEorderDate);
		
		System.out.println("iDiffOfDate : " + iDiffOfDate);

		for ( int i = 0; i < iDiffOfDate + 1; i++ ) {
			
			if ( i == 0 ) {
				map.put("order_date", strOrderDate);
				
				strOrgOrderDate	= strOrderDate.substring(4, 8);
				map.put("odate", strOrgOrderDate);
				
			} else {
				
				doc05.setOrder_date(DateUtil.addDate(strOrderDate, i));

				strOrgOrderDate	= DateUtil.addDate(strOrderDate, i).substring(4, 8);
				map.put("odate", strOrgOrderDate);
			}
			
			// 해당 작업의 발행 컨디션을 제거
			for(int j = 0; j < arr_conditions_out.length; j++) {
				if(arr_sign_out[j].equals("+")) {
					map.put("data_center", 	strOrgDataCenter);
					map.put("condition", 	arr_conditions_out[j]);
					
					Map rDelConMap = emDeleteConditionDao.deleteCondition(map);
					
					logger.info("rDelConMap : " + rDelConMap);
					
					String rDelConCode 	= CommonUtil.isNull(rDelConMap.get("rCode"));
					String rDelMsg 		= CommonUtil.isNull(rDelConMap.get("rMsg"));
					
					logger.info("rDelConCode : " + rDelConCode);
					
					if( !"1".equals(rDelConCode)){
						Map rMap2 = new HashMap();
						rMap2.put("r_code", "-1");
						rMap2.put("r_msg", rDelMsg);
						throw new DefaultServiceException(rDelConMap);
					}
				}
			}
		}
	
		return rMap;
	}
	
	// 작업 오더
	public static Map jobsOrder(Map<String, Object> map) throws Exception, DefaultServiceException, IOException {
		
		worksApprovalDocDao 	= (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emDeleteConditionDao	= (EmDeleteConditionDao) CommonUtil.getSpringBean("emDeleteConditionDao");
		emJobOrderDao 			= (EmJobOrderDao) CommonUtil.getSpringBean("tEmJobOrderDao");
		
		String strDocCd 		= CommonUtil.isNull(map.get("doc_cd"));
		String strDocGb 		= CommonUtil.isNull(map.get("doc_gb"));
		String strOrg 			= CommonUtil.isNull(map.get("org"));

		Map rMap = null;
		
		// 일반 ORDER API 호출.
		//if ( strDocGroupId.equals("") || strDocGroupId.equals("0") ) {
		
		List<Doc01Bean> bean04_org = worksApprovalDocDao.dGetJobDefCheckList(map);

		if( bean04_org.size() == 0){

			Map rMap2 = new HashMap();
			rMap2.put("r_code","-1");
			rMap2.put("r_msg","ERROR.80");
			throw new DefaultServiceException(rMap2);

		}else if(bean04_org.size() > 1){

			Map rMap2 = new HashMap();
			rMap2.put("r_code","-1");
			rMap2.put("r_msg","ERROR.17");
			rMap2.put("rMsg","ERROR.17");
			throw new DefaultServiceException(rMap2);

		}

		Doc05Bean doc05 = worksApprovalDocDao.dGetDoc05(map);

		String strOrgHoldYn		= CommonUtil.isNull(doc05.getHold_yn());
		String strOrgDataCenter	= CommonUtil.isNull(doc05.getData_center());
		String strOrgJobName	= CommonUtil.isNull(doc05.getJob_name());
		String strDaysCal		= CommonUtil.isNull(doc05.getDays_cal(),"");
		String strDaysCnt 		= "";
		String strOderIntoFolder = CommonUtil.isNull(doc05.getOrder_into_folder());
		
		String strOrgOrderDate	= "";
		
		map.put("doc05", doc05);
		
		String strOrderDate		= CommonUtil.isNull(doc05.getOrder_date());
		String strEorderDate	= CommonUtil.isNull(doc05.getE_order_date());

		if ( strOrderDate.equals("")) {
			Map rMap2 = new HashMap();
			rMap2.put("r_code", "-1");
			rMap2.put("r_msg", "ERROR.74");
			throw new DefaultServiceException(rMap2);
		}
		if ( strEorderDate.equals("") ) {
			strEorderDate = strOrderDate;
		}

		if(!strOderIntoFolder.equals("")) {
			map.put("order_into_folder", strOderIntoFolder);
		}

		int iDiffOfDate = (int) DateUtil.diffOfDate(strOrderDate, strEorderDate);
		
		for ( int i = 0; i < iDiffOfDate + 1; i++ ) {
			
			if ( i == 0 ) {
				map.put("order_date", strOrderDate);
				
				strOrgOrderDate	= strOrderDate.substring(4, 8);
				map.put("odate", strOrgOrderDate);
				
			} else {
				
				doc05.setOrder_date(DateUtil.addDate(strOrderDate, i));

				strOrgOrderDate	= DateUtil.addDate(strOrderDate, i).substring(4, 8);
				map.put("odate", strOrgOrderDate);
				
				map.put("doc05", doc05);
			}
			
			String strCondSuffix = CommonUtil.isNull(CommonUtil.getMessage("COND_SUFFIX"));
		
			// 해당 작업의 발행 컨디션을 제거 후 오더.
			map.put("data_center", 	strOrgDataCenter);
			map.put("condition", 	strOrgJobName + strCondSuffix);
		
			// 캘린더 선택 시 해당 캘린더의 수행일을 기준으로 오더.
			if ( !strDaysCal.equals("") ) {
				
				map.put("days_cal", strDaysCal);
				map.put("cal_date", DateUtil.addDate(strOrderDate, i));			
				
				CommonBean bean = worksApprovalDocDao.dGetCheckCalendarOrderDate(map);								
				
				// 캘린더 조회 결과 없을 경우 아래와 같이 null 처리 필요
				// 안해주면 오류 발생 (2020.12.23 강명준)
				if ( bean != null ) {
					strDaysCnt = CommonUtil.isNull(bean.getDays_cnt());
				}
			}
			if ( strDaysCnt.equals("Y") || strDaysCnt.equals("") ) {

				// ORDER 실행.
				rMap = emJobOrderDao.jobsOrder(map);

				String rOrderId 	= "";
				String rCode 		= "";
				String rMsg 		= "";
				
				rCode 		= CommonUtil.isNull(rMap.get("rCode"));
				rOrderId 	= CommonUtil.isNull(rMap.get("rOrderId"));
				rMsg 		= CommonUtil.isNull(rMap.get("rMsg"));
				
				if( !"1".equals(rCode)){
					rMap.put("r_code", "-1");
					rMap.put("r_msg", rMsg);
					throw new DefaultServiceException(rMap);
					
				} else {
					
					map.put("seq", 				rOrderId);
					map.put("flag", 			"order_id_update_05");
					map.put("approval_comment", doc05.getJob_name());

					// order 성공이면 order_id를 저장.
					// 사용중이라 map에 put은 임의의 항목으로 설정. (seq, approval_comment)
					worksApprovalDocDao.dPrcDocApproval(map);
					map.put("flag", "");
				}
			}
		}
	
		return rMap;
	}
	
	// 상태 변경
	public static Map jobAction(Map<String, Object> map) throws Exception {

		worksApprovalDocDao = (WorksApprovalDocDao) CommonUtil.getSpringBean("tWorksApprovalDocDao");
		emJobActionDao 		= (EmJobActionDao) CommonUtil.getSpringBean("tEmJobActionDao");
		commonDao 			= (CommonDao) CommonUtil.getSpringBean("commonDao");
		
		String strDocCd = CommonUtil.isNull(map.get("doc_cd"));
		String strDocGb = CommonUtil.isNull(map.get("doc_gb"));
		String strFlag 	= CommonUtil.isNull(map.get("flag"));
		
		Map rMap = new HashMap();
		
		Doc07Bean doc07 = worksApprovalDocDao.dGetDoc07(map);
		
		String strDataCenter	= CommonUtil.isNull(doc07.getData_center());
		String strOrderId		= CommonUtil.isNull(doc07.getOrder_id());					
		String strAfterStatus	= CommonUtil.isNull(doc07.getAfter_status());
		String strJobName		= CommonUtil.isNull(doc07.getJob_name());
		String strApplyCd		= CommonUtil.isNull(doc07.getApply_cd());
		
		map.put("data_center", 	strDataCenter);
		map.put("order_id", 	strOrderId);
		map.put("flag",	 		strAfterStatus);
		map.put("after_status", strAfterStatus);

		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) {
			strDataCenter = strDataCenter.split(",")[1];
		}

		List<CommonBean> dataCenterList = CommonUtil.getDataCenterList();

		for(int i=0;i<dataCenterList.size();i++){
			CommonBean bean = dataCenterList.get(i);

			if(strDataCenter.equals(bean.getData_center())){
				map.put("active_net_name", bean.getActive_net_name());
				map.put("data_center_code", bean.getData_center_code());

				break;
			}
		}
		System.out.println("::getStatusChangeCheck::"+map);
		// 상태 체크
		String strErrorMessage = "";
		
		if(!strApplyCd.equals("02")){
			strErrorMessage = CommonUtil.getStatusChangeCheck(map);
		}
		
		if ( !strErrorMessage.equals("") ) {
			
			Map rMap2 = new HashMap();
			//rMap2.put("r_code","-1");
			rMap2.put("r_code",	"-2");
			rMap2.put("r_msg",	strJobName + ": " + strErrorMessage);
			//rMap2.put("rMsg",	strJobName + ": " + strErrorMessage);
			throw new DefaultServiceException(rMap2);
		}
		
		String strResult 	= "";
		String cmd 			= "";
		
		// DELETE, UNDELETE 명령어는 API 기능에 없으므로 UTIL 사용.
		if ( strAfterStatus.equals("DELETE") || strAfterStatus.equals("UNDELETE") ) {
			
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
			
			try{
				
				if ( strAfterStatus.equals("DELETE") )		cmd = "ctmpsm -UPDATEAJF "+strOrderId+" HOLD \r\n ctmpsm -UPDATEAJF "+strOrderId+" DELETE";
				if ( strAfterStatus.equals("UNDELETE") )	cmd = "ctmpsm -UPDATEAJF "+strOrderId+" UNDELETE";
				
				if ( !strHost.equals("") ) {
					
					if( "S".equals(strAccessGubun) ){
						Ssh2Util su = new Ssh2Util(strHost, iPort, strUserId, strUserPw, cmd, "UTF-8");
						strResult = su.getOutput();
					}else{
						TelnetUtil tu = new TelnetUtil(strHost, iPort, strUserId, strUserPw, cmd);	
						strResult = tu.getOutput();
					}
				}
				
				if ( strResult.indexOf("successfully") > -1 ) {
					rMap.put("r_code", 	"1");
					rMap.put("rCode", 	"1");
					rMap.put("r_msg", 	"DEBUG.01");
					//rMap.put("rMsg", 	"처리 완료");
					
				} else {
					rMap.put("r_code", 	"-2");
					rMap.put("rCode", 	"-2");
					rMap.put("r_msg", 	strAfterStatus + " 유틸리티 호출 실패!\n" + strResult + "\n");
					//rMap.put("rMsg", 	strAfterStatus + "유틸리티 호출 실패!");
				}
				
			}catch(Exception e){
				logger.error(e.getMessage());
			}
			
		} else {

			rMap = emJobActionDao.jobAction(map);
		}
		
		return rMap;
	}
	
	// PostProc 셋팅
	public static void setPostProc(Doc01Bean doc01Bean) throws Exception {
		
		StringBuffer stringB = new StringBuffer();
		
		String strTpostproc			= CommonUtil.isNull(doc01Bean.getT_postproc());
		String strLateSub			= CommonUtil.isNull(doc01Bean.getLate_sub());
		String strLateTime			= CommonUtil.isNull(doc01Bean.getLate_time());
		String strLateExec			= CommonUtil.isNull(doc01Bean.getLate_exec());
		String strSuccessSmsYn		= CommonUtil.isNull(doc01Bean.getSuccess_sms_yn());
		
		if ( !strTpostproc.equals("") ) {
			stringB.append(strTpostproc);
			stringB.append("|");
		}
		
		if ( !strLateSub.equals("") ) {
			stringB.append("late_submission,"+strLateSub+",EM,urgent,LATE_SUB");
			stringB.append("|");
		}
		
		if ( !strLateTime.equals("") ) {
			stringB.append("late_time,"+strLateTime+",EM,urgent,LATE_TIME");
			stringB.append("|");
		}
		
		if ( !strLateExec.equals("") ) {
			//자동 꺽새 기입
			strLateExec = ">"+strLateExec;
			stringB.append("execution_time,"+strLateExec+",EM,urgent,LATE_EXEC");
			stringB.append("|");
		}
		
		if ( strSuccessSmsYn.equals("Y") ) {
			stringB.append("ok,,EM,urgent,Ended OK");
			stringB.append("|");
		}
		
		if ( !stringB.toString().equals("") ) {
			doc01Bean.setT_postproc(stringB.toString());
		}
	}

	// 오류 처리
	public static Map jobErrorDescUdt(Map<String, Object> map) throws Exception {

		Map<String, Object> ArrMap 	= new HashMap<String, Object>();
		Map rMap = new HashMap();

		map.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

		try {

			EmAlertService emAlertService = (EmAlertService) CommonUtil.getSpringBean("aEmAlertService");

			String strAlarmCd 	= CommonUtil.isNull(map.get("alarm_cd"));
			String strUserCd 	= CommonUtil.isNull(map.get("s_user_cd"));

			ArrMap.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
			ArrMap.put("flag", 				"udt_all");
			ArrMap.put("user_cd", 			CommonUtil.isNull(map.get("user_cd")));
			ArrMap.put("alarm_cd", 			strAlarmCd);
			ArrMap.put("s_user_cd", 		strUserCd);
			ArrMap.put("action_yn", 		"Y");
			ArrMap.put("error_description", CommonUtil.isNull(map.get("error_description")));
			//ArrMap.put("confirm_yn", 		CommonUtil.isNull((paramMap).get("confirm_yn")));
			//ArrMap.put("action_gubun",	 	CommonUtil.isNull((paramMap).get("action_gubun")));

			rMap = emAlertService.dPrcAlarm(ArrMap);

		} catch (Exception e) {

			if ("".equals(CommonUtil.isNull(rMap.get("r_code"))))
				rMap.put("r_code", "-1");
			if ("".equals(CommonUtil.isNull(rMap.get("r_msg"))))
				rMap.put("r_msg", "ERROR.01");

			logger.error(e.getMessage());
		}

		return rMap;
	}
}