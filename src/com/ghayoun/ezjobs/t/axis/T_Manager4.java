package com.ghayoun.ezjobs.t.axis;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

import com.ghayoun.ezjobs.comm.domain.CommonBean;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bmc.ctmem.emapi.EMXMLInvoker;
import com.bmc.ctmem.emapi.InvokeException;
import com.bmc.ctmem.schema900.*;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.common.util.DefaultServiceException;
import com.ghayoun.ezjobs.common.util.Ssh2Util;
import com.ghayoun.ezjobs.common.util.SshUtil;
import com.ghayoun.ezjobs.common.util.TelnetUtil;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.TagsBean;

public class T_Manager4 {	
		
	protected final Log logger 	= LogFactory.getLog(getClass());

	//
	public static String getUserToken() throws IOException, Exception {
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String strUserToken = "";

		try {
			CommonUtil.emLogin(request);
			strUserToken = CommonUtil.isNull(request.getSession().getAttribute("USER_TOKEN"));
			
		} catch (ServletException e) {  
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return strUserToken;
	}
    public String invokeRequest(String request) {
    	
        Collection requests = new LinkedList();
        
        String password 		= "";
        String encoded_passwd 	= "";
        
        if (request.length() > 0) {
            requests.add(request.trim());
        }

        Iterator iter = requests.iterator();
        
        String response = "INVALID REQUEST !!";

        while (iter.hasNext()) {
        	
        	request = (String) iter.next();
        	
//        	EMXMLInvoker invoker = new EMXMLInvoker(new GSRComponent(CommonUtil.isNull(CommonUtil.getMessage("CTM_NM"))));
        	
        	Properties props = new Properties(); 
        	props.setProperty("ServerURL", 	CommonUtil.isNull(CommonUtil.getMessage("CTM_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB"))));
        	props.setProperty("ConfigDir", 	CommonUtil.isNull(CommonUtil.getDefaultFilePath()));
        	props.setProperty("ConfigFile", "communication");
        	
        	EMXMLInvoker invoker = new EMXMLInvoker();
        	String[] args = null;
        	invoker.init(args, props);
        	
            try {
            	
				password = GetValFromXml(request,"password");
				
				if (password.length() > 0 && request.indexOf("request_register") > 0) {
					
					encoded_passwd 	= invoker.BuildPasswordString(password);					
					request 		= request.replaceFirst(password, encoded_passwd);
//					request 		= request.substring(0, request.indexOf("<ctmem:password>")) + "<ctmem:password>" + encoded_passwd + request.substring(request.indexOf("</ctmem:password>"), request.length());
				}
				
				// API request 구문 로깅
				CommonUtil.ctmApiLogging("request : " + request);
				
				response = invoker.invoke(request);
				
				// API response 구문 로깅
				CommonUtil.ctmApiLogging("response : " + response);
            }
            
            catch (InvokeException ex) {
            	
            	logger.error("getMajorCode() : " + ex.getMajorCode() );
            	logger.error("getMinorCode() : " + ex.getMinorCode());
            	logger.error("getMessage() : " + ex.getMessage() );
            	logger.error("getReason() : " + ex.getReason() );

            	response = ex.getReason();
            }
            catch (Exception ex) {
                
            }            
        }        
        
        logger.debug("최종결과값 : " + response);
        
        return response;
    }
    
    public static String GetValFromXml (String buffer, String token_name)	{
		final String TOKEN_TAG = token_name + ">";
		int nTokenPos = buffer.indexOf(TOKEN_TAG);
		if (nTokenPos > 0) {
			String val = buffer.substring(nTokenPos + TOKEN_TAG.length(),
				buffer.indexOf("<", nTokenPos + TOKEN_TAG.length()));
			return val;
		}		
		return "";
	}
	
	// 작업 등록 처리. ( 기존에는 한개로 처리 하였으나 7.0 API 를 사용하면서 여러개로 나뉘어 짐.)
	public Map defCreateJobs(Map map){

		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");

		List alDocList 				= (List)map.get("alDocList");
		
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strTableCnt			= CommonUtil.isNull(docBean.getTable_cnt());
		String strTableType			= CommonUtil.isNull(docBean.getTable_type());
		
		map.put("table_type", strTableType);
		
		try {
			
			String strReqXml = "";
			
			System.out.println("strTaskType : " + strTaskType);
			System.out.println("strTableCnt : " + strTableCnt);
			System.out.println("strTableType : " + strTableType);
			
			if ( alDocList != null ) {							// 엑셀 일괄 등록.				
				strReqXml = defAddBatchJobs(map);
			} else if ( strTaskType.equals("SMART Table") ) {	// 스마트 테이블 등록.
				strReqXml = defCreateTable(map);
			} else if ( strTaskType.equals("Sub-Table") ) {		// 서브 테이블 등록.
				//strReqXml = defAddTable(map);			
			} else if ( strTableCnt.equals("0") ) {				// 일반 테이블 신규 & 작업 등록.
				strReqXml = defCreateTableJobs(map);		
			} else if ( strTableType.equals("2") ) {			// 스마트 테이블 OR 서브 테이블 안에 작업 등록.
				strReqXml = defAddJobs(map);				
			} else {											// 일반 테이블 안에 작업 등록. (스키마 700 에는 없으므로 예전 버전으로 처리)
				strReqXml = defAddJobs(map);
			}	
			
			logger.info("strReqXml : " + strReqXml);
		
			String strResData 	= invokeRequest(strReqXml);
			
			logger.info("strResData : " + strResData);
			
			String strResXml 	= "";

			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				System.out.println("에러 시작");
				
				System.out.println("map"+map);
				
				map = CommonUtil.apiErrorProcess(strResData);
				
				System.out.println("에러 종료");
				
			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);
				
			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.				
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);				
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				// [org.apache.xerces.impl.io.MalformedByteSequenceException: 1-바이트 UTF-8 순서 중 1바이트가 올바르지 않습니다.]
				// LANG=C 환경에서 위의 에러가 나면서 Exception 떨어지기 때문에 table_name 제거해보았다.
				String strResXml2 	= strResXml.substring(0, strResXml.indexOf("<ctmem:folder_name>")+19);				
				strResXml2 			+= strResXml.substring(strResXml.indexOf("</ctmem:folder_name>"), strResXml.length());
				
				// 언마샬링 해서 값을 담는다.
				if ( strTaskType.equals("SMART Table") || strTableCnt.equals("0") ) {	// 스마트 테이블 등록.
		            JAXBElement<ResponseDefCreateFolderType> dataRoot = (JAXBElement<ResponseDefCreateFolderType>) CommonUtil.unmarshaller(ResponseDefCreateFolderType.class, strResXml2);
		            
		            map.put("rCode", "1");
					map.put("rType", "response_def_create_table");
					map.put("rObject", dataRoot);
		            
				} else if ( strTaskType.equals("Sub-Table") ) {		// 서브 테이블 등록.
		            JAXBElement<ResponseDefAddFolderType> dataRoot = (JAXBElement<ResponseDefAddFolderType>) CommonUtil.unmarshaller(ResponseDefAddFolderType.class, strResXml2);
		            
		            map.put("rCode", "1");
					map.put("rType", "response_def_add_table");
					map.put("rObject", dataRoot);

				} else if ( strTableType.equals("2") ) {	// 스마트 테이블 OR 서브 테이블 안에 작업 등록.
		            JAXBElement<ResponseDefAddJobsType> dataRoot = (JAXBElement<ResponseDefAddJobsType>) CommonUtil.unmarshaller(ResponseDefAddJobsType.class, strResXml2);
		            
		            map.put("rCode", "1");
					map.put("rType", "response_def_add_jobs");
					map.put("rObject", dataRoot);
				
				} else {									// 일반 테이블 안에 작업 등록. (스키마 700 에는 없으므로 예전 버전으로 처리)
		            JAXBElement<ResponseDefAddJobsType> dataRoot = (JAXBElement<ResponseDefAddJobsType>) CommonUtil.unmarshaller(ResponseDefAddJobsType.class, strResXml2);
		            
		            map.put("rCode", "1");
					map.put("rType", "response_def_create_jobs");
					map.put("rObject", dataRoot);
				}
				
			}
			
		} catch (JAXBException e) {
			
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		
		} catch (Exception e) {
			
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", e.toString());
		}
		
		return map;
	}
	
	// 스마트 테이블 등록.
	public String defCreateTable(Map map) throws Exception {

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		
		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");
		List alTagList 				= (List)map.get("alTagList");
		TagsBean tagsBean 			= null;
		String strReqXml			= "";
		
		String strDataCenter		= CommonUtil.isNull(docBean.getData_center());
		String strDataCenterName	= CommonUtil.isNull(docBean.getData_center_name());
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		if ( !strDataCenterName.equals("") && strDataCenterName.indexOf("-") > -1 ) { 
			strDataCenterName = strDataCenterName.split("-")[1];
		}
		
		String strJobName			= CommonUtil.isNull(docBean.getJob_name());
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strApplication		= CommonUtil.isNull(docBean.getApplication());		
		String strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib(), "FILE_PATH");		// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
		String strMemName			= CommonUtil.isNull(docBean.getMem_name(), "FILE_NAME");	// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
		String strOwner				= CommonUtil.isNull(docBean.getOwner());
		String strAuthor			= CommonUtil.isNull(docBean.getAuthor());
		String strDescription		= CommonUtil.isNull(docBean.getDescription());
		String strCommand			= CommonUtil.isNull(docBean.getCommand());
		String strTableName			= CommonUtil.isNull(docBean.getTable_name());
		String strNodeId			= CommonUtil.isNull(docBean.getNode_id());
		String strMultiagent		= CommonUtil.isNull(docBean.getMultiagent());
		String strConfirmFlag		= CommonUtil.isNull(docBean.getConfirm_flag());
		String strPriority			= CommonUtil.isNull(docBean.getPriority());
		String strCritical			= CommonUtil.isNull(docBean.getCritical());
		String strTimeFrom			= CommonUtil.isNull(docBean.getTime_from());
		String strTimeUntil			= CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getTime_until()));
		String strTimeZone			= CommonUtil.isNull(docBean.getTime_zone());
		String strCyclic			= CommonUtil.isNull(docBean.getCyclic());
		String strRerunInterval		= CommonUtil.isNull(docBean.getRerun_interval());
		String strRerunIntervalTime	= CommonUtil.isNull(docBean.getRerun_interval_time());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		String strRerunMax			= CommonUtil.isNull(docBean.getRerun_max());
		String strMaxWait			= CommonUtil.isNull(docBean.getMax_wait());
		String strTconditionIn		= CommonUtil.isNull(docBean.getT_conditions_in());
		String strTconditionOut		= CommonUtil.isNull(docBean.getT_conditions_out());
		//String strTresourcesQ		= CommonUtil.getQ_Resources(strDataCenterName);
		String strTresourcesQ		= CommonUtil.isNull(docBean.getT_resources_q());
		String strTresourcesC		= CommonUtil.isNull(docBean.getT_resources_c());
		String strTset				= CommonUtil.isNull(docBean.getT_set());
		String strTsteps			= CommonUtil.isNull(docBean.getT_steps());		
		String strTpostproc			= CommonUtil.isNull(docBean.getT_postproc());
		String strCyclicType		= CommonUtil.isNull(docBean.getCyclic_type());
		String strIntervalSequence	= CommonUtil.isNull(docBean.getInterval_sequence());
		String strTolerance			= CommonUtil.isNull(docBean.getTolerance());
		String strSpecificTimes		= CommonUtil.isNull(docBean.getSpecific_times());
		String strUserDaily			= CommonUtil.isNull(docBean.getUser_daily());
		String strCalendarNm		= CommonUtil.isNull(docBean.getCalendar_nm());
		
		String strApplType			= "OS";
		
		// START 컨디션 자동 설정
		//strTconditionIn				= CommonUtil.getI_Conditions(strDataCenterName, strTconditionIn, strJobName);
		
		try {
		
			JAXBContext context 				= JAXBContext.newInstance(RequestDefCreateFolderType.class);
			RequestDefCreateFolderType reqType 	= new RequestDefCreateFolderType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			reqType.setUserToken(strUserToken);
			
			// 스마트 테이블 설정.
			SmartFolderType smartTableType = new SmartFolderType();
			smartTableType.setControlM(strDataCenter);
			smartTableType.setFolderName(strTableName);
			smartTableType.setOrderMethod(strUserDaily);
			
			IntervalSequenceType intervalSequenceType = new IntervalSequenceType();

			if( strIntervalSequence.length() > 0 ) {
				String[] t_interval_sequence = strIntervalSequence.split("[,]");				
				if ( null!=t_interval_sequence && 0<t_interval_sequence.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_interval_sequence.length; i++ ) {	
					
						alTmp.add("+" + t_interval_sequence[i] + strRerunIntervalTime);
					}
					
					intervalSequenceType.setIntervalItem(alTmp);
				}				
			}
			
			SpecificTimesType specificTimesType = new SpecificTimesType();

			if( strSpecificTimes.length() > 0 ) {
				String[] t_specific_time = strSpecificTimes.split("[,]");				
				if ( null!=t_specific_time && 0<t_specific_time.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_specific_time.length; i++ ) {	
					
						alTmp.add(t_specific_time[i]);
					}
					
					specificTimesType.setSpecificTime(alTmp);
				}				
			}	
			
			// 스마트 테이블 속성 설정.
			SmartFolderAttributesType smartTableAttributesType = new SmartFolderAttributesType();
//			smartTableAttributesType.setApplication("");
//			smartTableAttributesType.setSubApplication("");
			if ( !strJobName.equals("") ) 			smartTableAttributesType.setJobName(strJobName);
			//if ( !strTaskType.equals("") ) 			smartTableAttributesType.setTaskType(ActiveTaskType.fromValue(strTaskType));
			if ( !strApplication.equals("") ) 		smartTableAttributesType.setApplication(strApplication);
			if ( !strGroupName.equals("") ) 		smartTableAttributesType.setSubApplication(strGroupName);
			if ( !strMemLib.equals("") ) 			smartTableAttributesType.setMemLib(strMemLib);
			if ( !strMemName.equals("") ) 			smartTableAttributesType.setMemName(strMemName);
			if ( !strOwner.equals("") ) 			smartTableAttributesType.setRunAs(strOwner);
			if ( !strAuthor.equals("") ) 			smartTableAttributesType.setCreatedBy(strAuthor);
			if ( !strDescription.equals("") ) 		smartTableAttributesType.setDescription(strDescription);
			if ( !strCommand.equals("") ) 			smartTableAttributesType.setCommand(strCommand);
			//if ( !strTableName.equals("") ) 		smartTableAttributesType.setOrderTable(strTableName);
			if ( !strNodeId.equals("") ) 			smartTableAttributesType.setNodeId(strNodeId);
			if ( !strMultiagent.equals("") ) 		smartTableAttributesType.setMultiagent(YesNoType.fromValue(CommonUtil.getMessage("JOB.MULTIAGENT."+strMultiagent)));
			if ( !strConfirmFlag.equals("") ) 		smartTableAttributesType.setConfirmFlag(YesNoType.fromValue(CommonUtil.getMessage("JOB.CONFIRM_FLAG."+strConfirmFlag)));
			if ( !strPriority.equals("") ) 			smartTableAttributesType.setPriority(strPriority);
			if ( !strCritical.equals("") ) 			smartTableAttributesType.setCritical(YesNoType.fromValue(CommonUtil.getMessage("JOB.CRITICAL."+strCritical)));
			if ( !strTimeFrom.equals("") ) 			smartTableAttributesType.setTimeFrom(strTimeFrom);
			if ( !strTimeUntil.equals("") ) 		smartTableAttributesType.setTimeUntil(strTimeUntil);
			if ( !strTimeZone.equals("") ) 			smartTableAttributesType.setTimeZone(strTimeZone);
			if ( !strCyclic.equals("") ) 			smartTableAttributesType.setCyclic(YesNoType.fromValue(CommonUtil.getMessage("JOB.CYCLIC."+strCyclic)));
			//if ( !strRerunInterval.equals("") ) 	smartTableAttributesType.setRerunInterval(strRerunInterval + strRerunIntervalTime);
			if ( !strRerunInterval.equals("") ) 	smartTableAttributesType.setRerunInterval(strRerunInterval);
			if ( !strCountCyclicFrom.equals("") ) 	smartTableAttributesType.setCountCyclicFrom(StartEndTargetType.fromValue(strCountCyclicFrom));
			if ( !strRerunMax.equals("") ) 			smartTableAttributesType.setRerunMax(strRerunMax);
			if ( !strMaxWait.equals("") ) 			smartTableAttributesType.setMaxWait(strMaxWait);
			if ( !strCyclicType.equals("") ) 		smartTableAttributesType.setCyclicType(CyclicTypeType.fromValue(CommonUtil.getMessage("JOB.CYCLIC_TYPE."+strCyclicType)));
			if ( !strIntervalSequence.equals("") ) 	smartTableAttributesType.setIntervalSequence(intervalSequenceType);
			if ( !strTolerance.equals("") ) 		smartTableAttributesType.setTolerance(strTolerance);
			if ( !strSpecificTimes.equals("") ) 	smartTableAttributesType.setSpecificTimes(specificTimesType);
			
			smartTableAttributesType.setApplicationType(strApplType);
			
			// In Condition.
			if ( strTconditionIn.length() > 0 ) {
				smartTableAttributesType.setInConditions(getInConditions(strTconditionIn));
			}
			
			// Out Condition.
			if ( strTconditionOut.length() > 0 ) {
				smartTableAttributesType.setOutConditions(getOutConditions(strTconditionOut));
			}
			
			// Quantitatvie Resouce.
			// Folder 생성 시 Quantitatvie Resouce 항목 없는 듯.. 
			/*
			if ( strTresourcesQ.length() > 0 ) {
				smartTableAttributesType.setQuantitativeResources(getQresources(strTresourcesQ));
			}
			*/
			
			// Control Resouce.
			if ( strTresourcesC.length() > 0 ) {
				smartTableAttributesType.setControlResources(getCresources(strTresourcesC));
			}
			
			// Set 변수.
			if ( strTset.length() > 0 ) {
				smartTableAttributesType.setVariableAssignments(getVariableAssignments(strTset));
			}
			
			// Step.
			if ( strTsteps.length() > 0 ) {				
				smartTableAttributesType.setOnDoStatements(getOnDoStatements(strTsteps));				
			}
			
			// PostProc.
			if ( strTpostproc.length() > 0 ) {				
				smartTableAttributesType.setShouts(getShouts(strTpostproc));				
			}
			
			if ( !strCalendarNm.equals("") ) {
				
				ArrayList<RuleBasedCalType> alTmp 				= new ArrayList();				
				RuleBasedCalType ruleBasedCalType 				= new RuleBasedCalType();
				FolderRuleBasedCalsType tableRuleBasedCalsType 	= new FolderRuleBasedCalsType();
				
				ruleBasedCalType.setRuleBasedCalName(strCalendarNm);
				alTmp.add(ruleBasedCalType);
				
				tableRuleBasedCalsType.setRuleBasedCal(alTmp);				
				smartTableAttributesType.setSmartFolderRuleBasedCals(tableRuleBasedCalsType);
				
			}

		    smartTableType.setFolderAttributes(smartTableAttributesType);
	
			reqType.setSMARTFolder(smartTableType);	
	
			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
			
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			strReqXml = CommonUtil.marshllingAdd(sw);
		
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		
		return strReqXml;
	}
	
	// 일반 테이블 신규 & 작업 등록.
	public String defCreateTableJobs(Map map) throws Exception{

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		
		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");
		List alTagList 				= (List)map.get("alTagList");
		TagsBean tagsBean 			= null;
		String strReqXml			= "";
		
		String strDataCenter		= CommonUtil.isNull(docBean.getData_center());
		String strDataCenterName	= CommonUtil.isNull(docBean.getData_center_name());		
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		if ( !strDataCenterName.equals("") && strDataCenterName.indexOf("-") > -1 ) { 
			strDataCenterName = strDataCenterName.split("-")[1];
		}
		
		String strJobName			= CommonUtil.isNull(docBean.getJob_name());
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strApplication		= CommonUtil.isNull(docBean.getApplication());
		String strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib(), "FILE_PATH");		// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
		String strMemName			= CommonUtil.isNull(docBean.getMem_name(), "FILE_NAME");	// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
		String strOwner				= CommonUtil.isNull(docBean.getOwner());
		String strAuthor			= CommonUtil.isNull(docBean.getAuthor());
		String strDescription		= CommonUtil.isNull(docBean.getDescription());
		String strCommand			= CommonUtil.isNull(docBean.getCommand());
		String strTableName			= CommonUtil.isNull(docBean.getTable_name());
		String strNodeId			= CommonUtil.isNull(docBean.getNode_id());
		String strMultiagent		= CommonUtil.isNull(docBean.getMultiagent());
		String strConfirmFlag		= CommonUtil.isNull(docBean.getConfirm_flag());
		String strPriority			= CommonUtil.isNull(docBean.getPriority());
		String strCritical			= CommonUtil.isNull(docBean.getCritical());
		String strTimeFrom			= CommonUtil.isNull(docBean.getTime_from());
		String strTimeUntil			= CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getTime_until()));
		String strTimeZone			= CommonUtil.isNull(docBean.getTime_zone());
		String strCyclic			= CommonUtil.isNull(docBean.getCyclic());
		String strRerunInterval		= CommonUtil.isNull(docBean.getRerun_interval());
		String strRerunIntervalTime	= CommonUtil.isNull(docBean.getRerun_interval_time());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		String strRerunMax			= CommonUtil.isNull(docBean.getRerun_max());
		String strMaxWait			= CommonUtil.isNull(docBean.getMax_wait());
		String strTconditionIn		= CommonUtil.isNull(docBean.getT_conditions_in());
		String strTconditionOut		= CommonUtil.isNull(docBean.getT_conditions_out());
		//String strTresourcesQ		= CommonUtil.getQ_Resources(strDataCenterName);;
		String strTresourcesQ		= CommonUtil.isNull(docBean.getT_resources_q());
		String strTresourcesC		= CommonUtil.isNull(docBean.getT_resources_c());
		String strTset				= CommonUtil.isNull(docBean.getT_set());
		String strTsteps			= CommonUtil.isNull(docBean.getT_steps());		
		String strTpostproc			= CommonUtil.isNull(docBean.getT_postproc());
		String strTtagName			= CommonUtil.isNull(docBean.getT_tag_name());
		String strCyclicType		= CommonUtil.isNull(docBean.getCyclic_type());
		String strIntervalSequence	= CommonUtil.isNull(docBean.getInterval_sequence());
		String strTolerance			= CommonUtil.isNull(docBean.getTolerance());
		String strSpecificTimes		= CommonUtil.isNull(docBean.getSpecific_times());
		String strUserDaily			= CommonUtil.isNull(docBean.getUser_daily());
		
		String strApplType			= "OS";
		
		String strTgeneralDate		= CommonUtil.isNull(docBean.getT_general_date());
		String strMonthDays			= CommonUtil.isNull(docBean.getMonth_days());
		String strScheduleAndOr		= CommonUtil.isNull(docBean.getSchedule_and_or());
		String strWeekDays			= CommonUtil.isNull(docBean.getWeek_days());
		String strDaysCal			= CommonUtil.isNull(docBean.getDays_cal());
		String strWeeksCal			= CommonUtil.isNull(docBean.getWeeks_cal());
		String strRetro				= CommonUtil.isNull(docBean.getRetro());
		String strMonth_1			= CommonUtil.isNull(docBean.getMonth_1(), "1");
		String strMonth_2			= CommonUtil.isNull(docBean.getMonth_2(), "1");
		String strMonth_3			= CommonUtil.isNull(docBean.getMonth_3(), "1");
		String strMonth_4			= CommonUtil.isNull(docBean.getMonth_4(), "1");
		String strMonth_5			= CommonUtil.isNull(docBean.getMonth_5(), "1");
		String strMonth_6			= CommonUtil.isNull(docBean.getMonth_6(), "1");
		String strMonth_7			= CommonUtil.isNull(docBean.getMonth_7(), "1");
		String strMonth_8			= CommonUtil.isNull(docBean.getMonth_8(), "1");
		String strMonth_9			= CommonUtil.isNull(docBean.getMonth_9(), "1");
		String strMonth_10			= CommonUtil.isNull(docBean.getMonth_10(), "1");
		String strMonth_11			= CommonUtil.isNull(docBean.getMonth_11(), "1");
		String strMonth_12			= CommonUtil.isNull(docBean.getMonth_12(), "1");
		String strActiveFrom		= CommonUtil.isNull(docBean.getActive_from());
		String strActiveTill		= CommonUtil.isNull(docBean.getActive_till());
		String strConfCal			= CommonUtil.isNull(docBean.getConf_cal());
		String strShift				= CommonUtil.isNull(docBean.getShift());
		String strShiftNum			= CommonUtil.isNull(docBean.getShift_num());
		
		String strShiftMent = "";
		if ( !strShift.equals("") ) {
			if ( strShift.equals("Ignore Job") ) {
				strShiftMent = "ignore_job";
			} else if ( strShift.equals("Next Day") ) {
				strShiftMent = "next_day";
			} else if ( strShift.equals("Prev Day") ) {
				strShiftMent = "prev_day";
			} else if ( strShift.equals("No Confcal") ) {
				strShiftMent = "no_confcal";
			}			
		}
		
		logger.debug("======================================================================================");
		logger.debug("strConfCal      :" + strConfCal);
		logger.debug("strShiftMent      :" + strShiftMent);
		logger.debug("strShiftNum      :" + strShiftNum);
		
		
		logger.debug("======================================================================================");
		
		
		try {
		
			JAXBContext context 				= JAXBContext.newInstance(RequestDefCreateFolderType.class);
			RequestDefCreateFolderType reqType 	= new RequestDefCreateFolderType();
			java.io.StringWriter sw 			= new java.io.StringWriter();		
			
			reqType.setUserToken(strUserToken);
			
			// 테이블 설정.
			FolderType folderType = new FolderType();
			folderType.setControlM(strDataCenter);
			folderType.setFolderName(strTableName);
			folderType.setOrderMethod(strUserDaily);

			IntervalSequenceType intervalSequenceType = new IntervalSequenceType();

			if( strIntervalSequence.length() > 0 ) {
				String[] t_interval_sequence = strIntervalSequence.split("[,]");
				if ( null!=t_interval_sequence && 0<t_interval_sequence.length ) {
					ArrayList<String> alTmp = new ArrayList();
					for ( int i = 0; i < t_interval_sequence.length; i++ ) {
					
						alTmp.add("+" + t_interval_sequence[i] + strRerunIntervalTime);
					}
					
					intervalSequenceType.setIntervalItem(alTmp);
				}
			}
			
			SpecificTimesType specificTimesType = new SpecificTimesType();

			if( strSpecificTimes.length() > 0 ) {
				String[] t_specific_time = strSpecificTimes.split("[,]");				
				if ( null!=t_specific_time && 0<t_specific_time.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_specific_time.length; i++ ) {	
					
						alTmp.add(t_specific_time[i]);
					}
					
					specificTimesType.setSpecificTime(alTmp);
				}				
			}	

			// 작업 속성 설정.
			DefJobType defJobType = new DefJobType();
			
			if ( !strJobName.equals("") ) 			defJobType.setJobName(strJobName);
			if ( !strTaskType.equals("") ) 			defJobType.setTaskType(DefTaskType.fromValue(strTaskType.toLowerCase()));
			if ( !strApplication.equals("") ) 		defJobType.setApplication(strApplication);
			if ( !strGroupName.equals("") ) 		defJobType.setSubApplication(strGroupName);
			if ( !strMemLib.equals("") ) 			defJobType.setMemLib(strMemLib);
			if ( !strMemName.equals("") ) 			defJobType.setMemName(strMemName);
			if ( !strOwner.equals("") ) 			defJobType.setRunAs(strOwner);
			if ( !strAuthor.equals("") ) 			defJobType.setCreatedBy(strAuthor);
			if ( !strDescription.equals("") ) 		defJobType.setDescription(strDescription);
			if ( !strCommand.equals("") ) 			defJobType.setCommand(strCommand);
			if ( !strNodeId.equals("") ) 			defJobType.setNodeId(strNodeId);
			if ( !strMultiagent.equals("") ) 		defJobType.setMultiagent(YesNoType.fromValue(CommonUtil.getMessage("JOB.MULTIAGENT."+strMultiagent)));
			if ( !strConfirmFlag.equals("") ) 		defJobType.setConfirmFlag(YesNoType.fromValue(CommonUtil.getMessage("JOB.CONFIRM_FLAG."+strConfirmFlag)));
			if ( !strPriority.equals("") ) 			defJobType.setPriority(strPriority);
			if ( !strCritical.equals("") ) 			defJobType.setCritical(YesNoType.fromValue(CommonUtil.getMessage("JOB.CRITICAL."+strCritical)));
			if ( !strTimeFrom.equals("") ) 			defJobType.setTimeFrom(strTimeFrom);
			if ( !strTimeUntil.equals("") ) 		defJobType.setTimeUntil(strTimeUntil);
			if ( !strTimeZone.equals("") ) 			defJobType.setTimeZone(strTimeZone);
			if ( !strCyclic.equals("") ) 			defJobType.setCyclic(YesNoType.fromValue(CommonUtil.getMessage("JOB.CYCLIC."+strCyclic)));
			//if ( !strRerunInterval.equals("") ) 	defJobType.setRerunInterval(strRerunInterval + strRerunIntervalTime);
			if ( !strRerunInterval.equals("") ) 	defJobType.setRerunInterval(strRerunInterval);
			if ( !strCountCyclicFrom.equals("") ) 	defJobType.setCountCyclicFrom(StartEndTargetType.fromValue(strCountCyclicFrom));
			if ( !strRerunMax.equals("") ) 			defJobType.setRerunMax(strRerunMax);
			if ( !strMaxWait.equals("") ) 			defJobType.setMaxWait(strMaxWait);
			if ( !strCyclicType.equals("") ) 		defJobType.setCyclicType(CyclicTypeType.fromValue(CommonUtil.getMessage("JOB.CYCLIC_TYPE."+strCyclicType)));
			if ( !strIntervalSequence.equals("") ) 	defJobType.setIntervalSequence(intervalSequenceType);
			if ( !strTolerance.equals("") ) 		defJobType.setTolerance(strTolerance);
			if ( !strSpecificTimes.equals("") ) 	defJobType.setSpecificTimes(specificTimesType);
			
			defJobType.setApplicationType(strApplType);
			
			// 스케줄.
			if( strTgeneralDate.length() > 0 ) {
				strTgeneralDate = strTgeneralDate.replaceAll(" ", "").replaceAll(",", "|");
				String[] t_general_date = strTgeneralDate.split("[|]");				
				if ( null!=t_general_date && 0<t_general_date.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_general_date.length; i++ ) {	
					
						alTmp.add(t_general_date[i]);	
					}
					
					DatesType datesType = new DatesType();
					datesType.setDate(alTmp);
					
					defJobType.setDates(datesType);
				}
				
			} else {
				
				if ( !strMonthDays.equals("") ) 		defJobType.setMonthDays(strMonthDays);
				if ( !strScheduleAndOr.equals("") ) 	defJobType.setAndOr(AndOrType.fromValue(CommonUtil.getMessage("JOB.AND_OR."+strScheduleAndOr)));
				if ( !strWeekDays.equals("") ) 			defJobType.setWeekDays(strWeekDays);
				if ( !strDaysCal.equals("") ) 			defJobType.setDaysCal(strDaysCal);
				if ( !strWeeksCal.equals("") ) 			defJobType.setWeeksCal(strWeeksCal);
				if ( !strRetro.equals("") ) 			defJobType.setRetro(YesNoType.fromValue(CommonUtil.getMessage("JOB.RETRO."+strRetro)));
				if ( !strMonth_1.equals("") ) 			defJobType.setJAN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_1)));    				
				if ( !strMonth_2.equals("") ) 			defJobType.setFEB(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_2)));    				
				if ( !strMonth_3.equals("") ) 			defJobType.setMAR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_3)));
				if ( !strMonth_4.equals("") ) 			defJobType.setAPR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_4)));
				if ( !strMonth_5.equals("") ) 			defJobType.setMAY(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_5)));
				if ( !strMonth_6.equals("") ) 			defJobType.setJUN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_6)));
				if ( !strMonth_7.equals("") ) 			defJobType.setJUL(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_7)));
				if ( !strMonth_8.equals("") ) 			defJobType.setAUG(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_8)));
				if ( !strMonth_9.equals("") ) 			defJobType.setSEP(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_9)));
				if ( !strMonth_10.equals("") ) 			defJobType.setOCT(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_10)));
				if ( !strMonth_11.equals("") ) 			defJobType.setNOV(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_11)));
				if ( !strMonth_12.equals("") ) 			defJobType.setDEC(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_12)));
				if ( !strActiveFrom.equals("") ) 		defJobType.setActiveFrom(strActiveFrom);
				if ( !strActiveTill.equals("") ) 		defJobType.setActiveUntil(strActiveTill);
				if ( !strConfCal.equals("") ) 			defJobType.setConfCal(strConfCal);
				if ( !strShift.equals("") ) 			defJobType.setShift(strShiftMent);
				if ( !strShiftNum.equals("") ) 			defJobType.setShiftNum(strShiftNum);
			}
		
			// In Condition.
			if ( strTconditionIn.length() > 0 ) {
				defJobType.setInConditions(getInConditions(strTconditionIn));
			}
			
			// Out Condition.
			if ( strTconditionOut.length() > 0 ) {
				defJobType.setOutConditions(getOutConditions(strTconditionOut));
			}
			
			// Quantitatvie Resouce.
			if ( strTresourcesQ.length() > 0 ) {
				defJobType.setQuantitativeResources(getQresources(strTresourcesQ));
			}
			
			// Control Resouce.
			if ( strTresourcesC.length() > 0 ) {
				defJobType.setControlResources(getCresources(strTresourcesC));
			}
			
			// Set 변수.
			if ( strTset.length() > 0 ) {
				defJobType.setVariableAssignments(getVariableAssignments(strTset));
			}
			
			// Step.
			if ( strTsteps.length() > 0 ) {
				defJobType.setOnDoStatements(getOnDoStatements(strTsteps));
			}
			
			// PostProc.
			if ( strTpostproc.length() > 0 ) {				
				defJobType.setShouts(getShouts(strTpostproc));				
			}

		    // Tag.
		    if ( CommonUtil.isNull(strTtagName).length() > 0 ) {
			    String[] t_tag_name = strTtagName.split("[|]");
			    if ( t_tag_name != null && t_tag_name.length > 0 ) {
			    	ArrayList<JobRuleBasedCalType> alTmp = new ArrayList();
			    	for ( int i = 0; i < t_tag_name.length; i++ ) {
			    		
			    		JobRuleBasedCalType jobRuleBasedCalType = new JobRuleBasedCalType();
			    		jobRuleBasedCalType.setRuleBasedCalName(t_tag_name[i]);
			    		
						alTmp.add(jobRuleBasedCalType);
			    	}
			    	
			    	JobRuleBasedCalsType jobRuleBasedCalsType = new JobRuleBasedCalsType();
			    	jobRuleBasedCalsType.setJobRuleBasedCal(alTmp);
			    
		    		defJobType.setJobRuleBasedCals(jobRuleBasedCalsType);	
			    }
		    }
		    
		    ArrayList<DefJobType> alTmp = new ArrayList();
		    alTmp.add(defJobType);
		    
		    DefJobsType defJobsType = new DefJobsType();
		    defJobsType.setJob(alTmp);
		    
		    folderType.setJobs(defJobsType);
	
			reqType.setFolder(folderType);			
	
			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
			
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			strReqXml = CommonUtil.marshllingAdd(sw);
		
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		
		return strReqXml;
	}
	
	// 스마트 테이블 OR 서브 테이블에 작업 등록.
	public String defAddJobs(Map map) throws Exception{

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		
		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");
		List alTagList 				= (List)map.get("alTagList");
		TagsBean tagsBean 			= null;
		String strReqXml			= "";
		
		String strDataCenter		= CommonUtil.isNull(docBean.getData_center());
		String strDataCenterName	= CommonUtil.isNull(docBean.getData_center_name());		
		String strTableType			= CommonUtil.isNull(map.get("table_type"));
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		if ( !strDataCenterName.equals("") && strDataCenterName.indexOf("-") > -1 ) { 
			strDataCenterName = strDataCenterName.split("-")[1];
		}
		
		String strDocCd				= CommonUtil.isNull(docBean.getDoc_cd());
		String strJobName			= CommonUtil.isNull(docBean.getJob_name());
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strApplication		= CommonUtil.isNull(docBean.getApplication());
		String strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib(), "FILE_PATH");		// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
		String strMemName			= CommonUtil.isNull(docBean.getMem_name(), "FILE_NAME");	// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
		String strOwner				= CommonUtil.isNull(docBean.getOwner());
		String strAuthor			= CommonUtil.isNull(docBean.getAuthor());
		String strDescription		= CommonUtil.isNull(docBean.getDescription());
		String strCommand			= CommonUtil.isNull(docBean.getCommand());
		String strTableName			= CommonUtil.isNull(docBean.getTable_name());
		String strNodeId			= CommonUtil.isNull(docBean.getNode_id());
		String strMultiagent		= CommonUtil.isNull(docBean.getMultiagent());
		String strConfirmFlag		= CommonUtil.isNull(docBean.getConfirm_flag());
		String strPriority			= CommonUtil.isNull(docBean.getPriority());
		String strCritical			= CommonUtil.isNull(docBean.getCritical());
		String strTimeFrom			= CommonUtil.isNull(docBean.getTime_from());
		String strTimeUntil			= CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getTime_until()));
		String strTimeZone			= CommonUtil.isNull(docBean.getTime_zone());
		String strCyclic			= CommonUtil.isNull(docBean.getCyclic());
		String strRerunInterval		= CommonUtil.isNull(docBean.getRerun_interval());
		String strRerunIntervalTime	= CommonUtil.isNull(docBean.getRerun_interval_time());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		String strRerunMax			= CommonUtil.isNull(docBean.getRerun_max());
		String strMaxWait			= CommonUtil.isNull(docBean.getMax_wait());
		String strTconditionIn		= CommonUtil.isNull(docBean.getT_conditions_in());
		String strTconditionOut		= CommonUtil.isNull(docBean.getT_conditions_out());
		//String strTresourcesQ		= CommonUtil.getQ_Resources(strDataCenterName);
		String strTresourcesQ		= CommonUtil.isNull(docBean.getT_resources_q());
		String strTresourcesC		= CommonUtil.isNull(docBean.getT_resources_c());
		String strTset				= CommonUtil.isNull(docBean.getT_set());
		String strTsteps			= CommonUtil.isNull(docBean.getT_steps());		
		String strTpostproc			= CommonUtil.isNull(docBean.getT_postproc());
		String strTtagName			= CommonUtil.isNull(docBean.getT_tag_name());
		String strCyclicType		= CommonUtil.isNull(docBean.getCyclic_type());
		String strIntervalSequence	= CommonUtil.isNull(docBean.getInterval_sequence());
		String strTolerance			= CommonUtil.isNull(docBean.getTolerance());
		String strSpecificTimes		= CommonUtil.isNull(docBean.getSpecific_times());

		String strTgeneralDate		= CommonUtil.isNull(docBean.getT_general_date());
		String strMonthDays			= CommonUtil.isNull(docBean.getMonth_days());
		String strScheduleAndOr		= CommonUtil.isNull(docBean.getSchedule_and_or());
		String strWeekDays			= CommonUtil.isNull(docBean.getWeek_days());
		String strDaysCal			= CommonUtil.isNull(docBean.getDays_cal());
		String strWeeksCal			= CommonUtil.isNull(docBean.getWeeks_cal());
		String strRetro				= CommonUtil.isNull(docBean.getRetro());
		String strMonth_1			= CommonUtil.isNull(docBean.getMonth_1(), "1");
		String strMonth_2			= CommonUtil.isNull(docBean.getMonth_2(), "1");
		String strMonth_3			= CommonUtil.isNull(docBean.getMonth_3(), "1");
		String strMonth_4			= CommonUtil.isNull(docBean.getMonth_4(), "1");
		String strMonth_5			= CommonUtil.isNull(docBean.getMonth_5(), "1");
		String strMonth_6			= CommonUtil.isNull(docBean.getMonth_6(), "1");
		String strMonth_7			= CommonUtil.isNull(docBean.getMonth_7(), "1");
		String strMonth_8			= CommonUtil.isNull(docBean.getMonth_8(), "1");
		String strMonth_9			= CommonUtil.isNull(docBean.getMonth_9(), "1");
		String strMonth_10			= CommonUtil.isNull(docBean.getMonth_10(), "1");
		String strMonth_11			= CommonUtil.isNull(docBean.getMonth_11(), "1");
		String strMonth_12			= CommonUtil.isNull(docBean.getMonth_12(), "1");
		String strActiveFrom		= CommonUtil.isNull(docBean.getActive_from());
		String strActiveTill		= CommonUtil.isNull(docBean.getActive_till());
		String strConfCal			= CommonUtil.isNull(docBean.getConf_cal());
		String strShift				= CommonUtil.isNull(docBean.getShift());
		String strShiftNum			= CommonUtil.isNull(docBean.getShift_num());
		
		String strApplType			= "OS";
		String strApplForm			= "";
		
		String strShiftMent = "";
		if ( !strShift.equals("") ) {
			if ( strShift.equals("Ignore Job") ) {
				strShiftMent = "ignore_job";
			} else if ( strShift.equals("Next Day") ) {
				strShiftMent = "next_day";
			} else if ( strShift.equals("Prev Day") ) {
				strShiftMent = "prev_day";
			} else if ( strShift.equals("No Confcal") ) {
				strShiftMent = "no_confcal";
			}			
		}
		
		logger.debug("======================================================================================");
		logger.debug("strMonthDays  1" + strMonthDays);
		logger.debug("strWeekDays  1" + strWeekDays);
		logger.debug("strDaysCal  1" + strDaysCal);
		logger.debug("strWeeksCal  1" + strWeeksCal);
		
		logger.debug("======================================================================================");
		
		
		String strRerunIntervalMent = "";
		if ( !strRerunInterval.equals("") ) {			
			strRerunIntervalMent = CommonUtil.lpad(strRerunInterval, 5, "0");
		}
		
		logger.debug("task type ::::: " + strTaskType);
		
		// Kubernetes 설정
		if ( strTaskType.toLowerCase().equals("kubernetes") ) {
			
			strTaskType		= "job";
			strApplType		= "KBN062023";
			
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
			
			logger.debug("Kubernetes 변수 세팅 start ::::: " + strTset);
			
			//Connection Profile
			if ( strTset.length() > 0 ) {
				strTset = strTset + "|" + "UCM-ACCOUNT" + "," + CommonUtil.isNull(map.get("con_pro"));
			}else {
				strTset = "UCM-ACCOUNT" + "," + CommonUtil.isNull(map.get("con_pro"));
			}
			
			if(!CommonUtil.isNull(map.get("spec_param")).equals("")) 		strTset = strTset + "|" + "UCM-JOB_YAML_FILE_PARAMS" + "," + CommonUtil.isNull(map.get("spec_param"));
			if(!CommonUtil.isNull(map.get("get_pod_logs")).equals("")) 		strTset = strTset + "|" + "UCM-GET_LOGS" + "," + CommonUtil.isNull(map.get("get_pod_logs"));
			if(!CommonUtil.isNull(map.get("job_cleanup")).equals("")) 		strTset = strTset + "|" + "UCM-CLEANUP" + "," + CommonUtil.isNull(map.get("job_cleanup"));
			if(!CommonUtil.isNull(map.get("polling_interval")).equals("")) 	strTset = strTset + "|" + "UCM-JOB_POLL_INTERVAL" + "," + CommonUtil.isNull(map.get("polling_interval"));
			if(!CommonUtil.isNull(map.get("job_spec_type")).equals("")) 		strTset = strTset + "|" + "UCM-JOB_SPEC_TYPE" + "," + CommonUtil.isNull(map.get("job_spec_type"));
			if(!CommonUtil.isNull(map.get("os_exit_code")).equals("")) 		strTset = strTset + "|" + "UCM-OS_EXIT_CODE" + "," + CommonUtil.isNull(map.get("os_exit_code"));
			if(!CommonUtil.isNull(map.get("yaml_file")).equals("")) {
				strTset = strTset + "|" + "UCM-JOB_YAML_FILE" + "," + fileName;
				strTset = strTset + "|" + "UCM-JOB_YAML_FILE_N001_element" + "," + fileName;
			}
			if(!CommonUtil.isNull(map.get("file_content")).equals("")) 		strTset = strTset + "|" + "UCM-JOB_YAML_FILE_N002_element" + "," + encodeValue;
			
			strTset = strTset + "|" + "UCM-APP_NAME" + "," + "KBN062023";
			
			if ( strTset.substring(strTset.length()-1, strTset.length()).equals("[|]") ) {
				strTset = strTset.substring(0, strTset.length()-1);
			}
			
			strMemLib 	= "Kubernetes";
			strMemName 	= "Kubernetes";
			
			logger.debug("strMemLib ::::: " + strMemLib);
			logger.debug("strMemName ::::: " + strMemName);
			logger.debug("Kubernetes 변수 세팅 end ::::: " + strTset);
			
		// MFT 설정
		} else if ( strTaskType.toLowerCase().equals("mft") ) {
			
			String mftValue = CommonUtil.getMftValue(strDocCd); 
			
			strTaskType		= "job";
			strMemLib 		= "MFT";
			strMemName 		= "MFT";
			strApplType		= "FILE_TRANS";
			strApplForm		= "AFT";
			
			logger.debug("MFT 변수 세팅 start ::::: " + strTset);
			System.out.println("MFT 변수 세팅 mftValue : " + mftValue);
			System.out.println("MFT 변수 세팅 strTset : " + strTset);
			
			// Default로 설정해줘야 하는 값
			int iTransferNum			= 0;
			String strMftDefaultValue = "FTP-AUTOREFRESH,False|FTP-Is,5|FTP-LPASSIVE,0|FTP-PATH,Not in use for application jobs|FTP-RPASSIVE,0|";
			
			if ( mftValue.indexOf("LPATH1") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME1,0|FTP-CASEIFS1,0|FTP-NULLFLDS1,0|FTP-TIMELIMIT1,0|FTP-TIMELIMIT_UNIT1,1|FTP-TRIM1,1|FTP-UNIQUE1,0|FTP-VERNUM1,0|";
			}
			if ( mftValue.indexOf("LPATH2") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME2,0|FTP-CASEIFS2,0|FTP-NULLFLDS2,0|FTP-TIMELIMIT2,0|FTP-TIMELIMIT_UNIT2,1|FTP-TRIM2,1|FTP-UNIQUE2,0|FTP-VERNUM2,0|";
			}
			if ( mftValue.indexOf("LPATH3") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME3,0|FTP-CASEIFS3,0|FTP-NULLFLDS3,0|FTP-TIMELIMIT3,0|FTP-TIMELIMIT_UNIT3,1|FTP-TRIM3,1|FTP-UNIQUE3,0|FTP-VERNUM3,0|";
			}
			if ( mftValue.indexOf("LPATH4") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME4,0|FTP-CASEIFS4,0|FTP-NULLFLDS4,0|FTP-TIMELIMIT4,0|FTP-TIMELIMIT_UNIT4,1|FTP-TRIM4,1|FTP-UNIQUE4,0|FTP-VERNUM4,0|";
			}
			if ( mftValue.indexOf("LPATH5") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME5,0|FTP-CASEIFS5,0|FTP-NULLFLDS5,0|FTP-TIMELIMIT5,0|FTP-TIMELIMIT_UNIT5,1|FTP-TRIM5,1|FTP-UNIQUE5,0|FTP-VERNUM5,0|";
			}
			
			strMftDefaultValue += "FTP-TRANSFER_NUM," + iTransferNum + "|";
			
			if ( strTset.length() > 0 ) {
				strTset = strTset + "|" + mftValue + strMftDefaultValue;
			}else {
				strTset = mftValue + strMftDefaultValue;
			}
			
			if ( strTset.substring(strTset.length()-1, strTset.length()).equals("[|]") ) {
				strTset = strTset.substring(0, strTset.length()-1);
			}
			
			strTset = strTset.replaceAll("FTP_", "FTP-");
			
			System.out.println("MFT 설정 변수 확인 map : " + map);
			System.out.println("MFT 설정 변수 확인2 strTset : " + strTset);
			
			logger.debug("MFT 변수 세팅 end ::::: " + strTset);
			
		}else if ( strTaskType.toLowerCase().equals("database") ) {
			//Database
			strTaskType		= "job";
			strApplType		= "DATABASE";
			strApplForm		= "Databases";
			System.out.println("map123123 : " + map);
			logger.debug("Database 변수 세팅 start ::::: " + strTset);
			
			strMemLib 	= "Database";
			strMemName 	= "Database";
			int idx		= 0;
			
			//Connection Profile
			if ( strTset.length() > 0 ) {
				strTset = strTset + "|" + "%%DB-ACCOUNT" + "," + CommonUtil.isNull(map.get("db_con_pro"));
			}else {
				strTset = "%%DB-ACCOUNT" + "," + CommonUtil.isNull(map.get("db_con_pro"));
			}
			
			if(!CommonUtil.isNull(map.get("database_type")).equals("")) 	strTset = strTset + "|" + "%%DB-DB_TYPE" + "," + CommonUtil.isNull(map.get("database_type"));
			if(!CommonUtil.isNull(map.get("execution_type")).equals("") || !CommonUtil.isNull(map.get("execution_type_input")).equals("")) {
				if(CommonUtil.isNull(map.get("execution_type")).equals("P") || CommonUtil.isNull(map.get("execution_type_input")).equals("P")) {
					strTset = strTset + "|" + "%%DB-EXEC_TYPE" + "," + "Stored Procedure";
					if(!CommonUtil.isNull(map.get("schema")).equals(""))	strTset = strTset + "|" + "%%DB-STP_SCHEM" + "," + CommonUtil.isNull(map.get("schema"));
					if(!CommonUtil.isNull(map.get("sp_name")).equals("")) 	strTset = strTset + "|" + "%%DB-STP_NAME" + "," + CommonUtil.isNull(map.get("sp_name"));
					for (int i=0;i<4;i++) {
						if(i == 0) {
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_name" + idx;
							    String paramName2 = "in_name" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_NAME" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_NAME" + "," + paramValue2;
							    }
								idx++;
							}
						}else if(i == 1) {
							idx = 0;
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_data" + idx;
							    String paramName2 = "in_data" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_TYPE" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_TYPE" + "," + paramValue2;
							    }
							    idx++;
							}
						}else if(i == 2) {
							idx = 0;
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_param" + idx;
							    String paramName2 = "in_param" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));
							    
							    if (paramValue1.equals("integer")) {
							    	paramValue1 = "int4";
							    }
							    if (paramValue2.equals("integer")) {
							    	paramValue2 = "int4";
							    }
							    
							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_DIRECTION" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_DIRECTION" + "," + paramValue2;
							    }
							    idx++;
							}
						}else{
							idx = 0;
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_variable" + idx;
							    String paramName2 = "in_value" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));
							    if (paramValue1.equals("integer")) {
							    	paramValue1 = "int4";
							    }
							    if (paramValue2.equals("integer")) {
							    	paramValue2 = "int4";
							    }
							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_SETVAR" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_VALUE" + "," + paramValue2;
							    }
							    idx++;
							}
						}
						
					}
					
				}else if(CommonUtil.isNull(map.get("execution_type")).equals("Q") || CommonUtil.isNull(map.get("execution_type_input")).equals("Q")) {
					strTset = strTset + "|" + "%%DB-EXEC_TYPE" + "," + "Open Query";
					if(!CommonUtil.isNull(map.get("query")).equals("")) 	strTset = strTset + "|" + "%%DB-QTXT-N001-SUBQTXT" + "," + CommonUtil.replaceStrHtml(CommonUtil.isNull(map.get("query")));
					if(!CommonUtil.isNull(map.get("query")).equals("")) 	strTset = strTset + "|" + "%%DB-QTXT-N001-SUBQLENGTH" + "," + Integer.toString(CommonUtil.replaceStrHtml(CommonUtil.isNull(map.get("query"))).length());
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
			
		}
			
		try {
		
			JAXBContext context 				= JAXBContext.newInstance(RequestDefAddJobsType.class);
			RequestDefAddJobsType reqType 		= new RequestDefAddJobsType();
			java.io.StringWriter sw 			= new java.io.StringWriter();

			reqType.setUserToken(strUserToken);
			reqType.setControlM(strDataCenter);
			reqType.setFolderName(strTableName);
			
			IntervalSequenceType intervalSequenceType = new IntervalSequenceType();

			if( strIntervalSequence.length() > 0 ) {
				String[] t_interval_sequence = strIntervalSequence.split("[,]");				
				if ( null!=t_interval_sequence && 0<t_interval_sequence.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_interval_sequence.length; i++ ) {
						
						//t_interval_sequence[i] = CommonUtil.lpad(t_interval_sequence[i], 5, "0");
					
						alTmp.add("+" + t_interval_sequence[i] + strRerunIntervalTime);
					}
					
					intervalSequenceType.setIntervalItem(alTmp);
				}				
			}
			
			SpecificTimesType specificTimesType = new SpecificTimesType();

			if( strSpecificTimes.length() > 0 ) {
				String[] t_specific_time = strSpecificTimes.split("[,]");				
				if ( null!=t_specific_time && 0<t_specific_time.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_specific_time.length; i++ ) {	
					
						alTmp.add(t_specific_time[i]);
					}
					
					specificTimesType.setSpecificTime(alTmp);
				}				
			}	
	
			// 작업 속성 설정.
			DefJobType defJobType = new DefJobType();
			
			if ( !strJobName.equals("") ) 			defJobType.setJobName(strJobName);
			if ( !strTaskType.equals("") ) 			defJobType.setTaskType(DefTaskType.fromValue(strTaskType.toLowerCase()));
			if ( !strApplication.equals("") ) 		defJobType.setApplication(strApplication);
			if ( !strGroupName.equals("") ) 		defJobType.setSubApplication(strGroupName);
			if ( !strMemLib.equals("") ) 			defJobType.setMemLib(strMemLib);
			if ( !strMemName.equals("") ) 			defJobType.setMemName(strMemName);
			if ( !strOwner.equals("") ) 			defJobType.setRunAs(strOwner);
			if ( !strAuthor.equals("") ) 			defJobType.setCreatedBy(strAuthor);
			if ( !strDescription.equals("") ) 		defJobType.setDescription(strDescription);
			if ( !strCommand.equals("") ) 			defJobType.setCommand(strCommand);
			if ( !strNodeId.equals("") ) 			defJobType.setNodeId(strNodeId);
			if ( !strMultiagent.equals("") ) 		defJobType.setMultiagent(YesNoType.fromValue(CommonUtil.getMessage("JOB.MULTIAGENT."+strMultiagent)));
			if ( !strConfirmFlag.equals("") ) 		defJobType.setConfirmFlag(YesNoType.fromValue(CommonUtil.getMessage("JOB.CONFIRM_FLAG."+strConfirmFlag)));
			if ( !strPriority.equals("") ) 			defJobType.setPriority(strPriority);
			if ( !strCritical.equals("") ) 			defJobType.setCritical(YesNoType.fromValue(CommonUtil.getMessage("JOB.CRITICAL."+strCritical)));
			if ( !strTimeFrom.equals("") ) 			defJobType.setTimeFrom(strTimeFrom);
			if ( !strTimeUntil.equals("") ) 		defJobType.setTimeUntil(strTimeUntil);
			if ( !strTimeZone.equals("") ) 			defJobType.setTimeZone(strTimeZone);
			if ( !strCyclic.equals("") ) 			defJobType.setCyclic(YesNoType.fromValue(CommonUtil.getMessage("JOB.CYCLIC."+strCyclic)));
			//if ( !strRerunInterval.equals("") ) 	defJobType.setRerunInterval(strRerunIntervalMent + strRerunIntervalTime);
			if ( !strRerunInterval.equals("") ) 	defJobType.setRerunInterval(strRerunIntervalMent);
			if ( !strCountCyclicFrom.equals("") ) 	defJobType.setCountCyclicFrom(StartEndTargetType.fromValue(strCountCyclicFrom));
			if ( !strRerunMax.equals("") ) 			defJobType.setRerunMax(strRerunMax);
			if ( !strMaxWait.equals("") ) 			defJobType.setMaxWait(strMaxWait);
			if ( !strCyclicType.equals("") ) 		defJobType.setCyclicType(CyclicTypeType.fromValue(CommonUtil.getMessage("JOB.CYCLIC_TYPE."+strCyclicType)));
			if ( !strIntervalSequence.equals("") ) 	defJobType.setIntervalSequence(intervalSequenceType);
			if ( !strTolerance.equals("") ) 		defJobType.setTolerance(strTolerance);
			if ( !strSpecificTimes.equals("") ) 	defJobType.setSpecificTimes(specificTimesType);
			
			//Kubernetes일 경우 appl_type 값 추가
			if ( !strApplType.equals("") )			defJobType.setApplicationType(strApplType);
			if(strApplType == "FILE_TRANS" || strApplType == "DATABASE") {
				if ( !strApplForm.equals("") )			defJobType.setApplicationForm(strApplForm);
			}else {
				if ( !strApplType.equals("") )			defJobType.setApplicationForm(strApplType);
			}
			
			
			// 스케줄.
			if( strTgeneralDate.length() > 0 ) {
				strTgeneralDate = strTgeneralDate.replaceAll(" ", "").replaceAll(",", "|");
				String[] t_general_date = strTgeneralDate.split("[|]");				
				if ( null!=t_general_date && 0<t_general_date.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_general_date.length; i++ ) {	
					
						alTmp.add(t_general_date[i]);	
					}
					
					DatesType datesType = new DatesType();
					datesType.setDate(alTmp);
					
					defJobType.setDates(datesType);
				}
				
			} else {
				
				if ( strTableType.equals("2") ) {
					
					ArrayList<JobRuleBasedCalType> alTmp = new ArrayList();
			    		
		    		JobRuleBasedCalType jobRuleBasedCalType = new JobRuleBasedCalType();
		    		jobRuleBasedCalType.setRuleBasedCalName("*");
		    		
					alTmp.add(jobRuleBasedCalType);
			    	
			    	JobRuleBasedCalsType jobRuleBasedCalsType = new JobRuleBasedCalsType();
			    	jobRuleBasedCalsType.setJobRuleBasedCal(alTmp);
		    
		    		defJobType.setJobRuleBasedCals(jobRuleBasedCalsType);
		    		
				} else {
				
					if ( !strMonthDays.equals("") ) 		defJobType.setMonthDays(strMonthDays);
					if ( !strScheduleAndOr.equals("") ) 	defJobType.setAndOr(AndOrType.fromValue(CommonUtil.getMessage("JOB.AND_OR."+strScheduleAndOr)));
					if ( !strWeekDays.equals("") ) 			defJobType.setWeekDays(strWeekDays);
					if ( !strDaysCal.equals("") ) 			defJobType.setDaysCal(strDaysCal);
					if ( !strWeeksCal.equals("") ) 			defJobType.setWeeksCal(strWeeksCal);
					if ( !strRetro.equals("") ) 			defJobType.setRetro(YesNoType.fromValue(CommonUtil.getMessage("JOB.RETRO."+strRetro)));
					if ( !strMonth_1.equals("") ) 			defJobType.setJAN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_1)));
					if ( !strMonth_2.equals("") ) 			defJobType.setFEB(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_2)));    				
					if ( !strMonth_3.equals("") ) 			defJobType.setMAR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_3)));
					if ( !strMonth_4.equals("") ) 			defJobType.setAPR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_4)));
					if ( !strMonth_5.equals("") ) 			defJobType.setMAY(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_5)));
					if ( !strMonth_6.equals("") ) 			defJobType.setJUN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_6)));
					if ( !strMonth_7.equals("") ) 			defJobType.setJUL(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_7)));
					if ( !strMonth_8.equals("") ) 			defJobType.setAUG(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_8)));
					if ( !strMonth_9.equals("") ) 			defJobType.setSEP(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_9)));
					if ( !strMonth_10.equals("") ) 			defJobType.setOCT(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_10)));
					if ( !strMonth_11.equals("") ) 			defJobType.setNOV(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_11)));
					if ( !strMonth_12.equals("") ) 			defJobType.setDEC(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_12)));
					if ( !strActiveFrom.equals("") ) 		defJobType.setActiveFrom(strActiveFrom);
					if ( !strActiveTill.equals("") ) 		defJobType.setActiveUntil(strActiveTill);
					if ( !strConfCal.equals("") ) 			defJobType.setConfCal(strConfCal);
					if ( !strShift.equals("") ) 			defJobType.setShift(strShiftMent);
					if ( !strShiftNum.equals("") ) 			defJobType.setShiftNum(strShiftNum);
				}		
			}
			
			// In Condition.
			if ( strTconditionIn.length() > 0 ) {
				defJobType.setInConditions(getInConditions(strTconditionIn));
			}
			
			// Out Condition.
			if ( strTconditionOut.length() > 0 ) {
				defJobType.setOutConditions(getOutConditions(strTconditionOut));
			}
			
			// Quantitatvie Resouce.
			if ( strTresourcesQ.length() > 0 ) {
				defJobType.setQuantitativeResources(getQresources(strTresourcesQ));
			}
			
			// Control Resouce.
			if ( strTresourcesC.length() > 0 ) {
				defJobType.setControlResources(getCresources(strTresourcesC));
			}
			
			// Set 변수.
			if ( strTset.length() > 0 ) {
				defJobType.setVariableAssignments(getVariableAssignments(strTset));
			}
			
			// Step.
			if ( strTsteps.length() > 0 ) {				
				defJobType.setOnDoStatements(getOnDoStatements(strTsteps));				
			}
			
			// PostProc.
			if ( strTpostproc.length() > 0 ) {				
				defJobType.setShouts(getShouts(strTpostproc));				
			}
			
		    // Tag.
		    if ( CommonUtil.isNull(strTtagName).length() > 0 ) {
			    String[] t_tag_name = strTtagName.split("[|]");
			    if ( t_tag_name != null && t_tag_name.length > 0 ) {
			    	ArrayList<JobRuleBasedCalType> alTmp = new ArrayList();
			    	for ( int i = 0; i < t_tag_name.length; i++ ) {
			    		
			    		JobRuleBasedCalType jobRuleBasedCalType = new JobRuleBasedCalType();
			    		jobRuleBasedCalType.setRuleBasedCalName(t_tag_name[i]);
			    		
						alTmp.add(jobRuleBasedCalType);
			    	}
			    	
			    	JobRuleBasedCalsType jobRuleBasedCalsType = new JobRuleBasedCalsType();
			    	jobRuleBasedCalsType.setJobRuleBasedCal(alTmp);
			    
		    		defJobType.setJobRuleBasedCals(jobRuleBasedCalsType);	
			    }
		    }
		    
		    ArrayList<DefJobType> alTmp = new ArrayList();
		    alTmp.add(defJobType);
		    
		    DefJobsType defJobsType = new DefJobsType();
		    defJobsType.setJob(alTmp);
		    
		    reqType.setJobs(defJobsType);
	
			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
			
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			strReqXml = CommonUtil.marshllingAdd(sw);
		
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		
		return strReqXml;
	}
	
	// 엑셀 일괄 등록.
	public String defAddBatchJobs(Map map) throws Exception{
		
		Doc01Bean doc01Bean			= (Doc01Bean)map.get("doc01");

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		String strDataCenter		= CommonUtil.isNull(doc01Bean.getData_center());
		String strDataCenterName	= CommonUtil.isNull(doc01Bean.getData_center_name());
		String strTableName			= CommonUtil.isNull(doc01Bean.getTable_name());
		String strTableCnt			= CommonUtil.isNull(doc01Bean.getTable_cnt());
		String strUserDaily			= CommonUtil.isNull(doc01Bean.getUser_daily());
		String strReqXml			= "";
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		if ( !strDataCenterName.equals("") && strDataCenterName.indexOf("-") > -1 ) { 
			strDataCenterName = strDataCenterName.split("-")[1];
		}
		
		List alDocList 				= (List)map.get("alDocList");
		Doc06Bean docBean 		= null;
		
		String strJobName			= "";
		String strTaskType			= "";
		String strApplication		= "";
		String strGroupName			= "";
		String strMemLib			= "";
		String strMemName			= "";
		String strOwner				= "";
		String strAuthor			= "";
		String strDescription		= "";
		String strCommand			= "";
		String strNodeId			= "";
		String strMultiagent		= "";
		String strConfirmFlag		= "";
		String strPriority			= "";
		String strCritical			= "";
		String strTimeFrom			= "";
		String strTimeUntil			= "";
		String strTimeZone			= "";
		String strCyclic			= "";
		String strRerunInterval		= "";
		String strRerunIntervalTime	= "";
		String strCountCyclicFrom	= "";
		String strIndCyclic			= "";
		String strRerunMax			= "";
		String strMaxWait			= "";
		String strTconditionIn		= "";
		String strTconditionOut		= "";
		String strTresourcesQ		= "";
		String strTresourcesC		= "";
		String strTset				= "";
		String strTsteps			= "";
		String strTpostproc			= "";
		String strTtagName			= "";
		String strCyclicType		= "";
		String strIntervalSequence	= "";
		String strTolerance			= "";
		String strSpecificTimes		= "";
		//String strUserDaily			= "";
		
		String strUserDailyMent 	= "";
		
		String strTgeneralDate		= "";
		String strMonthDays			= "";
		String strScheduleAndOr		= "";
		String strWeekDays			= "";
		String strDaysCal			= "";
		String strWeeksCal			= "";
		String strRetro				= "";
		String strMonth_1			= "";
		String strMonth_2			= "";
		String strMonth_3			= "";
		String strMonth_4			= "";
		String strMonth_5			= "";
		String strMonth_6			= "";
		String strMonth_7			= "";
		String strMonth_8			= "";
		String strMonth_9			= "";
		String strMonth_10			= "";
		String strMonth_11			= "";
		String strMonth_12			= "";
		String strActiveFrom		= "";
		String strActiveTill		= "";
		
		String strApplType			= "OS";
		
		ArrayList<DefJobType> alTmp = new ArrayList();
	
		if ( alDocList != null ) {
			for ( int i = 0; i < alDocList.size(); i ++ ) {
				docBean = (Doc06Bean)alDocList.get(i);
				System.out.println("docBean : " + docBean);
				strJobName				= CommonUtil.isNull(docBean.getJob_name());
				strTaskType				= CommonUtil.isNull(docBean.getTask_type());
				strApplication			= CommonUtil.isNull(docBean.getApplication());
				strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
				strMemLib				= CommonUtil.isNull(docBean.getMem_lib(), "FILE_PATH");		// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
				strMemName				= CommonUtil.isNull(docBean.getMem_name(), "FILE_NAME");	// 9.0.21 업그레이드 되면서 command TYPE 임에도 불구하고, 필수로 인식하고 있음 (2024.04.16 강명준)
				strOwner				= CommonUtil.isNull(docBean.getOwner());
				strAuthor				= CommonUtil.isNull(docBean.getAuthor());
				strDescription			= CommonUtil.isNull(docBean.getDescription());
				strCommand				= CommonUtil.isNull(docBean.getCommand());
				strNodeId				= CommonUtil.isNull(docBean.getNode_id());
				strMultiagent			= CommonUtil.isNull(docBean.getMultiagent());
				strConfirmFlag			= CommonUtil.isNull(docBean.getConfirm_flag());
				strPriority				= CommonUtil.isNull(docBean.getPriority());
				strCritical				= CommonUtil.isNull(docBean.getCritical());
				strTimeFrom				= CommonUtil.isNull(docBean.getTime_from());
				strTimeUntil			= CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getTime_until()));
				strTimeZone				= CommonUtil.isNull(docBean.getTime_zone());
				strCyclic				= CommonUtil.isNull(docBean.getCyclic());
				strRerunInterval		= CommonUtil.isNull(docBean.getRerun_interval());
				strRerunIntervalTime	= CommonUtil.isNull(docBean.getRerun_interval_time());
				strIndCyclic  			= CommonUtil.isNull(docBean.getInd_cyclic());
				if(strIndCyclic.equals("S")) {
					strCountCyclicFrom = "start";
				}else if(strIndCyclic.equals("E")) {
					strCountCyclicFrom = "end";
				}else if(strIndCyclic.equals("T")) {
					strCountCyclicFrom = "target";
				}
				//strCountCyclicFrom		= CommonUtil.isNull(docBean.getCount_cyclic_from());
				strRerunMax				= CommonUtil.isNull(docBean.getRerun_max());
				strMaxWait				= CommonUtil.isNull(docBean.getMax_wait());
				strTconditionIn			= CommonUtil.isNull(docBean.getT_conditions_in());
				strTconditionOut		= CommonUtil.isNull(docBean.getT_conditions_out());
				//strTresourcesQ			= CommonUtil.getQ_Resources(strDataCenterName);
				strTresourcesQ			= CommonUtil.isNull(docBean.getT_resources_q());
				strTresourcesC			= CommonUtil.isNull(docBean.getT_resources_c());
				strTset					= CommonUtil.isNull(docBean.getT_set());
				strTsteps				= CommonUtil.isNull(docBean.getT_steps());		
				strTpostproc			= CommonUtil.isNull(docBean.getT_postproc());
				strTtagName				= CommonUtil.isNull(docBean.getT_tag_name());
				strCyclicType			= CommonUtil.isNull(docBean.getCyclic_type());
				strIntervalSequence		= CommonUtil.isNull(docBean.getInterval_sequence());
				strTolerance			= CommonUtil.isNull(docBean.getTolerance());
				strSpecificTimes		= CommonUtil.isNull(docBean.getSpecific_times());
				
				IntervalSequenceType intervalSequenceType = new IntervalSequenceType();

				if( strIntervalSequence.length() > 0 ) {
					String[] t_interval_sequence = strIntervalSequence.split("[,]");				
					if ( null!=t_interval_sequence && 0<t_interval_sequence.length ) {
						ArrayList<String> alTmpl = new ArrayList();		
						for ( int j = 0; j < t_interval_sequence.length; j++ ) {
							
							//t_interval_sequence[i] = CommonUtil.lpad(t_interval_sequence[i], 5, "0");
						
							alTmpl.add("+" + t_interval_sequence[j] + strRerunIntervalTime);
						}
						
						intervalSequenceType.setIntervalItem(alTmpl);
					}				
				}
				
				SpecificTimesType specificTimesType = new SpecificTimesType();

				if( strSpecificTimes.length() > 0 ) {
					String[] t_specific_time = strSpecificTimes.split("[,]");				
					if ( null!=t_specific_time && 0<t_specific_time.length ) {
						ArrayList<String> alTmpl = new ArrayList();		
						for ( int j = 0; j < t_specific_time.length; j++ ) {	
						
							alTmpl.add(t_specific_time[j]);
						}
						
						specificTimesType.setSpecificTime(alTmpl);
					}				
				}
				
				strTgeneralDate			= CommonUtil.isNull(docBean.getT_general_date());
				strMonthDays			= CommonUtil.isNull(docBean.getMonth_days());
				strScheduleAndOr		= CommonUtil.isNull(docBean.getSchedule_and_or());
				strWeekDays				= CommonUtil.isNull(docBean.getWeek_days());
				strDaysCal				= CommonUtil.isNull(docBean.getDays_cal());
				strWeeksCal				= CommonUtil.isNull(docBean.getWeeks_cal());
				strRetro				= CommonUtil.isNull(docBean.getRetro());
				strMonth_1				= CommonUtil.isNull(docBean.getMonth_1(), "1");
				strMonth_2				= CommonUtil.isNull(docBean.getMonth_2(), "1");
				strMonth_3				= CommonUtil.isNull(docBean.getMonth_3(), "1");
				strMonth_4				= CommonUtil.isNull(docBean.getMonth_4(), "1");
				strMonth_5				= CommonUtil.isNull(docBean.getMonth_5(), "1");
				strMonth_6				= CommonUtil.isNull(docBean.getMonth_6(), "1");
				strMonth_7				= CommonUtil.isNull(docBean.getMonth_7(), "1");
				strMonth_8				= CommonUtil.isNull(docBean.getMonth_8(), "1");
				strMonth_9				= CommonUtil.isNull(docBean.getMonth_9(), "1");
				strMonth_10				= CommonUtil.isNull(docBean.getMonth_10(), "1");
				strMonth_11				= CommonUtil.isNull(docBean.getMonth_11(), "1");
				strMonth_12				= CommonUtil.isNull(docBean.getMonth_12(), "1");		
				strActiveFrom			= CommonUtil.isNull(docBean.getActive_from());
				strActiveTill			= CommonUtil.isNull(docBean.getActive_till());
	
				// 작업 속성 설정.
				DefJobType defJobType = new DefJobType();
				
				if ( !strJobName.equals("") ) 			defJobType.setJobName(strJobName);
				if ( !strTaskType.equals("") ) 			defJobType.setTaskType(DefTaskType.fromValue(strTaskType.toLowerCase()));
				if ( !strApplication.equals("") ) 		defJobType.setApplication(strApplication);
				if ( !strGroupName.equals("") ) 		defJobType.setSubApplication(strGroupName);
				if ( !strMemLib.equals("") ) 			defJobType.setMemLib(strMemLib);
				if ( !strMemName.equals("") ) 			defJobType.setMemName(strMemName);
				if ( !strOwner.equals("") ) 			defJobType.setRunAs(strOwner);
				if ( !strAuthor.equals("") ) 			defJobType.setCreatedBy(strAuthor);
				if ( !strDescription.equals("") ) 		defJobType.setDescription(strDescription);
				if ( !strCommand.equals("") ) 			defJobType.setCommand(strCommand);
				if ( !strNodeId.equals("") ) 			defJobType.setNodeId(strNodeId);
				if ( !strMultiagent.equals("") ) 		defJobType.setMultiagent(YesNoType.fromValue(CommonUtil.getMessage("JOB.MULTIAGENT."+strMultiagent)));
				if ( !strConfirmFlag.equals("") ) 		defJobType.setConfirmFlag(YesNoType.fromValue(CommonUtil.getMessage("JOB.CONFIRM_FLAG."+strConfirmFlag)));
				if ( !strPriority.equals("") ) 			defJobType.setPriority(strPriority);
				if ( !strCritical.equals("") ) 			defJobType.setCritical(YesNoType.fromValue(CommonUtil.getMessage("JOB.CRITICAL."+strCritical)));
				if ( !strTimeFrom.equals("") ) 			defJobType.setTimeFrom(strTimeFrom);
				if ( !strTimeUntil.equals("") ) 		defJobType.setTimeUntil(strTimeUntil);
				if ( !strTimeZone.equals("") ) 			defJobType.setTimeZone(strTimeZone);
				if ( !strCyclic.equals("") ) 			defJobType.setCyclic(YesNoType.fromValue(CommonUtil.getMessage("JOB.CYCLIC."+strCyclic)));
				//if ( !strRerunInterval.equals("") ) 	defJobType.setRerunInterval(strRerunInterval + strRerunIntervalTime);
				if ( !strRerunInterval.equals("") ) 	defJobType.setRerunInterval(strRerunInterval);
				if ( !strCountCyclicFrom.equals("") ) 	defJobType.setCountCyclicFrom(StartEndTargetType.fromValue(strCountCyclicFrom));
				if ( !strRerunMax.equals("") ) 			defJobType.setRerunMax(strRerunMax);
				if ( !strMaxWait.equals("") ) 			defJobType.setMaxWait(strMaxWait);
				if ( !strCyclicType.equals("") ) 		defJobType.setCyclicType(CyclicTypeType.fromValue(CommonUtil.getMessage("JOB.CYCLIC_TYPE."+strCyclicType)));
				if ( !strIntervalSequence.equals("") ) 	defJobType.setIntervalSequence(intervalSequenceType);
				if ( !strTolerance.equals("") ) 		defJobType.setTolerance(strTolerance);
				if ( !strSpecificTimes.equals("") ) 	defJobType.setSpecificTimes(specificTimesType);
				
				if ( !strMonthDays.equals("") ) 		defJobType.setMonthDays(strMonthDays);
				if ( !strScheduleAndOr.equals("") ) 	defJobType.setAndOr(AndOrType.fromValue(CommonUtil.getMessage("JOB.AND_OR."+strScheduleAndOr)));
				if ( !strWeekDays.equals("") ) 			defJobType.setWeekDays(strWeekDays);
				if ( !strDaysCal.equals("") ) 			defJobType.setDaysCal(strDaysCal);
				if ( !strWeeksCal.equals("") ) 			defJobType.setWeeksCal(strWeeksCal);
				if ( !strRetro.equals("") ) 			defJobType.setRetro(YesNoType.fromValue(CommonUtil.getMessage("JOB.RETRO."+strRetro)));
				if ( !strMonth_1.equals("") ) 			defJobType.setJAN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_1)));    				
				if ( !strMonth_2.equals("") ) 			defJobType.setFEB(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_2)));    				
				if ( !strMonth_3.equals("") ) 			defJobType.setMAR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_3)));
				if ( !strMonth_4.equals("") ) 			defJobType.setAPR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_4)));
				if ( !strMonth_5.equals("") ) 			defJobType.setMAY(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_5)));
				if ( !strMonth_6.equals("") ) 			defJobType.setJUN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_6)));
				if ( !strMonth_7.equals("") ) 			defJobType.setJUL(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_7)));
				if ( !strMonth_8.equals("") ) 			defJobType.setAUG(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_8)));
				if ( !strMonth_9.equals("") ) 			defJobType.setSEP(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_9)));
				if ( !strMonth_10.equals("") ) 			defJobType.setOCT(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_10)));
				if ( !strMonth_11.equals("") ) 			defJobType.setNOV(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_11)));
				if ( !strMonth_12.equals("") ) 			defJobType.setDEC(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_12)));
				if ( !strActiveFrom.equals("") ) 		defJobType.setActiveFrom(strActiveFrom);
				if ( !strActiveTill.equals("") ) 		defJobType.setActiveUntil(strActiveTill);
				
				defJobType.setApplicationType(strApplType);
				
				// In Condition.
				if ( strTconditionIn.length() > 0 ) {
					defJobType.setInConditions(getInConditions(strTconditionIn));
				}
				
				// Out Condition.
				if ( strTconditionOut.length() > 0 ) {
					defJobType.setOutConditions(getOutConditions(strTconditionOut));
				}
				
				// Quantitatvie Resouce.
				if ( strTresourcesQ.length() > 0 ) {
					defJobType.setQuantitativeResources(getQresources(strTresourcesQ));
				}
				
				// Control Resouce.
				if ( strTresourcesC.length() > 0 ) {
					defJobType.setControlResources(getCresources(strTresourcesC));
				}
				
				// Set 변수.
				if ( strTset.length() > 0 ) {
					defJobType.setVariableAssignments(getVariableAssignments(strTset));
				}
				
				// Step.
				if ( strTsteps.length() > 0 ) {				
					defJobType.setOnDoStatements(getOnDoStatements(strTsteps));				
				}
				
				// PostProc.
				if ( strTpostproc.length() > 0 ) {				
					defJobType.setShouts(getShouts(strTpostproc));
				}				
			    
			    alTmp.add(defJobType);
			}
		}
		
		try {
			
			if ( strTableCnt.equals("0") ) {
				
				JAXBContext context 				= JAXBContext.newInstance(RequestDefCreateFolderType.class);
				RequestDefCreateFolderType reqType 	= new RequestDefCreateFolderType();
				java.io.StringWriter sw 			= new java.io.StringWriter();

				reqType.setUserToken(strUserToken);
							
				// 테이블 설정.
				FolderType folderType = new FolderType();
				folderType.setControlM(strDataCenter);
				folderType.setFolderName(strTableName);
				folderType.setOrderMethod(strUserDaily);

			    DefJobsType defJobsType = new DefJobsType();
			    defJobsType.setJob(alTmp);
			    
			    folderType.setJobs(defJobsType);
		
				reqType.setFolder(folderType);
		
				// 해당 타입을 토대로 1차적으로 마샬링.
				Marshaller marshaller = CommonUtil.marshalling(context);
				marshaller.marshal(reqType, sw);
				
				// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
				strReqXml = CommonUtil.marshllingAdd(sw);
				
			} else {
				
				JAXBContext context 				= JAXBContext.newInstance(RequestDefAddJobsType.class);
				RequestDefAddJobsType reqType 		= new RequestDefAddJobsType();
				java.io.StringWriter sw 			= new java.io.StringWriter();
				
				reqType.setUserToken(strUserToken);
				reqType.setControlM(strDataCenter);
				reqType.setFolderName(strTableName);
				reqType.setOrderMethod(strUserDaily);
				
				DefJobsType defJobsType = new DefJobsType();
			    defJobsType.setJob(alTmp);
			    
			    reqType.setJobs(defJobsType);
		
				// 해당 타입을 토대로 1차적으로 마샬링.
				Marshaller marshaller = CommonUtil.marshalling(context);
				marshaller.marshal(reqType, sw);
				
				// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
				strReqXml = CommonUtil.marshllingAdd(sw);
			}	    
		
		} catch (JAXBException e) {
			e.printStackTrace();
		}
		
		return strReqXml;
	}
	
	
	// 수시 작업 등록.
	public Map createJobs(Map map) throws Exception{

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		
		Doc01Bean docBean			= (Doc01Bean)map.get("doc02");
		
		String strDataCenter		= CommonUtil.isNull(docBean.getData_center());
		String strDataCenterName	= CommonUtil.isNull(docBean.getData_center_name());
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		if ( !strDataCenterName.equals("") && strDataCenterName.indexOf("-") > -1 ) {
			strDataCenterName = strDataCenterName.split("-")[1];
		}
		
		String strJobName			= CommonUtil.isNull(docBean.getJob_name());
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strApplication		= CommonUtil.isNull(docBean.getApplication());
		String strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib());
		String strMemName			= CommonUtil.isNull(docBean.getMem_name());
		String strOwner				= CommonUtil.isNull(docBean.getOwner());
		String strDescription		= CommonUtil.isNull(docBean.getDescription());
		String strCommand			= CommonUtil.isNull(docBean.getCommand());
		String strTableName			= CommonUtil.isNull(docBean.getTable_name());
		String strNodeId			= CommonUtil.isNull(docBean.getNode_id());
		String strMultiagent		= CommonUtil.isNull(docBean.getMultiagent());
		String strConfirmFlag		= CommonUtil.isNull(docBean.getConfirm_flag());
		String strPriority			= CommonUtil.isNull(docBean.getPriority());
		String strCritical			= CommonUtil.isNull(docBean.getCritical());
		String strTimeFrom			= CommonUtil.isNull(docBean.getTime_from());
		String strTimeUntil			= CommonUtil.replaceStrXml(CommonUtil.isNull(docBean.getTime_until()));
		String strTimeZone			= CommonUtil.isNull(docBean.getTime_zone());
		String strCyclic			= CommonUtil.isNull(docBean.getCyclic());
		String strRerunInterval		= CommonUtil.isNull(docBean.getRerun_interval());
		String strRerunIntervalTime	= CommonUtil.isNull(docBean.getRerun_interval_time());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		String strRerunMax			= CommonUtil.isNull(docBean.getRerun_max());
		String strMaxWait			= CommonUtil.isNull(docBean.getMax_wait());
		String strTconditionIn		= CommonUtil.isNull(docBean.getT_conditions_in());
		String strTconditionOut		= CommonUtil.isNull(docBean.getT_conditions_out());
		//String strTresourcesQ		= CommonUtil.getQ_Resources(strDataCenterName);
		String strTresourcesQ		= CommonUtil.isNull(docBean.getT_resources_q());
		String strTresourcesC		= CommonUtil.isNull(docBean.getT_resources_c());
		String strTset				= CommonUtil.isNull(docBean.getT_set());
		String strTsteps			= CommonUtil.isNull(docBean.getT_steps());		
		String strTpostproc			= CommonUtil.isNull(docBean.getT_postproc());
		String strCyclicType		= CommonUtil.isNull(docBean.getCyclic_type());
		String strIntervalSequence	= CommonUtil.isNull(docBean.getInterval_sequence());
		String strTolerance			= CommonUtil.isNull(docBean.getTolerance());
		String strSpecificTimes		= CommonUtil.isNull(docBean.getSpecific_times());
		String strTgeneralDate		= CommonUtil.isNull(docBean.getT_general_date());
		String strDocCd				= CommonUtil.isNull(docBean.getDoc_cd());
		String strApplType			= "";
		String strApplForm			= "";
		
		strTgeneralDate 			= strTgeneralDate.replaceAll(" ", "").replaceAll(",", "|");

		// START 컨디션 자동 설정
		//strTconditionIn				= CommonUtil.getI_Conditions(strDataCenterName, strTconditionIn, strJobName);
		
		// NAVER 용 리소스 자동 설정
		//strTresourcesQ				= "NAVER@,1";
		
		// Kubernetes 설정
		if ( strTaskType.toLowerCase().equals("kubernetes") ) {
			
			strTaskType		= "job";
			strApplType		= "KBN062023";
			
			logger.debug("Kubernetes 변수 세팅 start ::::: " + strTset);
			
			//Connection Profile
			if ( strTset.length() > 0 ) {
				strTset = strTset + "|" + "UCM-ACCOUNT" + "," + CommonUtil.isNull(map.get("con_pro"));
			}else {
				strTset = "UCM-ACCOUNT" + "," + CommonUtil.isNull(map.get("con_pro"));
			}
			
			strTset = strTset + "|" + "UCM-JOB_YAML_FILE_PARAMS" + "," + CommonUtil.isNull(map.get("spec_param"));
			strTset = strTset + "|" + "UCM-GET_LOGS" + "," + CommonUtil.isNull(map.get("get_pod_logs"));
			strTset = strTset + "|" + "UCM-CLEANUP" + "," + CommonUtil.isNull(map.get("job_cleanup"));
			strTset = strTset + "|" + "UCM-JOB_POLL_INTERVAL" + "," + CommonUtil.isNull(map.get("polling_interval"));
			strTset = strTset + "|" + "UCM-JOB_SPEC_TYPE" + "," + CommonUtil.isNull(map.get("job_spec_type"));
			strTset = strTset + "|" + "UCM-OS_EXIT_CODE" + "," + CommonUtil.isNull(map.get("os_exit_code"));
			
			if ( strTset.substring(strTset.length()-1, strTset.length()).equals("[|]") ) {
				strTset = strTset.substring(0, strTset.length()-1);
			}
			
			strMemLib 	= "Kubernetes";
			strMemName 	= "Kubernetes";
			
			logger.debug("strMemLib ::::: " + strMemLib);
			logger.debug("strMemName ::::: " + strMemName);
			logger.debug("Kubernetes 변수 세팅 end ::::: " + strTset);
		} else if ( strTaskType.toLowerCase().equals("mft") ) {
			
			String mftValue = CommonUtil.getMftValue(strDocCd); 
			
			strTaskType		= "job";
			strMemLib 		= "MFT";
			strMemName 		= "MFT";
			strApplType		= "FILE_TRANS";
			strApplForm		= "AFT";
			
			logger.debug("MFT 변수 세팅 start ::::: " + strTset);
			System.out.println("MFT 변수 세팅 mftValue : " + mftValue);
			System.out.println("MFT 변수 세팅 strTset : " + strTset);
			
			// Default로 설정해줘야 하는 값
			int iTransferNum			= 0;
			String strMftDefaultValue = "FTP-AUTOREFRESH,False|FTP-Is,5|FTP-LPASSIVE,0|FTP-PATH,Not in use for application jobs|FTP-RPASSIVE,0|";
			
			if ( mftValue.indexOf("LPATH1") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME1,0|FTP-CASEIFS1,0|FTP-NULLFLDS1,0|FTP-TIMELIMIT1,0|FTP-TIMELIMIT_UNIT1,1|FTP-TRIM1,1|FTP-UNIQUE1,0|FTP-VERNUM1,0|";
			}
			if ( mftValue.indexOf("LPATH2") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME2,0|FTP-CASEIFS2,0|FTP-NULLFLDS2,0|FTP-TIMELIMIT2,0|FTP-TIMELIMIT_UNIT2,1|FTP-TRIM2,1|FTP-UNIQUE2,0|FTP-VERNUM2,0|";
			}
			if ( mftValue.indexOf("LPATH3") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME3,0|FTP-CASEIFS3,0|FTP-NULLFLDS3,0|FTP-TIMELIMIT3,0|FTP-TIMELIMIT_UNIT3,1|FTP-TRIM3,1|FTP-UNIQUE3,0|FTP-VERNUM3,0|";
			}
			if ( mftValue.indexOf("LPATH4") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME4,0|FTP-CASEIFS4,0|FTP-NULLFLDS4,0|FTP-TIMELIMIT4,0|FTP-TIMELIMIT_UNIT4,1|FTP-TRIM4,1|FTP-UNIQUE4,0|FTP-VERNUM4,0|";
			}
			if ( mftValue.indexOf("LPATH5") > -1 ) {
				iTransferNum++;
				strMftDefaultValue += "FTP-ABSTIME5,0|FTP-CASEIFS5,0|FTP-NULLFLDS5,0|FTP-TIMELIMIT5,0|FTP-TIMELIMIT_UNIT5,1|FTP-TRIM5,1|FTP-UNIQUE5,0|FTP-VERNUM5,0|";
			}
			
			strMftDefaultValue += "FTP-TRANSFER_NUM," + iTransferNum + "|";
			
			if ( strTset.length() > 0 ) {
				strTset = strTset + "|" + mftValue + strMftDefaultValue;
			}else {
				strTset = mftValue + strMftDefaultValue;
			}
			
			if ( strTset.substring(strTset.length()-1, strTset.length()).equals("[|]") ) {
				strTset = strTset.substring(0, strTset.length()-1);
			}
			
			strTset = strTset.replaceAll("FTP_", "FTP-");
			
			System.out.println("MFT 설정 변수 확인 map : " + map);
			System.out.println("MFT 설정 변수 확인2 strTset : " + strTset);
			
			logger.debug("MFT 변수 세팅 end ::::: " + strTset);
			
		}else if ( strTaskType.toLowerCase().equals("database") ) {
			//Database
			strTaskType		= "job";
			strApplType		= "DATABASE";
			strApplForm		= "Databases";
			System.out.println("map321321 : " + map);
			logger.debug("Database 변수 세팅 start ::::: " + strTset);
			
			strMemLib 	= "Database";
			strMemName 	= "Database";
			int idx		= 0;
			
			//Connection Profile
			if ( strTset.length() > 0 ) {
				strTset = strTset + "|" + "%%DB-ACCOUNT" + "," + CommonUtil.isNull(map.get("db_con_pro"));
			}else {
				strTset = "%%DB-ACCOUNT" + "," + CommonUtil.isNull(map.get("db_con_pro"));
			}
			
			if(!CommonUtil.isNull(map.get("database_type")).equals("")) 	strTset = strTset + "|" + "%%DB-DB_TYPE" + "," + CommonUtil.isNull(map.get("database_type"));
			if(!CommonUtil.isNull(map.get("execution_type")).equals("") || !CommonUtil.isNull(map.get("execution_type_input")).equals("")) {
				if(CommonUtil.isNull(map.get("execution_type")).equals("P") || CommonUtil.isNull(map.get("execution_type_input")).equals("P")) {
					strTset = strTset + "|" + "%%DB-EXEC_TYPE" + "," + "Stored Procedure";
					if(!CommonUtil.isNull(map.get("schema")).equals(""))	strTset = strTset + "|" + "%%DB-STP_SCHEM" + "," + CommonUtil.isNull(map.get("schema"));
					if(!CommonUtil.isNull(map.get("sp_name")).equals("")) 	strTset = strTset + "|" + "%%DB-STP_NAME" + "," + CommonUtil.isNull(map.get("sp_name"));
					for (int i=0;i<4;i++) {
						if(i == 0) {
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_name" + idx;
							    String paramName2 = "in_name" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_NAME" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_NAME" + "," + paramValue2;
							    }
								idx++;
							}
						}else if(i == 1) {
							idx = 0;
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_data" + idx;
							    String paramName2 = "in_data" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_TYPE" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_TYPE" + "," + paramValue2;
							    }
							    idx++;
							}
						}else if(i == 2) {
							idx = 0;
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_param" + idx;
							    String paramName2 = "in_param" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_DIRECTION" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_DIRECTION" + "," + paramValue2;
							    }
							    idx++;
							}
						}else{
							idx = 0;
							while (true) {
							    // 파라미터 이름 생성
							    String paramName1 = "ret_variable" + idx;
							    String paramName2 = "in_value" + idx;

							    // 파라미터 값 가져오기
							    String paramValue1 = CommonUtil.isNull(map.get(paramName1));
							    String paramValue2 = CommonUtil.isNull(map.get(paramName2));

							    // 두 파라미터 값이 모두 빈 문자열이면 종료
							    if (paramValue1.equals("") && paramValue2.equals("")) {
							        break;
							    }

							    // 빈 문자열이 아닌 경우에만 Map에 추가
							    if (!paramValue1.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_SETVAR" + "," + paramValue1;
							    }
							    if (!paramValue2.equals("")) {
							    	strTset = strTset + "|" + "%%DB-STP_PARAMS-P00"+(idx+1)+"-PRM_VALUE" + "," + paramValue2;
							    }
							    idx++;
							}
						}
						
					}
				}else if(CommonUtil.isNull(map.get("execution_type")).equals("Q") || CommonUtil.isNull(map.get("execution_type_input")).equals("Q")) {
					strTset = strTset + "|" + "%%DB-EXEC_TYPE" + "," + "Open Query";
					if(!CommonUtil.isNull(map.get("query")).equals("")) 	strTset = strTset + "|" + "%%DB-QTXT-N001-SUBQTXT" + "," + CommonUtil.replaceStrHtml(CommonUtil.isNull(map.get("query")));
					if(!CommonUtil.isNull(map.get("query")).equals("")) 	strTset = strTset + "|" + "%%DB-QTXT-N001-SUBQLENGTH" + "," + Integer.toString(CommonUtil.replaceStrHtml(CommonUtil.isNull(map.get("query"))).length());
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
			
		}
		
		try {
			
			JAXBContext context 				= JAXBContext.newInstance(RequestCreateJobType.class);
			RequestCreateJobType reqType 		= new RequestCreateJobType();
			java.io.StringWriter sw 			= new java.io.StringWriter();		
			
			reqType.setUserToken(strUserToken);
			reqType.setControlM(strDataCenter);
			
			IntervalSequenceType intervalSequenceType = new IntervalSequenceType();

			if( strIntervalSequence.length() > 0 ) {
				String[] t_interval_sequence = strIntervalSequence.split("[,]");				
				if ( null!=t_interval_sequence && 0<t_interval_sequence.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_interval_sequence.length; i++ ) {	
					
						alTmp.add("+" + t_interval_sequence[i] + strRerunIntervalTime);
					}
					
					intervalSequenceType.setIntervalItem(alTmp);
				}				
			}
			
			SpecificTimesType specificTimesType = new SpecificTimesType();

			if( strSpecificTimes.length() > 0 ) {
				String[] t_specific_time = strSpecificTimes.split("[,]");				
				if ( null!=t_specific_time && 0<t_specific_time.length ) {
					ArrayList<String> alTmp = new ArrayList();		
					for ( int i = 0; i < t_specific_time.length; i++ ) {	
					
						alTmp.add(t_specific_time[i]);
					}
					
					specificTimesType.setSpecificTime(alTmp);
				}				
			}
			
			// Active Job 설정.
			ActiveJobType activeJobType = new ActiveJobType();			
			if ( !strJobName.equals("") ) 			activeJobType.setJobName(strJobName);
			if ( !strTaskType.equals("") ) 			activeJobType.setTaskType(ActiveTaskType.fromValue(strTaskType.toLowerCase()));
			if ( !strApplication.equals("") ) 		activeJobType.setApplication(strApplication);
			if ( !strGroupName.equals("") ) 		activeJobType.setSubApplication(strGroupName);
			if ( !strMemLib.equals("") ) 			activeJobType.setMemLib(strMemLib);
			if ( !strMemName.equals("") ) 			activeJobType.setMemName(strMemName);
			if ( !strOwner.equals("") ) 			activeJobType.setRunAs(strOwner);
			if ( !strDescription.equals("") ) 		activeJobType.setDescription(strDescription);
			if ( !strCommand.equals("") ) 			activeJobType.setCommand(strCommand);
			if ( !strTableName.equals("") ) 		activeJobType.setOrderFolder(strTableName);
			if ( !strNodeId.equals("") ) 			activeJobType.setNodeGroup(strNodeId);
			if ( !strMultiagent.equals("") ) 		activeJobType.setMultiagent(YesNoType.fromValue(CommonUtil.getMessage("JOB.MULTIAGENT."+strMultiagent)));
			if ( !strConfirmFlag.equals("") ) 		activeJobType.setConfirmFlag(YesNoType.fromValue(CommonUtil.getMessage("JOB.CONFIRM_FLAG."+strConfirmFlag)));
			if ( !strPriority.equals("") ) 			activeJobType.setPriority(strPriority);
			if ( !strCritical.equals("") ) 			activeJobType.setCritical(YesNoType.fromValue(CommonUtil.getMessage("JOB.CRITICAL."+strCritical)));
			if ( !strTimeFrom.equals("") ) 			activeJobType.setTimeFrom(strTimeFrom);
			if ( !strTimeUntil.equals("") ) 		activeJobType.setTimeUntil(strTimeUntil);
			if ( !strTimeZone.equals("") ) 			activeJobType.setTimeZone(strTimeZone);
			if ( !strCyclic.equals("") ) 			activeJobType.setCyclic(YesNoType.fromValue(CommonUtil.getMessage("JOB.CYCLIC."+strCyclic)));
			//if ( !strRerunInterval.equals("") ) 	activeJobType.setRerunInterval(strRerunInterval + strRerunIntervalTime);
			if ( !strRerunInterval.equals("") ) 	activeJobType.setRerunInterval(strRerunInterval);
			if ( !strCountCyclicFrom.equals("") ) 	activeJobType.setCountCyclicFrom(StartEndTargetType.fromValue(strCountCyclicFrom));
			if ( !strRerunMax.equals("") ) 			activeJobType.setRerunMax(strRerunMax);
			if ( !strMaxWait.equals("") ) 			activeJobType.setMaxWait(strMaxWait);
			if ( !strCyclicType.equals("") ) 		activeJobType.setCyclicType(CyclicTypeType.fromValue(CommonUtil.getMessage("JOB.CYCLIC_TYPE."+strCyclicType)));
			if ( !strIntervalSequence.equals("") ) 	activeJobType.setIntervalSequence(intervalSequenceType);
			if ( !strTolerance.equals("") ) 		activeJobType.setTolerance(strTolerance);
			if ( !strSpecificTimes.equals("") ) 	activeJobType.setSpecificTimes(specificTimesType);
			
			activeJobType.setApplicationType(strApplType);
			
			//Kubernetes일 경우 appl_type 값 추가
			if ( !strApplType.equals("") )			activeJobType.setApplicationType(strApplType);
			if(strApplType == "FILE_TRANS") {
				if ( !strApplForm.equals("") )			activeJobType.setApplicationForm(strApplForm);
			}else {
				if ( !strApplType.equals("") )			activeJobType.setApplicationForm(strApplType);
			}
			
			// In Condition.
			if ( strTconditionIn.length() > 0 ) {
				
				try {
					activeJobType.setInConditions(getInConditions(strTconditionIn));
				} catch (Exception e) {
					throw new IllegalArgumentException("InCondition ERROR");
				}
			}
			
			// Out Condition.
			if ( strTconditionOut.length() > 0 ) {
				try {
					activeJobType.setOutConditions(getOutConditions(strTconditionOut));
				} catch (Exception e) {
					throw new IllegalArgumentException("OutCondition ERROR");
				}				
			}
			
			// Quantitatvie Resouce.
			if ( strTresourcesQ.length() > 0 ) {
				activeJobType.setQuantitativeResources(getQresources(strTresourcesQ));
			}
			
			// Control Resouce.
			if ( strTresourcesC.length() > 0 ) {
				activeJobType.setControlResources(getCresources(strTresourcesC));
			}
			
			// Set 변수.
			if ( strTset.length() > 0 ) {
				activeJobType.setVariableAssignments(getVariableAssignments(strTset));
			}
			
			// Step.
			if ( strTsteps.length() > 0 ) {				
				activeJobType.setOnDoStatements(getOnDoStatements(strTsteps));				
			}
			
			// PostProc.
			if ( strTpostproc.length() > 0 ) {				
				activeJobType.setShouts(getShouts(strTpostproc));				
			}
			
			reqType.setActiveJob(activeJobType);			
	
			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
	
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);
				
			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);
				
			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				strResXml = strResXml.replaceAll("response_order_force", "simple_token_response_type").replaceAll(" xmlns:ctmem=\"http://www.bmc.com/ctmem/schema900\"", "").replaceAll("ctmem:", "");
				
				// 언마샬링 해서 값을 담는다.
				JAXBElement<SimpleTokenResponseType> dataRoot = (JAXBElement<SimpleTokenResponseType>) CommonUtil.unmarshaller(SimpleTokenResponseType.class, strResXml);
				
	            map.put("rCode", "1");
				map.put("rType", "simple_token_response_type");
				map.put("rObject", dataRoot);
				
				String strResponseToken = CommonUtil.isNull(dataRoot.getValue().getResponseToken());
				
				// 폴링 해서 order_id 값을 구한다.
				if ( !strResponseToken.equals("") ) {
					
					Map pollReturnMap = getPollData(strUserToken, strResponseToken);
					
					String strOrderId 	= CommonUtil.isNull(pollReturnMap.get("order_id"));
					String strErrorMsg 	= CommonUtil.isNull(pollReturnMap.get("rMsg"));
					String strCode 		= CommonUtil.isNull(pollReturnMap.get("rCode"));
					String strType	 	= CommonUtil.isNull(pollReturnMap.get("rType"));
					
					map.put("rMsg", 	strErrorMsg);
					map.put("rCode", 	strCode);
					map.put("rType", 	strType);					
					map.put("rOrderId", strOrderId);
				}
			}
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;
	}
    
	public Map defUploadjobs(Map map) throws Exception{

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strTableName 		= CommonUtil.isNull(map.get("table_name"));
		String strParentTableName	= "";
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		// 부모 테이블 조회.
		// 업로드 시 최상위 테이블만 명시해야 제대로 업로드 된다.
		if ( strTableName.indexOf("/") > 0 ) {
			strParentTableName	= strTableName.substring(0, strTableName.indexOf("/"));
		} else {
			strParentTableName = strTableName;
		}
		
		try {
			
			JAXBContext context 				= JAXBContext.newInstance(RequestDefUploadFolderType.class);			
			RequestDefUploadFolderType reqType 	= new RequestDefUploadFolderType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			// 테이블 설정.
			AnyFolderType anyFolderType = new AnyFolderType();
			anyFolderType.setControlM(strDataCenter);
			anyFolderType.setFolderName(strParentTableName);
			
			reqType.setUserToken(strUserToken);
			reqType.setFolder(anyFolderType);
			reqType.setForceIt(YesNoType.fromValue("yes"));

			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
	
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);
				
			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);

			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				// 언마샬링 해서 값을 담는다.
	            JAXBElement<ResponseDefUploadFolderType> dataRoot = (JAXBElement<ResponseDefUploadFolderType>) CommonUtil.unmarshaller(ResponseDefUploadFolderType.class, strResXml);
	            
	            map.put("rCode", "1");
				map.put("rType", "response_def_upload_folder_type");
				map.put("rObject", dataRoot);
			}			
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;
	}
    
	// 작업 삭제.
	public Map deleteJobs(Map map) throws Exception{

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}

		Doc03Bean docBean		= (Doc03Bean)map.get("doc03");		
		
		String strDataCenter 	= CommonUtil.isNull(docBean.getData_center());
		String strTableName 	= CommonUtil.isNull(docBean.getTable_name());
		
		String strApplication 	= CommonUtil.isNull(docBean.getApplication());
		String strGroupName 	= CommonUtil.isNull(docBean.getGroup_name());
		String strJobName 		= CommonUtil.isNull(docBean.getJob_name());
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
	
		try {
			
			JAXBContext context 				= JAXBContext.newInstance(RequestDefDeleteJobsType.class);
			RequestDefDeleteJobsType reqType 	= new RequestDefDeleteJobsType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			// 테이블 설정.
			AnyFolderType anyFolderType = new AnyFolderType();
			anyFolderType.setControlM(strDataCenter);
			anyFolderType.setFolderName(strTableName);
			
			ArrayList<ParamType> alTmp = new ArrayList();
			
			if( !strApplication.equals("") ) {
				
				ParamType paramType = new ParamType();				
				paramType.setName("APPLICATION");
				paramType.setOperator(OperatorType.EQ);
				paramType.setValue(strApplication);
						
				alTmp.add(paramType);
			}
			
			if( !strGroupName.equals("") ) {
				
				ParamType paramType = new ParamType();
				paramType.setName("GROUP_NAME");
				paramType.setOperator(OperatorType.EQ);
				paramType.setValue(strGroupName);
						
				alTmp.add(paramType);
			}
			
			if( !strJobName.equals("") ) {
				
				ParamType paramType = new ParamType();				
				paramType.setName("JOB_NAME");
				paramType.setOperator(OperatorType.EQ);
				paramType.setValue(strJobName);
						
				alTmp.add(paramType);
			}
			
			SearchCriterionType searchCriterionType = new SearchCriterionType();
			searchCriterionType.setParam(alTmp);
			
			ArrayList<SearchCriterionType> alTmp2 = new ArrayList();
			alTmp2.add(searchCriterionType);
		
			FilterType filterType = new FilterType();	
			filterType.setSearchCriterion(alTmp2);
			
			CriterionType criterionType = new CriterionType();
			criterionType.setInclude(filterType);
			
			reqType.setUserToken(strUserToken);
			reqType.setFolder(anyFolderType);
			reqType.setDeleteJobsCriterion(criterionType);			

			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
	
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);
				
			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);
				
			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				// [org.apache.xerces.impl.io.MalformedByteSequenceException: 1-바이트 UTF-8 순서 중 1바이트가 올바르지 않습니다.]
				// LANG=C 환경에서 위의 에러가 나면서 Exception 떨어지기 때문에 table_name 제거해보았다.
				String strResXml2 	= strResXml.substring(0, strResXml.indexOf("<ctmem:folder_name>")+19);
				strResXml2 			+= strResXml.substring(strResXml.indexOf("</ctmem:folder_name>"), strResXml.length());
				
				// 언마샬링 해서 값을 담는다.
	            JAXBElement<ResponseDefDeleteJobsType> dataRoot = (JAXBElement<ResponseDefDeleteJobsType>) CommonUtil.unmarshaller(ResponseDefDeleteJobsType.class, strResXml2);
	            
	            map.put("rCode", "1");
				map.put("rType", "response_def_delete_jobs_type");
				map.put("rObject", dataRoot);
			}
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;
	}
    
	// 작업 오더.
	public Map jobsOrder(Map map) throws Exception {

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		String strOrderIntoFolder	= CommonUtil.isNull(map.get("order_into_folder"));
		String strDataCenter 		= "";
		String strForceGubun 		= "";
		String strHoldGubun 		= "";
		String strWaitGubun 		= "";
		String strTableName 		= "";
		String strJobName 			= "";
		String strOrderDate 		= "";
		String strForOdate 			= "";
		String strTaskType 			= "";
		String strTableInfoMent 	= "";
		String strTset 				= "";
		
		Doc05Bean docBean 		= null;
		docBean					= (Doc05Bean) map.get("doc05");
		// docBean 이 null 이면 작업 등록 시 특정실행날짜가 있어서 호출하는 ORDER.
		if ( docBean == null ) {
			
			strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
			strForceGubun		= CommonUtil.isNull(map.get("force_gubun"), "no");
			strHoldGubun		= CommonUtil.isNull(map.get("hold_gubun"), "no");
			strWaitGubun		= CommonUtil.isNull(map.get("wait_gubun"), "no");
			strTableName		= CommonUtil.isNull(map.get("table_name"));
			strJobName 			= CommonUtil.isNull(map.get("job_name"));
			strOrderDate		= CommonUtil.isNull(map.get("order_date"));
			strTaskType			= CommonUtil.isNull(map.get("task_type"));
			strTset				= CommonUtil.isNull(map.get("t_set"));

			// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
			if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
				strDataCenter = strDataCenter.split(",")[1];
			}
			
			if ( strOrderDate.equals("") ) {
				strOrderDate = CommonUtil.getCurDate("YMD");
			}
			
			// no : ODATE를 기다리지 않고 당일 수행.
			if ( strForceGubun.equals("yes") ) {
				strForOdate = "no";
				//forOdate = "yes";
			} else {
				//forOdate = "yes";
				strForOdate = "no";
			}
			
		// docBean 에 값이 있으면 직접 호출하는 ORDER.
		} else {
			
			strDataCenter				= CommonUtil.isNull(docBean.getData_center(), "");			
			strTableName				= CommonUtil.isNull(docBean.getTable_name(), "");
			strJobName					= CommonUtil.isNull(docBean.getJob_name(), "");
			strOrderDate				= CommonUtil.isNull(docBean.getOrder_date(), "");
			strTaskType					= CommonUtil.isNull(docBean.getTask_type(), "");
			strTset						= CommonUtil.isNull(docBean.getT_set(), "");
			
			String strForceYn			= CommonUtil.isNull(docBean.getForce_yn(), "");			
			String strHoldYn			= CommonUtil.isNull(docBean.getHold_yn(), "");
			String strWaitForOdateYn	= CommonUtil.isNull(docBean.getWait_for_odate_yn(), "");
			
			// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
			if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
				strDataCenter = strDataCenter.split(",")[1];
			}
			
			if(strOrderIntoFolder.equals("") || strOrderIntoFolder.equals("New")) {
				strTableInfoMent = "new";
			}else {
				strTableInfoMent = "selected";
			}
			
			// 테이블을 오더 할 경우엔 작업명을 * 로 셋팅해준다.
			if ( strTaskType.equals("SMART Table") ) {
				strJobName = "*";
			}
		
			strHoldGubun = "no";
			if ( strHoldYn.equals("Y") ) {
				strHoldGubun = "yes";
			}
			
			strForceGubun = "no";
			if ( strForceYn.equals("Y") ) {
				strForceGubun = "yes";
			}
			
			strWaitGubun = "no";
			if ( strWaitForOdateYn.equals("Y") ) {
				strWaitGubun = "yes";
			}

			// no : ODATE를 기다리지 않고 당일 수행.
			if ( strWaitGubun.equals("yes") ) {
				strForOdate = "yes";
			} else {
				strForOdate = "no";
			}
			
			if ( strOrderDate.equals("") ) {
				strOrderDate = CommonUtil.getCurDate("YMD");
			}			
		}
		
		try {
			
			JAXBContext context 				= JAXBContext.newInstance(RequestOrderForceJobType.class);			
			RequestOrderForceJobType reqType 	= new RequestOrderForceJobType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			FolderInfoType folderInfoType = new FolderInfoType();
			folderInfoType.setIntoFolder(strTableInfoMent);
			//tableInfoType.setIntoTable("standalone");
			
			if ( strTableInfoMent.equals("selected") ) {
				folderInfoType.setFolderId(strOrderIntoFolder);
				folderInfoType.setAllowDup("yes");
			}
			
			reqType.setUserToken(strUserToken);
			reqType.setControlM(strDataCenter);
			reqType.setForceIt(strForceGubun);
			reqType.setWithHold(strHoldGubun);
			reqType.setFolderName(strTableName);
			reqType.setJobName(strJobName);
			reqType.setOdate(strOrderDate);
			reqType.setWaitForOdate(YesNoType.fromValue(strForOdate));
			reqType.setFolderInfo(folderInfoType);
			
			// Set 변수.
			if ( strTset.length() > 0 ) {
				reqType.setVariableAssignments(getVariableAssignments(strTset));
			}

			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
	
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			System.out.println(":::::strReqXml" + strReqXml);
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);
				
			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);
				
			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				/*strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				strResXml = strResXml.replaceAll("response_order_force", "simple_token_response_type").replaceAll(" xmlns:ctmem=\"http://www.bmc.com/ctmem/schema900\"", "").replaceAll("ctmem:", "");
		
				// 언마샬링 해서 값을 담는다.
	            JAXBElement<SimpleTokenResponseType> dataRoot = (JAXBElement<SimpleTokenResponseType>) CommonUtil.unmarshaller(SimpleTokenResponseType.class, strResXml);*/
				
				int start = strResData.indexOf("Body>") + 5;
				Matcher m = Pattern.compile("</[^>]*Body").matcher(strResData);
				m.find();
				int end = m.start();
				String output = strResData.substring(start, end);
				output = output.replaceAll("response_order_force", "simple_token_response_type");
	
				Unmarshaller unmarshaller = JAXBContext.newInstance(SimpleTokenResponseType.class).createUnmarshaller();
				SimpleTokenResponseType dataRoot = (SimpleTokenResponseType) unmarshaller.unmarshal(new ByteArrayInputStream(output.getBytes("UTF-8")));
				
	            
	            map.put("rCode", "1");
				map.put("rType", "simple_token_response_type");
				map.put("rObject", dataRoot);
				
				//String strResponseToken = CommonUtil.isNull(dataRoot.getValue().getResponseToken());
				String strResponseToken = CommonUtil.isNull(dataRoot.getResponseToken());
				
				System.out.println("strResponseToken : " + strResponseToken);
		
				// 폴링 해서 order_id 값을 구한다.
				if ( !strResponseToken.equals("") ) {
					
					Map pollReturnMap = getPollData(strUserToken, strResponseToken);
					
					String strOrderId 	= CommonUtil.isNull(pollReturnMap.get("order_id"));
					String strErrorMsg 	= CommonUtil.isNull(pollReturnMap.get("rMsg"));
					String strCode 		= CommonUtil.isNull(pollReturnMap.get("rCode"));
					String strType	 	= CommonUtil.isNull(pollReturnMap.get("rType"));
					
					System.out.println("strOrderId : " + strOrderId);
					
					map.put("rMsg", 	strErrorMsg);
					map.put("rCode", 	strCode);
					map.put("rType", 	strType);					
					map.put("rOrderId", strOrderId);
				}
			}
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;				
	}
    
	// 작업 상태 변경.
	public Map jobAction(Map map) throws Exception{

		String strUserToken		= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken		= getUserToken();
		}
		String strDataCenter 	= CommonUtil.isNull(map.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(map.get("order_id"));
		String strFlag 			= CommonUtil.isNull(map.get("flag"));
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
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

		try {
			
			logger.debug("#T_Manger4 | jobAction | user_token :::"+strUserToken);
			logger.debug("#T_Manger4 | jobAction | data_center :::"+strDataCenter);
			logger.debug("#T_Manger4 | jobAction | order_id :::"+strOrderId);
			logger.debug("#T_Manger4 | jobAction | flag :::"+strFlag);
			
			JAXBContext context 				= JAXBContext.newInstance(RequestGenActionType.class);			
			RequestGenActionType reqType 		= new RequestGenActionType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			reqType.setUserToken(strUserToken);
			reqType.setControlM(strDataCenter);
			reqType.setOrderId(strOrderId);
			
			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
			
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);

			// 작업 상태 변경은 XmlRootElement만 바뀌면 된다. 
			if("HOLD".equals(strFlag)){
				strReqXml = strReqXml.replaceAll("request_gen_action", "request_aj_hold");
			}else if("CONFIRM".equals(strFlag)){
				strReqXml = strReqXml.replaceAll("request_gen_action", "request_aj_confirm");
			}else if("FORCEOK".equals(strFlag)){
				strReqXml = strReqXml.replaceAll("request_gen_action", "request_aj_set_to_ok");
			}else if("FREE".equals(strFlag)){
				strReqXml = strReqXml.replaceAll("request_gen_action", "request_aj_free");
			}else if("KILL".equals(strFlag)){
				strReqXml = strReqXml.replaceAll("request_gen_action", "request_aj_kill");
			}else if("RERUN".equals(strFlag)){
				strReqXml = strReqXml.replaceAll("request_gen_action", "request_aj_rerun");
			}else if( "DELETE".equals(strFlag) ){
				
				try{
					String cmd 		= "ctmpsm -UPDATEAJF "+strOrderId+" HOLD \r\n ctmpsm -UPDATEAJF "+strOrderId+" DELETE";					
					String host 	= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".HOST") );
					int port 		= Integer.parseInt(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".PORT"),"22" ));
					String user 	= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".USER") );
					String pw 		= CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".PW") );
					String hostname = CommonUtil.isNull(CommonUtil.getMessage("EZJOBS_HOSTNAME") );
					
					logger.debug("#T_Manger4 | jobAction | cmd :::"+ cmd);
					logger.debug("#T_Manger4 | jobAction | host :::"+ host);
					logger.debug("#T_Manger4 | jobAction | port :::"+ port);
					logger.debug("#T_Manger4 | jobAction | user :::"+ user);
					logger.debug("#T_Manger4 | jobAction | pw :::"+ pw);
					logger.debug("#T_Manger4 | jobAction | hostname :::"+ hostname);
					
					if(!"".equals(host)){
						
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
						
							if( "SSH".equals(CommonUtil.isNull(CommonUtil.getMessage("CM.TERMINAL."+strDataCenter.toUpperCase()+".GB"))) ){
								Ssh2Util su = new Ssh2Util(host, port, user, pw, cmd, "UTF-8");
								System.out.println("Ssh2Util OK.");
							}else{
								TelnetUtil tu = new TelnetUtil(host,port,user,pw,cmd);
								System.out.println("TelnetUtil OK.");
							}
						}
					}
				}catch(Exception e){
					logger.error(e.getMessage());
				}
			}
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			logger.info("jobAction strResData : " + strResData);

			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);				
				
			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("r_code", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);

			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
//				ObjectFactory objectFactory = new ObjectFactory();
//				objectFactory.createResponseAjHold(value)
				
//				strResXml 			= strResData;		
				logger.debug("#T_Manger4 | jobAction |strResXml : " + strResXml);
				
				// 작업 상태 변경은 XmlRootElement만 바뀌면 된다. 
//				if("HOLD".equals(strFlag)){
//					strResXml = strResXml.replaceAll("response_aj_hold", "response_poll_gen_action");
//				}else if("CONFIRM".equals(strFlag)){
//					strResXml = strResXml.replaceAll("response_aj_confirm", "response_poll_gen_action");
//				}else if("FORCEOK".equals(strFlag)){
//					strResXml = strResXml.replaceAll("response_aj_set_to_ok", "response_poll_gen_action");
//				}else if("FREE".equals(strFlag)){
//					strResXml = strResXml.replaceAll("response_aj_free", "response_poll_gen_action");
//				}else if("KILL".equals(strFlag)){
//					strResXml = strResXml.replaceAll("response_aj_kill", "response_poll_gen_action");
//				}else if("RERUN".equals(strFlag)){
//					strResXml = strResXml.replaceAll("response_aj_rerun", "response_poll_gen_action");
////					strResXml = strResXml.replaceAll("response_aj_rerun", "response_poll_gen_action");
//				}			
//				strResXml = strResXml.replaceAll("ctmem:", "");
//				strResXml = strResXml.replaceAll(":ctmem", "");
				
//				ByteArrayInputStream bais 				= new ByteArrayInputStream(strResXml.getBytes());	        
//		        JAXBContext context2 					= JAXBContext.newInstance(ResponsePollGenActionType.class);
//	            Unmarshaller unMarshaller 				= context2.createUnmarshaller();
//	            ResponsePollGenActionType dataRoot 		= (ResponsePollGenActionType) unMarshaller.unmarshal(bais);
	            
				
				
				// 언마샬링 해서 값을 담는다.
				JAXBElement<SimpleTokenResponseType> dataRoot = (JAXBElement<SimpleTokenResponseType>) CommonUtil.unmarshaller(SimpleTokenResponseType.class, strResXml);

	            map.put("rCode", "1");
				map.put("r_code", "1");
				map.put("rType", "response_poll_gen_action");
				map.put("rObject", dataRoot);
				
				logger.debug("#T_Manger4 | jobAction |strResXml : End-------------");
			}
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;
	}
	
	// In Condition.
	public static InConditionsType getInConditions(String strTconditionIn) {
		
		InConditionsType inConditionsType = new InConditionsType();
		
		try {
			
			String[] t_conditions_in = strTconditionIn.split("[|]");
		    if ( t_conditions_in != null && t_conditions_in.length > 0 ) {
		    	ArrayList<InConditionType> alTmp = new ArrayList();
		    	for ( int i = 0; i < t_conditions_in.length; i++ ) {
					String[] aTmp = t_conditions_in[i].split(",",3);
					String condition	= CommonUtil.isNull(aTmp[0]);
					String parentheses	= "";

					if( condition.indexOf("(") == 0 ) {
						condition = condition.replace("(", "");
						parentheses = "(";

					}

					if (condition.charAt(condition.length() - 1) == ')') {
						condition = condition.replace(")", "");
						parentheses = ")";
					}

					InConditionType inConditionType = new InConditionType();
					if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) inConditionType.setCondition(condition);
					if ( !"".equals(CommonUtil.isNull(aTmp[1])) ) inConditionType.setDate(CommonUtil.isNull(aTmp[1]));
					if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) inConditionType.setAndOr(AndOrType.fromValue(CommonUtil.isNull(aTmp[2])));
					if ( !"".equals(parentheses) ) inConditionType.setParentheses(parentheses);
					alTmp.add(inConditionType);
		    	}
		    	
		    	inConditionsType.setInCondition(alTmp);
		    }
		    
		} catch (Exception e) {			
			throw new IllegalArgumentException();
		}
	    
	    return inConditionsType;
	}
	
	// Out Condition.
	public static OutConditionsType getOutConditions(String strTconditionOut) {
		
		OutConditionsType outConditionsType = new OutConditionsType();
		
		try {
		
			String[] t_conditions_out = strTconditionOut.split("[|]");
		    if ( t_conditions_out != null && t_conditions_out.length > 0 ) {
		    	ArrayList<OutConditionType> alTmp = new ArrayList();
		    	for ( int i = 0; i < t_conditions_out.length; i++ ) {
					String[] aTmp = t_conditions_out[i].split(",",3);
					
					OutConditionType outConditionType = new OutConditionType();
					if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) outConditionType.setCondition(CommonUtil.isNull(aTmp[0]));
					if ( !"".equals(CommonUtil.isNull(aTmp[1])) ) outConditionType.setDate(CommonUtil.isNull(aTmp[1]));
					if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) outConditionType.setSign(AddDeleteType.fromValue(CommonUtil.isNull(aTmp[2])));
					
					alTmp.add(outConditionType);
		    	}
		    	
		    	outConditionsType.setOutCondition(alTmp);	    	
		    }
		    
		} catch (Exception e) {
			throw new IllegalArgumentException();
		}
	    
	    return outConditionsType;
	}
	
	// Quantitatvie Resouce.
	public static QuantitativeResourcesType getQresources(String strTresourcesQ) {
		
		QuantitativeResourcesType quantitativeResourcesType = new QuantitativeResourcesType();
		
		String[] t_resources_q = strTresourcesQ.split("[|]");
	    if ( t_resources_q != null && t_resources_q.length > 0 ) {
	    	ArrayList<QuantitativeResourceType> alTmp = new ArrayList();
	    	for ( int i = 0; i < t_resources_q.length; i++ ) {
				String[] aTmp = t_resources_q[i].split(",",2);
				
				QuantitativeResourceType quantitativeResourceType = new QuantitativeResourceType();						
				if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) quantitativeResourceType.setResource(CommonUtil.isNull(aTmp[0]));
				if ( !"".equals(CommonUtil.isNull(aTmp[1])) ) quantitativeResourceType.setQuantity(CommonUtil.isNull(aTmp[1]));
				
				alTmp.add(quantitativeResourceType);
	    	}
	    	
	    	quantitativeResourcesType.setQuantitativeResource(alTmp);	    	
	    }
	    
	    return quantitativeResourcesType;
	}

	// Control Resouce.
	public static ControlResourcesType getCresources(String strTresourcesC) {
	
		ControlResourcesType controlResourcesType = new ControlResourcesType();
		
		String[] t_resources_c = strTresourcesC.split("[|]");
	    if ( t_resources_c != null && t_resources_c.length > 0 ) {
	    	ArrayList<ControlResourceType> alTmp = new ArrayList();
	    	for ( int i = 0; i < t_resources_c.length; i++ ) {
				String[] aTmp = t_resources_c[i].split(",",2);
				
				ControlResourceType controlResourceType = new ControlResourceType();						
				if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) controlResourceType.setResource(CommonUtil.isNull(aTmp[0]));
				if ( !"".equals(CommonUtil.isNull(aTmp[1])) ) controlResourceType.setType(ExclusiveSharedType.fromValue(CommonUtil.isNull(aTmp[1])));
				
				alTmp.add(controlResourceType);
	    	}
	    	
	    	controlResourcesType.setControlResource(alTmp);
	    }
	    
	    return controlResourcesType;
	}
	
	// Set 변수.
	public static VariableAssignmentsType getVariableAssignments(String strTset) {
		
		VariableAssignmentsType variableAssignmentsType = new VariableAssignmentsType();
		
		String[] t_set = strTset.split("[|]");
	    if ( t_set != null && t_set.length > 0 ) {
	    	ArrayList<VariableAssignmentType> alTmp = new ArrayList();
	    	for ( int i = 0; i < t_set.length; i++ ) {
				String[] aTmp = t_set[i].split(",",2);
				
				VariableAssignmentType variableAssignmentType = new VariableAssignmentType();
				
				if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) variableAssignmentType.setName(CommonUtil.isNull(aTmp[0]));
//				if ( !"".equals(CommonUtil.isNull(aTmp[1])) ) variableAssignmentType.setValue(CommonUtil.isNull(aTmp[1]));
				
				//변수 값이 없으면 C-M에 NULL값으로 들어가도록 수정
				// 변수 값이 없으면 9.0.21.300 부터 Name or Value is missing 이라는 알 수 없는 오류가 발생해서 값이 없을 경우 공백 하나 넣어주는 걸로 수정 (2025.1.7 강명준)
				variableAssignmentType.setValue(CommonUtil.isNull(aTmp[1], " "));
				
				alTmp.add(variableAssignmentType);
	    	}	    	
	    	
	    	variableAssignmentsType.setVariableAssignment(alTmp);	    	
	    }
	    
	    return variableAssignmentsType;
	}
	
	// Set 변수.
	public static VariableAssignmentsType getVariableAssignments_JBB(String strTset) {
		
		VariableAssignmentsType variableAssignmentsType = new VariableAssignmentsType();

	    ArrayList<VariableAssignmentType> alTmp = new ArrayList();
			
		VariableAssignmentType variableAssignmentType = new VariableAssignmentType();
				
		variableAssignmentType.setName("PARM1");
		variableAssignmentType.setValue(strTset);
		
		alTmp.add(variableAssignmentType);
	    	
		variableAssignmentsType.setVariableAssignment(alTmp);
	    
	    return variableAssignmentsType;
	}
	
	// Step.
	public static OnDoStatementsType getOnDoStatements(String strTsteps) {
		
		OnDoStatementsType onDoStatementsType 	= new OnDoStatementsType();
		OnDoStatementType onDoStatementType 	= new OnDoStatementType();
		
		DoStatementsType doStatementsType 		= new DoStatementsType();
		
		ArrayList<OnDoStatementType> onDoArray 	= new ArrayList();

		String[] t_steps = strTsteps.split("[|]");
	    if ( t_steps != null && t_steps.length > 0 ) {
	    	
	    	ArrayList<DoType> doArray 				= new ArrayList();
	    	ArrayList<DoVariableType> doAutoArray 	= new ArrayList();
	    	ArrayList<DoShoutType> doShoutArray 	= new ArrayList();
	    	ArrayList<DoForcejobType> doForceArray 	= new ArrayList();
	    	ArrayList<DoOutputType> doSysoutArray 	= new ArrayList();
	    	ArrayList<DoCondType> doCondArray 		= new ArrayList();
	    	ArrayList<DoMailType> doMailArray 		= new ArrayList();
	    	
	    	// 마지막 DO 일 경우 초기화 위해서 셋팅.
	    	String strLastDoInx = "";
	    	for ( int i = 0; i < t_steps.length; i++ ) {

				String[] aTmp = t_steps[i].split(",");
				
				if ( aTmp[0].equals("O") && i > 0 ) {
					strLastDoInx = Integer.toString(i - 1) + ",";
				}
	    	}
	    	strLastDoInx += Integer.toString(t_steps.length-1);	    	
	    	
	    	for ( int i = 0; i < t_steps.length; i++ ) {
	    		
	    		ArrayList<OnStatementType> onArray 		= new ArrayList();
		    	
		    	OnStatementType onStatementType 		= new OnStatementType();
		    	OnStatementsType onStatementsType 		= new OnStatementsType();
		    	
		    	DoVariableType doAutoeditType 			= new DoVariableType();
		    	DoShoutType doShoutType 				= new DoShoutType();
		    	DoForcejobType doForcejobType 			= new DoForcejobType();
		    	DoOutputType doSysoutType 				= new DoOutputType();
		    	DoCondType doCondType 					= new DoCondType();
		    	DoMailType doMailType 					= new DoMailType();
		    	DoType doType 							= new DoType();

				String[] aTmp = t_steps[i].split(",");
				
				if ( aTmp[0].equals("O") ) {
				
					if ( aTmp[1].equals("Statement") ) {
						
						aTmp = t_steps[i].split(",",4);
						
						if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) onStatementType.setStatement(CommonUtil.isNull(aTmp[2]));
						if ( !"".equals(CommonUtil.isNull(aTmp[3])) ) onStatementType.setCode(CommonUtil.isNull(aTmp[3]));

						onArray.add(onStatementType);
					}
					
					onStatementsType.setOnStatement(onArray);	

				} else {
					
					if ( aTmp[1].equals("Set-Var") ) {
						
						aTmp = t_steps[i].split(",",4);
						
						if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) doAutoeditType.setName(CommonUtil.isNull(aTmp[2]));
						if ( !"".equals(CommonUtil.isNull(aTmp[3])) ) doAutoeditType.setValue(CommonUtil.isNull(aTmp[3]));
						
						doAutoArray.add(doAutoeditType);
						
					} else if ( aTmp[1].equals("Shout") ) {
						
						aTmp = t_steps[i].split(",",5);
						
						if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) doShoutType.setDestination(CommonUtil.isNull(aTmp[2]));
						doShoutType.setUrgency(UrgencyType.fromValue(aTmp[3]));								
						if ( !"".equals(CommonUtil.isNull(aTmp[4])) ) doShoutType.setMessage(CommonUtil.isNull(aTmp[4]));
						
						doShoutArray.add(doShoutType);
						
					} else if ( aTmp[1].equals("Force-Job") ) {
						
						aTmp = t_steps[i].split(",",5);								
						
						if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) doForcejobType.setFolder(CommonUtil.isNull(aTmp[2]));
						if ( !"".equals(CommonUtil.isNull(aTmp[3])) ) doForcejobType.setJob(CommonUtil.isNull(aTmp[3]));
						if ( !"".equals(CommonUtil.isNull(aTmp[4])) ) doForcejobType.setOdate(CommonUtil.isNull(aTmp[4]));
						
						doForceArray.add(doForcejobType);
						
					} else if ( aTmp[1].equals("Sysout") ) {
						
						aTmp = t_steps[i].split(",",4);
						
						doSysoutType.setOption(aTmp[2]);
						if ( !"".equals(CommonUtil.isNull(aTmp[3])) ) doSysoutType.setParameter(CommonUtil.isNull(aTmp[3]));
						
						doSysoutArray.add(doSysoutType);
						
					} else if ( aTmp[1].equals("Condition") ) {
						
						aTmp = t_steps[i].split(",",5);
						
						
						if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) doCondType.setCondition(CommonUtil.isNull(aTmp[2]));
						if ( !"".equals(CommonUtil.isNull(aTmp[3])) ) doCondType.setDate(CommonUtil.isNull(aTmp[3]));
						doCondType.setSign(AddDeleteType.fromValue(aTmp[4]));
						
						doCondArray.add(doCondType);
					
					} else if ( aTmp[1].equals("Mail") ) {
						
						aTmp = t_steps[i].split(",",7);
						
						if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) doMailType.setTo(CommonUtil.isNull(aTmp[2]));
						if ( !"".equals(CommonUtil.isNull(aTmp[3])) ) doMailType.setCc(CommonUtil.isNull(aTmp[3]));
						if ( !"".equals(CommonUtil.isNull(aTmp[4])) ) doMailType.setSubject(CommonUtil.isNull(aTmp[4]));
						if ( !"".equals(CommonUtil.isNull(aTmp[5])) ) doMailType.setUrgency(UrgencyType.fromValue(aTmp[5]));
						if ( !"".equals(CommonUtil.isNull(aTmp[6])) ) doMailType.setMessage(CommonUtil.isNull(aTmp[6]));
						
						doMailArray.add(doMailType);
						
					} else {
						
						if (  aTmp[1].equals("Stop Cyclic") ) {
							doType.setAction("SPCYC");
						} else {
							doType.setAction(aTmp[1]);
						}
						
						doArray.add(doType);
					}
					
					doStatementsType.setDoVariable(doAutoArray);
					doStatementsType.setDoShout(doShoutArray);
					doStatementsType.setDoForcejob(doForceArray);
					doStatementsType.setDoOutput(doSysoutArray);
					doStatementsType.setDoCond(doCondArray);
					doStatementsType.setDoMail(doMailArray);
					doStatementsType.set_do(doArray);					
				}
				
				if ( onStatementsType.getOnStatement().size() > 0 ) {
					onDoStatementType.setOnStatements(onStatementsType);
				}				
				
				if ( doStatementsType.getDoVariable().size() > 0 ||
						doStatementsType.getDoShout().size() > 0 ||
						doStatementsType.getDoForcejob().size() > 0 ||
						doStatementsType.getDoOutput().size() > 0 ||
						doStatementsType.getDoCond().size() > 0 ||
						doStatementsType.getDoMail()	.size() > 0 ||
						doStatementsType.getDo().size() > 0 ) {
					
					onDoStatementType.setDoStatements(doStatementsType);					
				}			
				
		    	// 마지막 DO 일 경우 초기화 위해서 셋팅.
				if ( strLastDoInx.indexOf(Integer.toString(i)) > -1 ) {
					
					onDoArray.add(onDoStatementType);
					onDoStatementsType.setOnDoStatement(onDoArray);
					onDoStatementType 		= new OnDoStatementType();
					doStatementsType 		= new DoStatementsType();
					doArray 				= new ArrayList();
					doAutoArray 			= new ArrayList();
			    	doShoutArray 			= new ArrayList();
			    	doForceArray 			= new ArrayList();
			    	doSysoutArray 			= new ArrayList();
			    	doCondArray 			= new ArrayList();
			    	doMailArray 			= new ArrayList();
				}					
	    	}
	    }
	    
	    return onDoStatementsType;
	}
	
	// PostProc.
	public static ShoutsType getShouts(String strTpostproc) {
		
		ShoutsType shoutsType = new ShoutsType();
		
		String[] t_postproc = strTpostproc.split("[|]");
	    if ( t_postproc != null && t_postproc.length > 0 ) {
	    	ArrayList<ShoutType> alTmp = new ArrayList();
	    	for ( int i = 0; i < t_postproc.length; i++ ) {
				String[] aTmp = t_postproc[i].split(",",5);
				
				ShoutType shoutType = new ShoutType();
				
				if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) shoutType.setWhen(ShoutWhenOptionType.fromValue(aTmp[0]));
				if ( !"".equals(CommonUtil.isNull(aTmp[1])) ) shoutType.setTime(CommonUtil.isNull(aTmp[1]));
				if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) shoutType.setDestination(CommonUtil.isNull(aTmp[2]));
				if ( !"".equals(CommonUtil.isNull(aTmp[3])) ) shoutType.setUrgency(UrgencyType.fromValue(aTmp[3]));
				if ( !"".equals(CommonUtil.isNull(aTmp[4])) ) shoutType.setMessage(CommonUtil.isNull(aTmp[4]));
				
				alTmp.add(shoutType);
	    	}
	    	
	    	shoutsType.setShout(alTmp);	    				    	
	    }
	    
	    return shoutsType;
	}
	
	
	public Map deleteCondition(Map map) throws IOException, Exception {

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		if(strUserToken == null || strUserToken == ""){
			strUserToken			= getUserToken();
		}
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strCondition 		= CommonUtil.isNull(map.get("condition"));
		String strOdate		 		= CommonUtil.isNull(map.get("odate"));
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		try {
			
			JAXBContext context 				= JAXBContext.newInstance(RequestDeleteConditionType.class);			
			RequestDeleteConditionType reqType 	= new RequestDeleteConditionType();
			java.io.StringWriter sw 			= new java.io.StringWriter();

			// 컨디션 설정.
			ConditionType conditionType = new ConditionType();
			conditionType.setName(strCondition);
			conditionType.setOdate(strOdate);
			
			reqType.setUserToken(strUserToken);
			reqType.setControlM(strDataCenter);
			reqType.setCondition(conditionType);

			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
	
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			System.out.println(":::::::::::::::::::::::::::::::::::::::::::::"+strReqXml);
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiErrorProcess(strResData);

			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);

			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
		
				// 언마샬링 해서 값을 담는다.
				JAXBElement<ResponsePollAddDeleteConditionType> dataRoot = (JAXBElement<ResponsePollAddDeleteConditionType>) CommonUtil.unmarshaller(ResponsePollAddDeleteConditionType.class, strResXml);
				
	            map.put("rCode", "1");
				map.put("rType", "response_poll_add_delete_condition_type");
				map.put("rObject", dataRoot);
			}		
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		} 
		
		return map;
	}
	
	// polling.
	public Map getPollData(String strUserToken, String strResponseToken) throws UnsupportedEncodingException {
		
		Map<String, Object> map	= new HashMap<String, Object>();
		String strStatus		= "";
		String strOrderId		= "";
		
		// 1초 후 polling (정보 갱신에 시간이 좀 걸림)
//		CommonUtil.setTimeout(500);
		
		try {
			
			JAXBContext context 	= JAXBContext.newInstance(RequestPollType.class);
			RequestPollType reqType = new RequestPollType();
			java.io.StringWriter sw = new java.io.StringWriter();

			reqType.setUserToken(strUserToken);
			reqType.setResponseToken(strResponseToken);

			// 해당 타입을 토대로 1차적으로 마샬링.
			Marshaller marshaller = CommonUtil.marshalling(context);
			marshaller.marshal(reqType, sw);
	
			// 마샬링 한 데이터에 BMC API를 호출하기 위한 명세 추가.
			String strReqXml = CommonUtil.marshllingAdd(sw);
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";
			//strResData = "<?xml version=\"1.0\" encoding=\"UTF-8\"?><SOAP-ENV:Envelope xmlns:SOAP-ENV=\"http://schemas.xmlsoap.org/soap/envelope/\"><SOAP-ENV:Body><SOAP-ENV:Fault><faultcode>SOAP-ENV:Server</faultcode><faultstring>Error response from EM Server.</faultstring><detail><ctmem:fault_poll_order_force xmlns:ctmem=\"http://www.bmc.com/ctmem/schema900\"><ctmem:error_list ctmem:highest_severity='Error' ><ctmem:error ctmem:major='401' ctmem:minor='3' ctmem:severity='Error' ><ctmem:error_message>Invalid response from Control-M.</ctmem:error_message></ctmem:error></ctmem:error_list></ctmem:fault_poll_order_force></detail></SOAP-ENV:Fault></SOAP-ENV:Body></SOAP-ENV:Envelope>";
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {

				map = CommonUtil.apiErrorProcess(strResData);

			} else if ( strResData.indexOf("ctmem") <= -1 ) {

				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", strResData);
				
			// 성공 처리.
			} else {
				
				// 작업명에 한글이 있으면 poll 결과를 언마샬 진행 시 Invalid byte 1 of 1-byte UTF-8 sequence. 오류 발생.
				// poll 결과의 작업명은 필요 없으므로 제거 진행. (2023.09.05 강명준)
				//if ( strResData.indexOf("<ctmem:job_name>") > -1 ) {
					//int s_job_name_length = strResData.indexOf("<ctmem:job_name>");
					//int e_job_name_length = strResData.indexOf("</ctmem:job_name>");
					
					//strResData = strResData.substring(0, s_job_name_length) + strResData.substring(e_job_name_length+17, strResData.length());
				//}
				
				// Unmarshalling JAXB entities from SOAP wrappers 
				// 기존 언마샬이 잘 안되서 변경 (2023.1.22 강명준)
				int start = strResData.indexOf("Body>") + 5;
				Matcher m = Pattern.compile("</[^>]*Body").matcher(strResData);
				m.find();
				int end = m.start();
				String output = strResData.substring(start, end);
				output = output.replaceAll("response_poll_order_force", "response_order_force");
	
				Unmarshaller unmarshaller = JAXBContext.newInstance(ResponseOrderForceJobType.class).createUnmarshaller();
				ResponseOrderForceJobType dataRoot = (ResponseOrderForceJobType) unmarshaller.unmarshal(new ByteArrayInputStream(output.getBytes("UTF-8")));
				logger.debug("dataRoot : " + dataRoot);
	            map.put("rCode", "1");
				map.put("rType", "response_order_force");
				map.put("rObject", dataRoot);
				
				strStatus 	= CommonUtil.isNull(dataRoot.getStatus());

				logger.info("strStatus : " + strStatus);

				// 오더 아이디를 가져오는 상태가 진행중이라면 다시 시도 (무한 루핑은 없을 것으로 보임. 2023.11.1 강명준)
				if ( strStatus.equals("EXEC") ) {

					logger.info("PollData 다시 시도");

					return getPollData(strUserToken, strResponseToken);

				} else {

				strOrderId 	= CommonUtil.isNull(dataRoot.getJobs().getJob().get(0).getJobData().getOrderId());

					logger.info("strOrderId : " + strOrderId);

					map.put("order_id", strOrderId);

					logger.info("PollData 종료");
				}
			}
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		System.out.println("map123 : " + map);
		return map;
	}
}