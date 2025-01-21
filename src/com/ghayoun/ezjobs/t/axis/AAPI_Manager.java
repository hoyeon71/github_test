package com.ghayoun.ezjobs.t.axis;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.parser.ParseException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bmc.ctmem.emapi.EMXMLInvoker;
import com.bmc.ctmem.emapi.InvokeException;
import com.bmc.ctmem.schema900.*;
import com.ghayoun.ezjobs.common.util.AAPI_Util;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.t.domain.Doc01Bean;
import com.ghayoun.ezjobs.t.domain.Doc02Bean;
import com.ghayoun.ezjobs.t.domain.Doc03Bean;
import com.ghayoun.ezjobs.t.domain.Doc05Bean;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;
import com.ghayoun.ezjobs.t.domain.TagsBean;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;

public class AAPI_Manager {
		
	protected final Log logger = LogFactory.getLog(getClass());
	
	static String AAPI_URL = CommonUtil.isNull(CommonUtil.getMessage("AAPI_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));

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
        	props.setProperty("ServerURL", CommonUtil.isNull(CommonUtil.getMessage("CTM_URL."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB"))));
        	props.setProperty("ConfigDir", CommonUtil.isNull(CommonUtil.getDefaultFilePath()));
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
				
				response = invoker.invoke(request);
            }
            
            catch (InvokeException ex) {
            	
            	logger.error("getMajorCode() : " + ex.getMajorCode() );
            	logger.error("getMinorCode() : " + ex.getMinorCode());
            	logger.error("getMessage() : " + ex.getMessage() );
            	logger.error("getReason() : " + ex.getReason() );
            }
            catch (Exception ex) {
                
            }            
        }        
        
        System.out.println("최종결과값 : " + response);
        
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
		//deploy
		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");

		List alDocList 				= (List)map.get("alDocList");
		
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strTableCnt			= CommonUtil.isNull(docBean.getTable_cnt());
		String strTableType			= CommonUtil.isNull(docBean.getTable_type());
		
		map.put("table_type", strTableType);
		
		try {
			
			String strReqXml = "";
			String rCode = "";
			
			System.out.println("strTaskType : " + strTaskType);
			System.out.println("strTableCnt : " + strTableCnt);
			System.out.println("strTableType : " + strTableType);
			
			if ( alDocList != null ) {							// 엑셀 일괄 등록.				
				strReqXml = defAddBatchJobs(map);
			} else if ( strTaskType.equals("SMART Table") ) {	// 스마트 테이블 등록.
				strReqXml = defCreateTable(map);
			} else if ( strTaskType.equals("Sub-Table") ) {		// 서브 테이블 등록.
				//strReqXml = defAddTable(map);			
			//} else if ( strTableCnt.equals("0") ) {				// 일반 테이블 신규 & 작업 등록.
				//strReqXml = defCreateTableJobs(map);		
			} else if ( strTableType.equals("2") ) {			// 스마트 테이블 OR 서브 테이블 안에 작업 등록.
				strReqXml = defAddJobs(map);				
			} else {											// 일반 테이블 안에 작업 등록. (스키마 700 에는 없으므로 예전 버전으로 처리)
				//의뢰 작업등록 관리자 즉시결재 눌렀을 때 타는 api
				strReqXml = defAddJobs(map);
			}
		
//			String strResData 	= invokeRequest(strReqXml);
//			
//			String strResXml 	= "";
//
//			// 에러 처리.
//			if ( strResData.indexOf("ctmem:error") > 0 ) {
//				
//				System.out.println("에러 시작");
//				
//				System.out.println("map"+map);
//				
//				map = CommonUtil.apiErrorProcess(strResData);
//				
//				System.out.println("에러 종료");
//				
//			// 성공 처리.
//			} else {
//
//				// 리턴 XML 값을 언마샬링 할 수 있게 가공.				
//				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
//				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);				
//				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
//				
//				// [org.apache.xerces.impl.io.MalformedByteSequenceException: 1-바이트 UTF-8 순서 중 1바이트가 올바르지 않습니다.]
//				// LANG=C 환경에서 위의 에러가 나면서 Exception 떨어지기 때문에 table_name 제거해보았다.
//				String strResXml2 	= strResXml.substring(0, strResXml.indexOf("<ctmem:folder_name>")+19);				
//				strResXml2 			+= strResXml.substring(strResXml.indexOf("</ctmem:folder_name>"), strResXml.length());
//				
//				// 언마샬링 해서 값을 담는다.
//				if ( strTaskType.equals("SMART Table") || strTableCnt.equals("0") ) {	// 스마트 테이블 등록.
//		            JAXBElement<ResponseDefCreateFolderType> dataRoot = (JAXBElement<ResponseDefCreateFolderType>) CommonUtil.unmarshaller(ResponseDefCreateFolderType.class, strResXml2);
//		            
//		            map.put("rCode", "1");
//					map.put("rType", "response_def_create_table");
//					map.put("rObject", dataRoot);
//		            
//				} else if ( strTaskType.equals("Sub-Table") ) {		// 서브 테이블 등록.
//		            JAXBElement<ResponseDefAddFolderType> dataRoot = (JAXBElement<ResponseDefAddFolderType>) CommonUtil.unmarshaller(ResponseDefAddFolderType.class, strResXml2);
//		            
//		            map.put("rCode", "1");
//					map.put("rType", "response_def_add_table");
//					map.put("rObject", dataRoot);
//
//				} else if ( strTableType.equals("2") ) {	// 스마트 테이블 OR 서브 테이블 안에 작업 등록.
//		            JAXBElement<ResponseDefAddJobsType> dataRoot = (JAXBElement<ResponseDefAddJobsType>) CommonUtil.unmarshaller(ResponseDefAddJobsType.class, strResXml2);
//		            
//		            map.put("rCode", "1");
//					map.put("rType", "response_def_add_jobs");
//					map.put("rObject", dataRoot);
//				
//				} else {									// 일반 테이블 안에 작업 등록. (스키마 700 에는 없으므로 예전 버전으로 처리)
//		            JAXBElement<ResponseDefAddJobsType> dataRoot = (JAXBElement<ResponseDefAddJobsType>) CommonUtil.unmarshaller(ResponseDefAddJobsType.class, strResXml2);
//		            
//		            map.put("rCode", "1");
//					map.put("rType", "response_def_create_jobs");
//					map.put("rObject", dataRoot);
//				}
//				
//			}
			
//		} catch (JAXBException e) {
//			
//			e.printStackTrace();
//			
//			map.put("rCode", "0");
//			map.put("rType", "fault_type");
//			map.put("rMsg", "API 통신 에러!");
			
		
			if(strReqXml.indexOf("successfulJobsCount") > -1) {
				rCode = "1"; 
			}else {
				rCode = "-1";
			}	
			
			if(rCode.equals("1")) {
				//map.put("rType", "fault_type");
				map.put("rCode", 	"1");
				map.put("rMsg", 	"처리완료");
			}else {
				map.put("rCode", 	"-1");
				map.put("rMsg", 	strReqXml);
			}
		
		} catch (Exception e) {
			
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", e.toString());
		}
		
		return map;
	}
	
	// 스마트 테이블 등록.
	public String defCreateTable(Map map) {

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		
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
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib());
		String strMemName			= CommonUtil.isNull(docBean.getMem_name());
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

		    // Tag.
			/*
		    if ( alTagList != null ) {
		    	ArrayList<RuleBasedCalType> alTmp = new ArrayList();		
				for ( int i = 0; i < alTagList.size(); i ++ ) {
					tagsBean = (TagsBean)alTagList.get(i);
	
					String strTagName 			= CommonUtil.isNull(tagsBean.getTag_name());
					String strTagRelationDcWc	= CommonUtil.isNull(tagsBean.getTag_relation_dc_wc());
					String strDaysCal 			= CommonUtil.isNull(tagsBean.getDays_cal());
					String strWeeksCal 			= CommonUtil.isNull(tagsBean.getWeeks_cal());
					String strDatesStr			= CommonUtil.isNull(tagsBean.getDates_str());
					String strDayStr 			= CommonUtil.isNull(tagsBean.getDay_str());
					String strWdayStr			= CommonUtil.isNull(tagsBean.getW_day_str());
					String strMonth_1 			= CommonUtil.isNull(tagsBean.getMonth_1(), "1");
					String strMonth_2 			= CommonUtil.isNull(tagsBean.getMonth_2(), "1");
					String strMonth_3 			= CommonUtil.isNull(tagsBean.getMonth_3(), "1");
					String strMonth_4 			= CommonUtil.isNull(tagsBean.getMonth_4(), "1");
					String strMonth_5 			= CommonUtil.isNull(tagsBean.getMonth_5(), "1");
					String strMonth_6 			= CommonUtil.isNull(tagsBean.getMonth_6(), "1");
					String strMonth_7 			= CommonUtil.isNull(tagsBean.getMonth_7(), "1");
					String strMonth_8 			= CommonUtil.isNull(tagsBean.getMonth_8(), "1");
					String strMonth_9 			= CommonUtil.isNull(tagsBean.getMonth_9(), "1");
					String strMonth_10 			= CommonUtil.isNull(tagsBean.getMonth_10(), "1");
					String strMonth_11 			= CommonUtil.isNull(tagsBean.getMonth_11(), "1");
					String strMonth_12 			= CommonUtil.isNull(tagsBean.getMonth_12(), "1");
					String strActiveFrom		= CommonUtil.isNull(tagsBean.getActive_from());
					String strActiveTill		= CommonUtil.isNull(tagsBean.getActive_till());
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
					
					List listDates 	= new ArrayList();
					if ( strDatesStr.length() > 0 ) {
					    String[] t_datesStr = strDatesStr.split("[|]");
					    if ( t_datesStr != null && t_datesStr.length > 0 ) {
					    	
					    	for ( int j = 0; j < t_datesStr.length; j++ ) {
					    		listDates.add(t_datesStr[j]); 
					    	}
					    }
					}
					
					DatesType datesType = new DatesType();    				
					datesType.setDate(listDates);
					
					RuleBasedCalType ruleBasedCalType = new RuleBasedCalType();
					
					if ( !strTagName.equals("") ) 			ruleBasedCalType.setRuleBasedCalName(strTagName);    				
					if ( !strTagRelationDcWc.equals("") ) 	ruleBasedCalType.setAndOr(AndOrType.fromValue(CommonUtil.getMessage("JOB.AND_OR."+strTagRelationDcWc)));    				
					if ( !strDaysCal.equals("") ) 			ruleBasedCalType.setDaysCal(strDaysCal);
					if ( !strWeeksCal.equals("") ) 			ruleBasedCalType.setWeeksCal(strWeeksCal);    				
					if ( !strDatesStr.equals("") ) 			ruleBasedCalType.setDates(datesType);    				
					if ( !strDayStr.equals("") ) 			ruleBasedCalType.setMonthDays(strDayStr);
					if ( !strWdayStr.equals("") ) 			ruleBasedCalType.setWeekDays(strWdayStr);
					if ( !strMonth_1.equals("") ) 			ruleBasedCalType.setJAN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_1)));    				
					if ( !strMonth_2.equals("") ) 			ruleBasedCalType.setFEB(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_2)));    				
					if ( !strMonth_3.equals("") ) 			ruleBasedCalType.setMAR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_3)));
					if ( !strMonth_4.equals("") ) 			ruleBasedCalType.setAPR(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_4)));
					if ( !strMonth_5.equals("") ) 			ruleBasedCalType.setMAY(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_5)));
					if ( !strMonth_6.equals("") ) 			ruleBasedCalType.setJUN(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_6)));
					if ( !strMonth_7.equals("") ) 			ruleBasedCalType.setJUL(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_7)));
					if ( !strMonth_8.equals("") ) 			ruleBasedCalType.setAUG(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_8)));
					if ( !strMonth_9.equals("") ) 			ruleBasedCalType.setSEP(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_9)));
					if ( !strMonth_10.equals("") ) 			ruleBasedCalType.setOCT(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_10)));
					if ( !strMonth_11.equals("") ) 			ruleBasedCalType.setNOV(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_11)));
					if ( !strMonth_12.equals("") ) 			ruleBasedCalType.setDEC(YesNoType.fromValue(CommonUtil.getMessage("JOB.CAL_OPT."+strMonth_12)));
					if ( !strActiveFrom.equals("") ) 		ruleBasedCalType.setActiveFrom(strActiveFrom);
					if ( !strActiveTill.equals("") ) 		ruleBasedCalType.setActiveTill(strActiveTill);
					if ( !strConfCal.equals("") ) 			ruleBasedCalType.setConfCal(strConfCal);
					if ( !strShift.equals("") ) 			ruleBasedCalType.setShift(strShiftMent);
					if ( !strShiftNum.equals("") ) 			ruleBasedCalType.setShiftNum(strShiftNum);			
					
					
					alTmp.add(ruleBasedCalType);
				}
				
				FolderRuleBasedCalsType tableRuleBasedCalsType = new FolderRuleBasedCalsType();
				tableRuleBasedCalsType.setRuleBasedCal(alTmp);    			
				
				smartTableAttributesType.setSmartFolderRuleBasedCals(tableRuleBasedCalsType);
			}
			*/
		    
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
	public String defCreateTableJobs(Map map){

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		
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
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib());
		String strMemName			= CommonUtil.isNull(docBean.getMem_name());
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
		
		// START 컨디션 자동 설정
		//strTconditionIn				= CommonUtil.getI_Conditions(strDataCenterName, strTconditionIn, strJobName);
		
		// NAVER 용 리소스 자동 설정
		//strTresourcesQ				= "NAVER@,1";
		
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
		
		logger.info("======================================================================================");
		logger.info("strConfCal      :" + strConfCal);
		logger.info("strShiftMent      :" + strShiftMent);
		logger.info("strShiftNum      :" + strShiftNum);
		logger.info("======================================================================================");
		
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
			
			//defJobType.setApplicationType("OS");
			
			// 스케줄.
			if( strTgeneralDate.length() > 0 ) {
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
	
	// 서브 테이블 등록.
	/*
	public String defAddTable(Map map){

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		
		Doc01Bean docBean			= (Doc01Bean)map.get("doc01");
		List alTagList 				= (List)map.get("alTagList");
		TagsBean tagsBean 			= null;
		String strReqXml			= "";
		
		String strDataCenter		= CommonUtil.isNull(docBean.getData_center());
		String strJobName			= CommonUtil.isNull(docBean.getJob_name());
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strApplication		= CommonUtil.isNull(docBean.getApplication());
		String strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib());
		String strMemName			= CommonUtil.isNull(docBean.getMem_name());
		String strOwner				= CommonUtil.isNull(docBean.getOwner());
		String strAuthor			= CommonUtil.isNull(docBean.getAuthor());
		String strDescription		= CommonUtil.encode(CommonUtil.isNull(docBean.getDescription()));
		String strCommand			= CommonUtil.isNull(docBean.getCommand());
		String strTableName			= CommonUtil.isNull(docBean.getTable_name());
		String strNodeId			= CommonUtil.isNull(docBean.getNode_id());
		String strMultiagent		= CommonUtil.isNull(docBean.getMultiagent());
		String strConfirmFlag		= CommonUtil.isNull(docBean.getConfirm_flag());
		String strPriority			= CommonUtil.isNull(docBean.getPriority());
		String strCritical			= CommonUtil.isNull(docBean.getCritical());
		String strTimeFrom			= CommonUtil.isNull(docBean.getTime_from());
		String strTimeUntil			= CommonUtil.isNull(docBean.getTime_until());
		String strTimeZone			= CommonUtil.isNull(docBean.getTime_zone());
		String strCyclic			= CommonUtil.isNull(docBean.getCyclic());
		String strRerunInterval		= CommonUtil.isNull(docBean.getRerun_interval());
		String strRerunIntervalTime	= CommonUtil.isNull(docBean.getRerun_interval_time());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		String strRerunMax			= CommonUtil.isNull(docBean.getRerun_max());
		String strMaxWait			= CommonUtil.isNull(docBean.getMax_wait());
		String strTconditionIn		= CommonUtil.isNull(docBean.getT_conditions_in());
		String strTconditionOut		= CommonUtil.isNull(docBean.getT_conditions_out());
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
		
		String strUserDailyMent = "";
		if ( strUserDaily.equals("Y") ) {			
			strUserDailyMent = "SYSTEM";
		}
		
		// 부모 및 서브 테이블 조회.
		String strParentTableName	= strTableName.substring(0, strTableName.lastIndexOf("/"));		
		String strSubTableName		= strTableName.substring(strTableName.lastIndexOf("/")+1, strTableName.length());
		
		try {
		
			JAXBContext context 				= JAXBContext.newInstance(RequestDefAddTableType.class);
			RequestDefAddTableType reqType 		= new RequestDefAddTableType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			reqType.setUserToken(strUserToken);
			
			// 부모 테이블 설정.
			AnyTableType anyTableType = new AnyTableType();
			anyTableType.setControlM(strDataCenter);
			anyTableType.setTableName(strParentTableName);
			anyTableType.setUserDaily(strUserDailyMent);
			
			reqType.setParentTable(anyTableType);
			
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
			
			// 서브 테이블 속성 설정.
			SubTableAttributesType subTableAttributesType = new SubTableAttributesType();
			//if ( !strJobName.equals("") ) 			subTableAttributesType.setJobName(strJobName);
			//if ( !strTaskType.equals("") ) 			subTableAttributesType.setTaskType(ActiveTaskType.fromValue(strTaskType));
			if ( !strApplication.equals("") ) 		subTableAttributesType.setApplication(strApplication);
			if ( !strGroupName.equals("") ) 		subTableAttributesType.setGroup(strGroupName);
			if ( !strMemLib.equals("") ) 			subTableAttributesType.setMemLib(strMemLib);
			if ( !strMemName.equals("") ) 			subTableAttributesType.setMemName(strMemName);
			if ( !strOwner.equals("") ) 			subTableAttributesType.setOwner(strOwner);
			if ( !strAuthor.equals("") ) 			subTableAttributesType.setAuthor(strAuthor);
			if ( !strDescription.equals("") ) 		subTableAttributesType.setDescription(strDescription);
			if ( !strCommand.equals("") ) 			subTableAttributesType.setCommand(strCommand);
			//if ( !strTableName.equals("") ) 		subTableAttributesType.setOrderTable(strTableName);
			if ( !strNodeId.equals("") ) 			subTableAttributesType.setNodeId(strNodeId);
			if ( !strMultiagent.equals("") ) 		subTableAttributesType.setMultiagent(YesNoType.fromValue(CommonUtil.getMessage("JOB.MULTIAGENT."+strMultiagent)));
			if ( !strConfirmFlag.equals("") ) 		subTableAttributesType.setConfirmFlag(YesNoType.fromValue(CommonUtil.getMessage("JOB.CONFIRM_FLAG."+strConfirmFlag)));
			if ( !strPriority.equals("") ) 			subTableAttributesType.setPriority(strPriority);
			if ( !strCritical.equals("") ) 			subTableAttributesType.setCritical(YesNoType.fromValue(CommonUtil.getMessage("JOB.CRITICAL."+strCritical)));
			if ( !strTimeFrom.equals("") ) 			subTableAttributesType.setTimeFrom(strTimeFrom);
			if ( !strTimeUntil.equals("") ) 		subTableAttributesType.setTimeUntil(strTimeUntil);
			if ( !strTimeZone.equals("") ) 			subTableAttributesType.setTimeZone(strTimeZone);
			if ( !strCyclic.equals("") ) 			subTableAttributesType.setCyclic(YesNoType.fromValue(CommonUtil.getMessage("JOB.CYCLIC."+strCyclic)));
			if ( !strRerunInterval.equals("") ) 	subTableAttributesType.setRerunInterval(strRerunInterval + strRerunIntervalTime);
			if ( !strCountCyclicFrom.equals("") ) 	subTableAttributesType.setCountCyclicFrom(StartEndTargetType.fromValue(strCountCyclicFrom));
			if ( !strRerunMax.equals("") ) 			subTableAttributesType.setRerunMax(strRerunMax);
			if ( !strMaxWait.equals("") ) 			subTableAttributesType.setMaxWait(strMaxWait);
			if ( !strCyclicType.equals("") ) 		subTableAttributesType.setCyclicType(CyclicTypeType.fromValue(CommonUtil.getMessage("JOB.CYCLIC_TYPE."+strCyclicType)));
			if ( !strIntervalSequence.equals("") ) 	subTableAttributesType.setIntervalSequence(intervalSequenceType);
			if ( !strTolerance.equals("") ) 		subTableAttributesType.setTolerance(strTolerance);
			if ( !strSpecificTimes.equals("") ) 	subTableAttributesType.setSpecificTimes(specificTimesType);			
			
			// In Condition.
			if ( strTconditionIn.length() > 0 ) {
				subTableAttributesType.setInConditions(getInConditions(strTconditionIn));
			}
			
			// Out Condition.
			if ( strTconditionOut.length() > 0 ) {
				subTableAttributesType.setOutConditions(getOutConditions(strTconditionOut));
			}
			
			// Quantitatvie Resouce.
			if ( strTresourcesQ.length() > 0 ) {
				subTableAttributesType.setQuantitativeResources(getQresources(strTresourcesQ));
			}
			
			// Control Resouce.
			if ( strTresourcesC.length() > 0 ) {
				subTableAttributesType.setControlResources(getCresources(strTresourcesC));
			}
			
			// Set 변수.
			if ( strTset.length() > 0 ) {
				subTableAttributesType.setAutoeditAssignments(getAutoeditAssignments(strTset));
			}
			
			// Step.
			if ( strTsteps.length() > 0 ) {				
				subTableAttributesType.setOnDoStatements(getOnDoStatements(strTsteps));				
			}
			
			// PostProc.
			if ( strTpostproc.length() > 0 ) {				
				subTableAttributesType.setShouts(getShouts(strTpostproc));				
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
			    	
			    	SubRuleBasedCalType subRuleBasedCalType = new SubRuleBasedCalType();
		    		subRuleBasedCalType.setSubRuleBasedCal(alTmp);
			    
			    	subTableAttributesType.setSubTableRuleBasedCals(subRuleBasedCalType);	
			    }
		    }
		    
		    // 서브 테이블 설정.
		    SubTableType subTableType = new SubTableType();
		    subTableType.setTableAttributes(subTableAttributesType);
		    subTableType.setTableName(strSubTableName);
		    
		    reqType.setSubTable(subTableType);
		    
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
	*/
	
	// 작업등록(deploy)
	public String defAddJobs(Map map) throws IOException{

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		
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
		
		String strJobName			= CommonUtil.isNull(docBean.getJob_name());
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strApplication		= CommonUtil.isNull(docBean.getApplication());
		String strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib());
		String strMemName			= CommonUtil.isNull(docBean.getMem_name());
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
		
		// START 컨디션 자동 설정
		//strTconditionIn				= CommonUtil.getI_Conditions(strDataCenterName, strTconditionIn, strJobName);
		
		// NAVER 용 리소스 자동 설정
		//strTresourcesQ				= "NAVER@,1";

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
		
		logger.info("======================================================================================");
		logger.info("strMonthDays  1" + strMonthDays);
		logger.info("strWeekDays  1" + strWeekDays);
		logger.info("strDaysCal  1" + strDaysCal);
		logger.info("strWeeksCal  1" + strWeeksCal);
		
		logger.info("======================================================================================");
		
		
		String strRerunIntervalMent = "";
		if ( !strRerunInterval.equals("") ) {			
			strRerunIntervalMent = CommonUtil.lpad(strRerunInterval, 5, "0");
		}
			
//		System.out.println("strDataCenter : " + strDataCenter);
//		System.out.println("strDataCenterName : " + strDataCenterName);
//		System.out.println("strTableType : " + strTableType);
//		System.out.println("strJobName : " + strJobName);
//		System.out.println("strTaskType : " + strTaskType);
//		System.out.println("strApplication : " + strApplication);
//		System.out.println("strGroupName : " + strGroupName);
//		System.out.println("strMemLib : " + strMemLib);
//		System.out.println("strMemName : " + strMemName);
//		System.out.println("strAuthor : " + strAuthor);
//		System.out.println("strOwner : " + strOwner);
//		System.out.println("strDescription : " + strDescription);
//		System.out.println("strCommand : " + strCommand);
//		System.out.println("strTableName : " + strTableName);
//		System.out.println("strNodeId : " + strNodeId);
//		System.out.println("strMultiagent : " + strMultiagent);
//		System.out.println("strConfirmFlag : " + strConfirmFlag);
//		System.out.println("strPriority : " + strPriority);
//		System.out.println("strCritical : " + strCritical);
//		System.out.println("strTimeFrom : " + strTimeFrom);
//		System.out.println("strTimeUntil : " + strTimeUntil);
//		System.out.println("strTimeZone : " + strTimeZone);
//		System.out.println("strCyclic : " + strCyclic);
//		System.out.println("strRerunInterval : " + strRerunInterval);
//		System.out.println("strRerunIntervalTime : " + strRerunIntervalTime);
//		System.out.println("strCountCyclicFrom : " + strCountCyclicFrom);
//		System.out.println("strRerunMax : " + strRerunMax);
//		System.out.println("strMaxWait : " + strMaxWait);
//		System.out.println("strTconditionIn : " + strTconditionIn);
//		System.out.println("strTconditionOut : " + strTconditionOut);
//		System.out.println("strTresourcesQ : " + strTresourcesQ);
//		System.out.println("strTresourcesC : " + strTresourcesC);
//		System.out.println("strTset : " + strTset);
//		System.out.println("strTsteps : " + strTsteps);
//		System.out.println("strTpostproc : " + strTpostproc);
//		System.out.println("strTtagName : " + strTtagName);
//		System.out.println("strCyclicType : " + strCyclicType);
//		System.out.println("strIntervalSequence : " + strIntervalSequence);
//		System.out.println("strTolerance : " + strTolerance);
//		System.out.println("strSpecificTimes : " + strSpecificTimes);
		
//		System.out.println("strTgeneralDate : " + strTgeneralDate);
//		System.out.println("strMonthDays : " + strMonthDays);
//		System.out.println("strScheduleAndOr : " + strScheduleAndOr);
//		System.out.println("strWeekDays : " + strWeekDays);
//		System.out.println("strDaysCal : " + strDaysCal);
//		System.out.println("strWeeksCal : " + strWeeksCal);
//		System.out.println("strRetro : " + strRetro);
//		System.out.println("strMonth_1 : " + strMonth_1);
//		System.out.println("strMonth_2 : " + strMonth_2);
//		System.out.println("strMonth_3 : " + strMonth_3);
//		System.out.println("strMonth_4 : " + strMonth_4);
//		System.out.println("strMonth_5 : " + strMonth_5);
//		System.out.println("strMonth_6 : " + strMonth_6);
//		System.out.println("strMonth_7 : " + strMonth_7);
//		System.out.println("strMonth_8 : " + strMonth_8);
//		System.out.println("strMonth_9 : " + strMonth_9);
//		System.out.println("strMonth_10 : " + strMonth_10);
//		System.out.println("strMonth_11 : " + strMonth_11);
//		System.out.println("strMonth_12 : " + strMonth_12);
//		System.out.println("strActiveFrom : " + strActiveFrom);
//		System.out.println("strActiveTill : " + strActiveTill);
//		System.out.println("strConfCal : " + strConfCal);
//		System.out.println("strShift : " + strShift);
//		System.out.println("strShiftNum : " + strShiftNum);
//		System.out.println("strShiftMent : " + strShiftMent);
//		System.out.println("strRerunIntervalMent : " + strRerunIntervalMent);
		
		 
		strTableName	=	java.net.URLEncoder.encode(strTableName);
		
		logger.info("strTableName ::::: " + strTableName);
		 
		String REST_URL							= AAPI_URL + "/deploy/jobs?format=json&folder=" + strTableName + "&server=" + strDataCenter;
		String REST_DEPLOY_URL					= AAPI_URL + "/deploy";

		JSONObject temDeployJson 				= new JSONObject();
		org.json.simple.JSONObject onDoJson 	= new org.json.simple.JSONObject();
		
		String onDoString 						= "";
		String onDoDeployString 				= "";
		String deployGetJson 					= "";
		String temDeployString					= "";
		String temDeployJobString				= "";
		String temDeployStringEnd				= "";
		String deployJson 						= "";
		
		try {

			//deploy get 으로 기존 데이터 조회
			deployGetJson = AAPI_Util.restApiDeployGet(AAPI_URL, REST_URL, "GET", strTableName);

			logger.info("기존 폴더에 등록된 작업목록(deploy get) : " + deployGetJson);

			if(!strGroupName.equals(""))		temDeployJson.put("SubApplication", strGroupName);
			if(!strMaxWait.equals(""))			temDeployJson.put("DaysKeepActive", strMaxWait);
			if(!strPriority.equals(""))			temDeployJson.put("Priority", strPriority);
			if(strTaskType.equals("job"))		temDeployJson.put("FileName", strMemName);
			if(!strNodeId.equals("")) 			temDeployJson.put("Host", strNodeId);
			if(strTaskType.equals("job"))		temDeployJson.put("FilePath", strMemLib);
			if(!strAuthor.equals(""))			temDeployJson.put("CreatedBy", strAuthor);
			
			if(strCritical.equals("1")) {
				temDeployJson.put("Critical", true);
			}else if(strCritical.equals("0")) {
				temDeployJson.put("Critical", false);
			}
			
			if(!strDescription.equals(""))		temDeployJson.put("Description", strDescription);
			if(!strOwner.equals(""))			temDeployJson.put("RunAs", strOwner);
			if(strTaskType.equals("command")) 	temDeployJson.put("Command", strCommand);
			if(!strApplication.equals(""))		temDeployJson.put("Application", strApplication);
			
			//필수 제외 선택사항 작업
			if(!strTset.equals(""))				temDeployJson.put("Variables", AAPI_Util.getTsetDeploy(strTset));
			if(!strTconditionIn.equals("") ) 	temDeployJson.put("eventsToWaitFor", AAPI_Util.getTconditionInDeploy(strTconditionIn));
			
			if(!strTconditionOut.equals("")){
				if(!AAPI_Util.getTconditionOut(strTconditionOut).get(0).toString().equals("{}"))  temDeployJson.put("eventsToAdd", AAPI_Util.getTconditionOutDeploy(strTconditionOut).get(0));
				if(!AAPI_Util.getTconditionOut(strTconditionOut).get(1).toString().equals("{}"))  temDeployJson.put("eventsToDelete", AAPI_Util.getTconditionOutDeploy(strTconditionOut).get(1));
			}
			if(!strTresourcesQ.equals("")) {
				if(strTresourcesQ.indexOf("|") > -1) {
					for(int ii=0; ii < strTresourcesQ.split("[|]").length;ii++) {
						temDeployJson.put(strTresourcesQ.split("[|]")[ii].split(",")[0], AAPI_Util.getTresourceQ(strTresourcesQ.split("[|]")[ii]));
					}
				}else {
					temDeployJson.put(strTresourcesQ.split(",")[0], AAPI_Util.getTresourceQ(strTresourcesQ));
				}
			}
			temDeployJson.put("When", AAPI_Util.getTschedule(map));
			
			//ON/DO 
			if(!strTsteps.equals("")) {
				int onDoCnt = 0;
				for(int ii=0; ii < strTsteps.split("[|]").length;ii++) {
					if(strTsteps.split("[|]")[ii].split(",")[0].equals("O")) {
						onDoCnt 	+=1;
						onDoJson 	= AAPI_Util.getOnDoDeploy(strTsteps, onDoCnt);
						onDoString 	= onDoJson.toString();
						
						if(strTsteps.split("[|]")[ii].split(",")[3].indexOf("RUNCOUNT") > -1) {
							onDoDeployString +=",\"IfBase:Folder:NumberOfExecutions_"+onDoCnt+ "\":" + onDoString.substring(0,1) + "\"Type\":\"If:NumberOfExecutions\"," + onDoString.substring(1);
						}else {
							onDoDeployString +=",\"IfBase:Folder:CompletionStatus_"+onDoCnt+ "\":" + onDoString.substring(0,1) + "\"Type\":\"If:CompletionStatus\"," + onDoString.substring(1);
						}

					}
				}
			}
			
			//반복작업
			if(!strCyclicType.equals("")) {
				if(strCyclicType.equals("C")) temDeployJson.put("Rerun", AAPI_Util.getRerunDeploy(map));
				if(strCyclicType.equals("V")) temDeployJson.put("RerunIntervals", AAPI_Util.getRerunDeploy(map));
				if(strCyclicType.equals("S")) temDeployJson.put("RerunSpecificTimes", AAPI_Util.getRerunDeploy(map));
			}
			
			temDeployString = temDeployJson.toString();
			
			if(strTaskType.equals("job")) {
				temDeployJobString = "\"" +strJobName + "\" :" + temDeployString.substring(0,temDeployString.indexOf("\"")) + "\"Type\":\"Job:Script\"," + temDeployString.substring(temDeployString.indexOf("\"")); 
			}else if(strTaskType.equals("command")) {
				temDeployJobString = "\"" +strJobName + "\" :" + temDeployString.substring(0,temDeployString.indexOf("\"")) + "\"Type\":\"Job:Command\"," + temDeployString.substring(temDeployString.indexOf("\""));
			}
			
			if(!strTsteps.equals("")) {
				temDeployJobString = temDeployJobString.substring(0,temDeployJobString.length()-1) + onDoDeployString + "}";
			}
			
			logger.info("신규 추가되는 작업 내용 (temDeployJobString) : " + temDeployJobString);
			
			//신규 생성 폴더 인지 확인 여부
			if(deployGetJson.contains("No folder found")) {
				temDeployStringEnd = "{\"" + strTableName + "\": {\"Type\":\"SimpleFolder\",\"ControlmServer\":\""+ strDataCenter+"\"," +temDeployJobString + "}}";
			}else {
				temDeployStringEnd = deployGetJson.substring(0,deployGetJson.length()-2)+ "," + temDeployJobString + "}}";
			}
			
			logger.info("최종 전달 json 내용 (temDeployStringEnd) : " + temDeployStringEnd);
			
			//json 파일 담기
			String filePath = AAPI_Util.restApiDeployFile(temDeployStringEnd);
			
			//파일 경로 전달 하면서 deploy API 진행
			deployJson = AAPI_Util.restApiDeploy(AAPI_URL, REST_DEPLOY_URL, "POST", filePath);
			
			logger.info("등록 AAPI 응답 : " + deployJson);   
			
		} catch (JSONException e) {
			e.printStackTrace();
		}
		
		return deployJson;
	}
	
	// 엑셀 일괄 등록.
	public String defAddBatchJobs(Map map){
		
		Doc01Bean doc01Bean			= (Doc01Bean)map.get("doc01");

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		String strDataCenter		= CommonUtil.isNull(doc01Bean.getData_center());
		String strDataCenterName	= CommonUtil.isNull(doc01Bean.getData_center_name());
		String strTableName			= CommonUtil.isNull(doc01Bean.getTable_name());
		String strTableCnt			= CommonUtil.isNull(doc01Bean.getTable_cnt());
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
		String strUserDaily			= "";
		
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
		
		ArrayList<DefJobType> alTmp = new ArrayList();
	
		if ( alDocList != null ) {
			for ( int i = 0; i < alDocList.size(); i ++ ) {
				docBean = (Doc06Bean)alDocList.get(i);
				System.out.println("docBean : " + docBean);
				strJobName				= CommonUtil.isNull(docBean.getJob_name());
				strTaskType				= CommonUtil.isNull(docBean.getTask_type());
				strApplication			= CommonUtil.isNull(docBean.getApplication());
				strGroupName			= CommonUtil.isNull(docBean.getGroup_name());
				strMemLib				= CommonUtil.isNull(docBean.getMem_lib());
				strMemName				= CommonUtil.isNull(docBean.getMem_name());
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
				strUserDaily			= CommonUtil.isNull(docBean.getUser_daily());
				
				// START 컨디션 자동 설정
				//strTconditionIn			= CommonUtil.getI_Conditions(strDataCenterName, strTconditionIn, strJobName);
				
				// NAVER 용 리소스 자동 설정
				//strTresourcesQ			= "NAVER@,1";
				
				
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
				
				//defJobType.setApplicationType("OS");
					
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
	public Map createJobs(Map map){
		
		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		
		Doc02Bean docBean			= (Doc02Bean)map.get("doc02");
		
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
		
		// START 컨디션 자동 설정
		//strTconditionIn				= CommonUtil.getI_Conditions(strDataCenterName, strTconditionIn, strJobName);
		
		// NAVER 용 리소스 자동 설정
		//strTresourcesQ				= "NAVER@,1";
		
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
			if ( !strTgeneralDate.equals("") ) 		activeJobType.setOdate(strTgeneralDate.replaceAll("/", "").substring(2, 8));
			
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
    
	public Map defUploadjobs(Map map){
		
		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
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

			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				// 언마샬링 해서 값을 담는다.
	            JAXBElement<ResponseOrderForceJobType> dataRoot = (JAXBElement<ResponseOrderForceJobType>) CommonUtil.unmarshaller(ResponseOrderForceJobType.class, strResXml);
	            
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
	
	// 작업 수정 API
	public Map changeJobs(Map map) throws IOException{

		String strUserToken		= CommonUtil.isNull(map.get("userToken"));

		Doc01Bean docBean		= (Doc01Bean)map.get("doc01");		
		
		String strDataCenter 	= CommonUtil.isNull(docBean.getData_center());
		String strTableName 	= CommonUtil.isNull(docBean.getTable_name());
		String strApplication 	= CommonUtil.isNull(docBean.getApplication());
		String strGroupName 	= CommonUtil.isNull(docBean.getGroup_name());
		String strJobName 		= CommonUtil.isNull(docBean.getJob_name());
		String strNodeId		= CommonUtil.isNull(docBean.getNode_id());
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		String strDataCenterName	= CommonUtil.isNull(docBean.getData_center_name());		
		String strTableType			= CommonUtil.isNull(map.get("table_type"));
		
		if ( !strDataCenterName.equals("") && strDataCenterName.indexOf("-") > -1 ) { 
			strDataCenterName = strDataCenterName.split("-")[1];
		}
		
		String strTaskType			= CommonUtil.isNull(docBean.getTask_type());
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib());
		String strMemName			= CommonUtil.isNull(docBean.getMem_name());
		String strOwner				= CommonUtil.isNull(docBean.getOwner());
		String strAuthor			= CommonUtil.isNull(docBean.getAuthor());
		String strDescription		= CommonUtil.isNull(docBean.getDescription());
		String strCommand			= CommonUtil.isNull(docBean.getCommand());
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
		
		//API JSON 작업에 사용되는 변수
		String REST_URL							= AAPI_URL + "/deploy/jobs?format=json&folder=" + strTableName + "&server=" + strDataCenter;
		String REST_DEPLOY_URL					= AAPI_URL + "/deploy";
		
		JsonObject temDeployJsonChange			= new JsonObject();
		JsonObject temDeployJsonSource 			= new JsonObject();
		JSONObject temDeployJson 				= new JSONObject();
		org.json.simple.JSONObject onDoJson 	= new org.json.simple.JSONObject();
		Gson gson 								= new Gson();
		String temDeployStringEnd				= "";
		String deployJson						= "";
		String deployGetJson 					= "";
		String onDoString 						= "";
		String onDoDeployString 				= "";
		String temDeployString					= "";
		String temDeployJobString				= "";
		
		try {
			
			//deploy get 으로 기존 데이터 조회
			deployGetJson = AAPI_Util.restApiDeployGet(AAPI_URL, REST_URL, "GET", strTableName);
			logger.info("폴더를 기준으로 기존 작업목록 json : " + deployGetJson);
			
			//String으로 받은 deploy 값을 json 형태로 변환 gson을 사용해야 키 순서가 변경되지 않음
			temDeployJsonSource = gson.fromJson(deployGetJson,JsonObject.class);
			
			temDeployJsonChange = temDeployJsonSource.getAsJsonObject(strTableName);
			
			//가져온 deploy 중 수정하여 넣을 작업만 제거
			temDeployJsonChange.remove(strJobName);
			logger.info("삭제 처리 후 json : " + temDeployJsonChange.toString());
			
			//수정 되는 작업의 필수 파라미터 값 입력
			if(!strGroupName.equals(""))		temDeployJson.put("SubApplication", strGroupName);
			if(!strMaxWait.equals(""))			temDeployJson.put("DaysKeepActive", strMaxWait);
			if(!strPriority.equals(""))			temDeployJson.put("Priority", strPriority);
			if(!strNodeId.equals("")) 			temDeployJson.put("Host", strNodeId);
			if(!strAuthor.equals(""))			temDeployJson.put("CreatedBy", strAuthor);
			if(!strDescription.equals(""))		temDeployJson.put("Description", strDescription);
			if(!strOwner.equals(""))			temDeployJson.put("RunAs", strOwner);
			if(!strApplication.equals(""))		temDeployJson.put("Application", strApplication);
			if(strTaskType.equals("job"))		temDeployJson.put("FileName", strMemName);
			if(strTaskType.equals("job"))		temDeployJson.put("FilePath", strMemLib);
			if(strTaskType.equals("command")) 	temDeployJson.put("Command", strCommand);
			
			if(strCritical.equals("1")) {
				temDeployJson.put("Critical", true);
			}else if(strCritical.equals("0")) {
				temDeployJson.put("Critical", false);
			}
			
			////이후 조건들은 필수 제외 선택사항 작업////
			temDeployJson.put("When", AAPI_Util.getTschedule(map));
			if(!strTset.equals(""))				temDeployJson.put("Variables", AAPI_Util.getTsetDeploy(strTset));
			if(!strTconditionIn.equals("") ) 	temDeployJson.put("eventsToWaitFor", AAPI_Util.getTconditionInDeploy(strTconditionIn));
			
			if(!strTconditionOut.equals("")){
				if(!AAPI_Util.getTconditionOut(strTconditionOut).get(0).toString().equals("{}"))  temDeployJson.put("eventsToAdd", AAPI_Util.getTconditionOutDeploy(strTconditionOut).get(0));
				if(!AAPI_Util.getTconditionOut(strTconditionOut).get(1).toString().equals("{}"))  temDeployJson.put("eventsToDelete", AAPI_Util.getTconditionOutDeploy(strTconditionOut).get(1));
			}
			
			//RESOURCE
			if(!strTresourcesQ.equals("")) {
				if(strTresourcesQ.indexOf("|") > -1) {
					for(int ii=0; ii < strTresourcesQ.split("[|]").length;ii++) {
						temDeployJson.put(strTresourcesQ.split("[|]")[ii].split(",")[0], AAPI_Util.getTresourceQ(strTresourcesQ.split("[|]")[ii]));
					}
				}else {
					temDeployJson.put(strTresourcesQ.split(",")[0], AAPI_Util.getTresourceQ(strTresourcesQ));
				}
			}
			
			//ON/DO 
			if(!strTsteps.equals("")) {
				int onDoCnt = 0;
				for(int ii=0; ii < strTsteps.split("[|]").length;ii++) {
					if(strTsteps.split("[|]")[ii].split(",")[0].equals("O")) {
						onDoCnt 	+=1;
						onDoJson 	= AAPI_Util.getOnDoDeploy(strTsteps, onDoCnt);
						onDoString 	= onDoJson.toString();
						
						if(strTsteps.split("[|]")[ii].split(",")[3].indexOf("RUNCOUNT") > -1) {
							onDoDeployString +=",\"IfBase:Folder:NumberOfExecutions_"+onDoCnt+ "\":" + onDoString.substring(0,1) + "\"Type\":\"If:NumberOfExecutions\"," + onDoString.substring(1);
						}else {
							onDoDeployString +=",\"IfBase:Folder:CompletionStatus_"+onDoCnt+ "\":" + onDoString.substring(0,1) + "\"Type\":\"If:CompletionStatus\"," + onDoString.substring(1);
						}
					}
				}
			}
			
			//반복작업
			if(!strCyclicType.equals("")) {
				if(strCyclicType.equals("C")) temDeployJson.put("Rerun", AAPI_Util.getRerunDeploy(map));
				if(strCyclicType.equals("V")) temDeployJson.put("RerunIntervals", AAPI_Util.getRerunDeploy(map));
				if(strCyclicType.equals("S")) temDeployJson.put("RerunSpecificTimes", AAPI_Util.getRerunDeploy(map));
			}
			
			temDeployString = temDeployJson.toString();
			
			if(strTaskType.equals("job")) {
				temDeployJobString = "\"" +strJobName + "\" :" + temDeployString.substring(0,temDeployString.indexOf("\"")) + "\"Type\":\"Job:Script\"," + temDeployString.substring(temDeployString.indexOf("\"")); 
			}else if(strTaskType.equals("command")) {
				temDeployJobString = "\"" +strJobName + "\" :" + temDeployString.substring(0,temDeployString.indexOf("\"")) + "\"Type\":\"Job:Command\"," + temDeployString.substring(temDeployString.indexOf("\""));
			}
			
			if(!strTsteps.equals("")) {
				temDeployJobString = temDeployJobString.substring(0,temDeployJobString.length()-1) + onDoDeployString + "}";
			}
			
			temDeployStringEnd = "{\"" + strTableName + "\":" + temDeployJsonChange.toString().substring(0, temDeployJsonChange.toString().length()-1) + "," + temDeployJobString + "}}";
			
			logger.info("수정 후 최종 json : " + temDeployStringEnd);
			
			//json 파일 담기
			String filePath = AAPI_Util.restApiDeployFile(temDeployStringEnd);
			
			//파일 경로 전달 하면서 API 진행
			deployJson = AAPI_Util.restApiDeploy(AAPI_URL, REST_DEPLOY_URL, "POST", filePath);
			
			logger.info("AAPI 응답 : " + deployJson);   
			
			if(deployJson.indexOf("successfulJobsCount") > -1) {
				map.put("rCode", "1"); 
				map.put("rType", "response_def_delete_jobs_type");
				map.put("rMsg", "처리 완료");
			}else {
				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", "삭제 에러");
			}

		} catch (JSONException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;
	}
    
	// 작업 삭제 API
	public Map deleteJobs(Map map) throws IOException{
		
		String strUserToken		= CommonUtil.isNull(map.get("userToken"));

		Doc03Bean docBean		= (Doc03Bean)map.get("doc03");		
		
		String strDataCenter 	= CommonUtil.isNull(docBean.getData_center());
		String strTableName 	= CommonUtil.isNull(docBean.getTable_name());
		String strApplication 	= CommonUtil.isNull(docBean.getApplication());
		String strGroupName 	= CommonUtil.isNull(docBean.getGroup_name());
		String strJobName 		= CommonUtil.isNull(docBean.getJob_name());
		String strNodeId		= CommonUtil.isNull(docBean.getNode_id());
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		String REST_URL					= AAPI_URL + "/deploy/jobs?format=json&folder=" + strTableName + "&server=" + strDataCenter;
		String REST_DEPLOY_URL			= AAPI_URL + "/deploy";
		
		JsonObject temDeployJson2 		= new JsonObject();
		JsonObject temDeployJson3 		= new JsonObject();
		Gson gson 						= new Gson();
		String temDeployStringEnd		= "";
		String deployJson				= "";
		String deployGetJson 			= "";
	
		try {
			
			//deploy get 으로 기존 데이터 조회
			deployGetJson = AAPI_Util.restApiDeployGet(AAPI_URL, REST_URL, "GET", strTableName);
			logger.info("삭제할 작업이 포함된 폴더 작업 목록 : " + deployGetJson);
			
			temDeployJson3 = gson.fromJson(deployGetJson,JsonObject.class);
			
			temDeployJson2 = temDeployJson3.getAsJsonObject(strTableName);
			
			temDeployJson2.remove(strJobName);
			
			temDeployStringEnd = "{\"" + strTableName + "\":" + temDeployJson2.toString() + "}";
			logger.info("삭제 처리 후 최종 Json : " + temDeployStringEnd);
			
			//json 파일 담기
			String filePath = AAPI_Util.restApiDeployFile(temDeployStringEnd);
			
			//파일 경로 전달 하면서 API 진행
			deployJson = AAPI_Util.restApiDeploy(AAPI_URL, REST_DEPLOY_URL, "POST", filePath);
			logger.info("API 응답 : " + deployJson);   
			
			if(deployJson.indexOf("successfulJobsCount") > -1) {
				map.put("rCode", "1"); 
				map.put("rType", "response_def_delete_jobs_type");
				map.put("rMsg", "삭제 처리 완료");
			}else {
				map.put("rCode", "0");
				map.put("rType", "fault_type");
				map.put("rMsg", "삭제 에러");
			}	

		} catch (JSONException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;
	}
    
	// 작업 오더(order) API
	public Map jobsOrder(Map map) throws IOException {
		
		logger.info("작업 오더(order) API 시작");
		
		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		String strSmartTableCnt		= CommonUtil.isNull(map.get("smartTable_cnt"));
		String strSmartTableOrderId	= CommonUtil.isNull(map.get("smartTable_orderId"));
		
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
		
		Doc05Bean docBean 			= null;
		docBean						= (Doc05Bean) map.get("doc05");
		
		// docBean 이 null 이면 작업 등록 시 특정실행날짜가 있어서 호출하는 ORDER.
		if ( docBean == null ) {
			
			logger.info("특정실행날짜가 있어서 호출하는 ORDER");
			
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
			
			logger.info("직접 호출하는 ORDER");
			
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
			
			if ( strSmartTableCnt.equals("") ) {
				strTableInfoMent = "new";
			} else {
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
			
			map.put("data_center", strDataCenter);
			map.put("force_yn", strForceYn);
			map.put("hold_yn", strHoldYn);
			map.put("wait_gubun", strWaitGubun);
			map.put("table_name", strTableName);
			map.put("job_name", strJobName);
			map.put("order_date", strOrderDate);
			map.put("task_type", strTaskType);
			map.put("t_set", strTset);
		}
		
		JSONObject orderResponseJson 	= null;
		JSONObject statusResponseJson 	= null;
		JSONObject status 				= null;
		JSONArray statuses 				= null;
		JSONArray errors_array 			= null;
		String REST_URL 				= AAPI_URL + "/run/order";
		String message 					= "";
		String errors 		 			= "";
		String orderId					= "";
		String jobId 					= "";
		String error_message			= "";
		
		logger.info("REST_URL : " + REST_URL);
		  
		try {
			
			logger.info("restApiCall_order >>>>> start");
			
			orderResponseJson = AAPI_Util.restApiCall_order(AAPI_URL, REST_URL, "POST", map);
			
			logger.info("restApiCall_order >>>>> end");
		
			if (!orderResponseJson.isNull("message")) {
				
				//order 성공시 order_id를 구하는 API 호출을 한번더 진행 
				String runId		= (String)orderResponseJson.get("runId");
				String REST_URL2 	= AAPI_URL + "/run/status/" + runId;
				
				logger.info("REST_URL(orderId) : " + REST_URL2);
				
				statusResponseJson = AAPI_Util.restApiStatusRunId(AAPI_URL, REST_URL2, "GET", runId);
				
				logger.info("statusResponseJson ::::: " + statusResponseJson);
				
				String strStatusResponseJson = statusResponseJson.toString();
				if(strStatusResponseJson.indexOf("errors") > -1) {
					// 오더는 성공적으로 됐지만 order_id를 구하는 API 호출에 실패 시 진행
					// 에러메세지에 order_id가 찍혀 있을경우 성공처리(2024-07-19 김선중)
					logger.info("statusResponseJson : error");
					statuses 	= statusResponseJson.getJSONArray("errors");
					
					for(int i=0;i<statuses.length();i++) {
						status = statuses.getJSONObject(i);
						error_message = status.getString("message");
						error_message = error_message.split(":")[1];
						error_message = error_message.split(" ")[0];
						
						if(error_message.length() == 5) { // order_id 5자리
							orderId = error_message;
						}
					}
					
				}else {
					logger.info("statusResponseJson : success");
					statuses 	= statusResponseJson.getJSONArray("statuses");
					
					for(int i=0;i<statuses.length();i++) {
						status = statuses.getJSONObject(i);
						if(status.getString("type").equals("Command") || status.getString("type").equals("Job") || status.getString("type").equals("Dummy")) {
							jobId 		= status.getString("jobId");
						}
					}
					
//					jobId 		= statuses.getJSONObject(0).getString("jobId");
					
					orderId		= jobId.split(":")[1];
				}
				
				logger.info("orderId ::::: " + orderId);

				message = (String)orderResponseJson.get("message");
				logger.info("api 결과 message >>>>> " + message);
			} else {
				errors_array =  orderResponseJson.getJSONArray("errors");
				
				for(int i = 0; i < errors_array.length(); i++) {
					errors = (String) errors_array.getJSONObject(i).get("message");
					logger.info("api 결과 errors >>>>> " + errors);
				}
			}
		} catch (JSONException e) {
			
			map.put("rCode", 	"-1");
			map.put("rMsg", 	e.getMessage());
			
			e.printStackTrace();
		}
		
		// 성공 처리.
		if ( message.equals("SUCCESS") || !orderId.equals("") ) {
			map.put("rCode", 	"1");
			map.put("rMsg", 	"처리완료");
			map.put("rOrderId", orderId);

		// 에러 처리.
		} else {
			map.put("rCode", 	"-2");
			map.put("rMsg", 	errors);
		}
		
		return map;				
	}
    
	// 작업 상태변경 API
	public Map jobAction(Map map) throws IOException {
		
//		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		
		String strUserToken		= CommonUtil.isNull(map.get("userToken"));
//		String strUserTokenApi	= CommonUtil.isNull(request.getSession().getAttribute("USER_TOKEN"));
		String strDataCenter 	= CommonUtil.isNull(map.get("data_center"));
		String strOrderId 		= CommonUtil.isNull(map.get("order_id"));
		String strFlag 			= CommonUtil.isNull(map.get("flag"));
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		if ( strFlag.equals("HOLD") ) {
			strFlag = "hold";
		}else if ( strFlag.equals("CONFIRM") ) {
			strFlag = "confirm";
		}else if ( strFlag.equals("DELETE") ) {
			strFlag = "delete";
		}else if ( strFlag.equals("RERUN") ) {
			strFlag = "rerun";
		}else if ( strFlag.equals("RUNNOW") ) {
			strFlag = "runNow";
		}else if ( strFlag.equals("UNDELETE") ) {
			strFlag = "undelete";
		}else if ( strFlag.equals("FORCEOK") ) {
			strFlag = "setToOk";
		}else if ( strFlag.equals("FREE") ) {
			strFlag = "free";
		}else if ( strFlag.equals("KILL") ) {
			strFlag = "kill";
		}
		
		String REST_URL = AAPI_URL + "/run/job/" + strDataCenter + ":" + strOrderId + "/" + strFlag;
		
		JSONObject responseJson = null;
		JSONArray errors_array 	= null;
		String message 			= "";
		String errors 		 	= "";
		  
		logger.info("상태변경 REST_URL : " + REST_URL);

		try {
//			if(strUserTokenApi.equals(strUserToken)) {
				responseJson = AAPI_Util.restApiCall(AAPI_URL, REST_URL, "POST");
				
				logger.info("상태변경 응답 : " + responseJson);
//			}else {
//				responseJson = AAPI_Util.restApiCall2(AAPI_URL, REST_URL, "POST", strUserTokenApi);
//			
//				System.out.println("responseJson : " + responseJson);
//			}
			if (!responseJson.isNull("message")) {
				message = (String)responseJson.get("message");
			
			} else {
				errors_array =  responseJson.getJSONArray("errors");
				
				for(int i = 0; i < errors_array.length(); i++) {
					errors = (String) errors_array.getJSONObject(i).get("message");
					errors = errors.replaceAll("\n", "");
				}
			}
		} catch (JSONException e) {
			
			map.put("rCode", 	"-1");
			map.put("rMsg", 	e.getMessage());
			
			e.printStackTrace();
		}
		
		// 성공 처리.
		if ( message.equals("SUCCESS") ) {
			map.put("r_code", 	"1");
			map.put("rCode", 	"1");
			map.put("r_msg", 	"DEBUG.01");				
			map.put("rMsg", 	"처리완료");
			

		// 에러 처리.
		} else {
			//map.put("rCode", 	"-2");
			//map.put("rMsg", 	errors);
			map.put("r_code", 	"-2");
			map.put("r_msg", 	errors);
		}
		 
		return map;
	}
	
	// modify API
	public Map jobModify(Map map) throws IOException {
		
		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strOrderId 			= CommonUtil.isNull(map.get("order_id"));
		String strJobName 			= CommonUtil.isNull(map.get("job_name"));
		
		String strGroupName 		= CommonUtil.isNull(map.get("group_name"));
//		String strApplication 		= CommonUtil.isNull(map.get("application"));
		String strNodeId			= CommonUtil.isNull(map.get("node_id"));
		String strMemLib 			= CommonUtil.isNull(map.get("mem_lib"));
		String strMemName 			= CommonUtil.isNull(map.get("mem_name"));
		String strCommand 			= CommonUtil.isNull(map.get("command"));
//		String strOwner 			= CommonUtil.isNull(map.get("owner"));
//		String strRerunMax 			= CommonUtil.isNull(map.get("rerun_max"));
		String strTimeFrom 			= CommonUtil.isNull(map.get("time_from"));
		String strTimeUntil 		= CommonUtil.isNull(map.get("time_until")); 
//		String strCyclic			= CommonUtil.isNull(map.get("cyclic"));
//		String strRerunInterval		= CommonUtil.isNull(map.get("rerun_interval"));
//		String strPriority 			= CommonUtil.isNull(map.get("priority"));
//		String strMaxWait 			= CommonUtil.isNull(map.get("max_wait"));
		String strTconditionIn		= CommonUtil.isNull(map.get("t_conditions_in"));
		String strTconditionOut		= CommonUtil.isNull(map.get("t_conditions_out"));
		String strTset				= CommonUtil.isNull(map.get("t_set"));
		String strType				= CommonUtil.isNull(map.get("task_type"));
		
		strCommand = strCommand.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">").replace("&amp;","&");
		strTset = strTset.replace("&apos;","\'").replace("&amp;","&").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		
		String jobId					= strDataCenter + ":" + strOrderId;
		String REST_URL					= AAPI_URL + "/run/job/" + strDataCenter + ":" + strOrderId + "/modify";
		
		JSONObject responseJson 		= null;
		JSONArray errors_array 			= null;
		String message 					= "";
		String errors 		 			= "";
		String[] aTmpT					= null;
		JsonObject modifyJson 			= new JsonObject();
		JsonObject temModifyJson 		= new JsonObject();
		JsonObject when 				= new JsonObject();
		
		try {
			
			// 수정할 정보를 json에 담기
			if(strType.equals("Command")) {
				temModifyJson.addProperty("Type", "Job:Command");
			}else { //Job, script
				temModifyJson.addProperty("Type", "Job:Script");
			}

			if (!strGroupName.equals("")) 		temModifyJson.addProperty("SubApplication", strGroupName); 
			if (!strNodeId.equals("")) 			temModifyJson.addProperty("FileName", strMemName); 
			if (!strNodeId.equals("")) 			temModifyJson.addProperty("FilePath", strMemLib); 
			if (strType.equals("Command")) 		temModifyJson.addProperty("Command", strCommand);
			if (!strTconditionIn.equals("") ) 	temModifyJson.add("eventsToWaitFor", AAPI_Util.getTconditionIn(strTconditionIn));
			if (!strTset.equals("")) 			temModifyJson.add("Variables", AAPI_Util.getTset(strTset));
			
			if (!strTconditionOut.equals("") ) {
				if(!AAPI_Util.getTconditionOut(strTconditionOut).get(0).toString().equals("{}"))  temModifyJson.add("eventsToAdd", AAPI_Util.getTconditionOut(strTconditionOut).get(0));
				if(!AAPI_Util.getTconditionOut(strTconditionOut).get(1).toString().equals("{}"))  temModifyJson.add("eventsToDelete", AAPI_Util.getTconditionOut(strTconditionOut).get(1));
			}
			
			when.addProperty("ToTime", strTimeUntil);
			when.addProperty("FromTime", strTimeFrom);
			temModifyJson.add("When", when);
			
			modifyJson.add(strJobName, temModifyJson);
			
			logger.info("실시간 속성변경 : " + modifyJson.toString());
			
			//json 파일 담기
			String filePath = AAPI_Util.restApiFile(modifyJson);
			
			//파일 경로 전달 하면서 modify API 진행
			responseJson = AAPI_Util.restApiModify(AAPI_URL, REST_URL, "POST", filePath, jobId);
			
			logger.info("실시간 속성변경(modify api) 결과 >>>>> " + responseJson);
			
			if (!responseJson.isNull("message")) {
				message = (String)responseJson.get("message");
			} else {
				errors_array =  responseJson.getJSONArray("errors");
				
				for(int i = 0; i < errors_array.length(); i++) {
					errors = (String) errors_array.getJSONObject(i).get("message");
					errors = errors.replaceAll("\n", "");
				}
			}
		} catch (JSONException e) {
			map.put("rCode", 	"-1");
			map.put("rMsg", 	e.getMessage());
			e.printStackTrace();
		}
		
		// 성공 처리.
		if ( message.equals("SUCCESS") ) {
			map.put("rCode", 	"1");
			map.put("rMsg", 	"처리완료");
		// 에러 처리.
		} else {
			map.put("rCode", 	"-2");
			map.put("rMsg", 	errors);
		}
		 
		return map;
	}	
	
	// Connection Profile API
	public JSONObject getConnectionProfileDao(Map map) throws IOException{
		
		String strUserToken		= CommonUtil.isNull(map.get("userToken"));
		String strType			= CommonUtil.isNull(map.get("type"));
		String strAgent			= CommonUtil.isNull(map.get("host"));
		String strServer		= CommonUtil.isNull(map.get("server"));
		String REST_URL			= "";
		
		logger.info("connection profile 가져올 type ::::: " + strType);

		if(strType.equals("Kubernetes")){
			REST_URL					= AAPI_URL + "/deploy/connectionprofiles/centralized?type="+strType+"&name=*";
		}else if(strType.equals("FileTransfer")){
			REST_URL					= AAPI_URL + "/deploy/connectionprofiles?type="+strType+"&agent="+strAgent+"&server="+strServer;
		}else if(strType.equals("Database")){
			REST_URL					= AAPI_URL + "/deploy/connectionprofiles?type="+strType+"&agent="+strAgent+"&server="+strServer;
		}
		
		logger.info("AAPI ::::: " + REST_URL);
		
		String message 					= "";
		String errors 		 			= "";
		JSONObject responseJson			= null;

		try {
			//connection profile 조회
			responseJson = AAPI_Util.restApi_connection_profile(AAPI_URL, REST_URL, "GET");
			
			logger.info("connection progile 목록 ::::: " + responseJson.toString());

		} catch (JSONException e) {
			e.printStackTrace();
			map.put("error", e.toString());
		}
		
		return responseJson;
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
					
					InConditionType inConditionType = new InConditionType();
					if ( !"".equals(CommonUtil.isNull(aTmp[0])) ) inConditionType.setCondition(CommonUtil.isNull(aTmp[0]));
					if ( !"".equals(CommonUtil.isNull(aTmp[1])) ) inConditionType.setDate(CommonUtil.isNull(aTmp[1]));
					if ( !"".equals(CommonUtil.isNull(aTmp[2])) ) inConditionType.setAndOr(AndOrType.fromValue(CommonUtil.isNull(aTmp[2])));
					
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
				variableAssignmentType.setValue(aTmp[1]);
				
				alTmp.add(variableAssignmentType);
	    	}	    	
	    	
	    	variableAssignmentsType.setVariableAssignment(alTmp);	    	
	    }
	    
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
	
	
	public Map deleteCondition(Map map) {
		
		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
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
			
			String strResData 	= invokeRequest(strReqXml);
			String strResXml 	= "";

			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {

				map = CommonUtil.apiErrorProcess(strResData);

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
	public Map getPollData(String strUserToken, String strResponseToken) {
		
		Map<String, Object> map	= new HashMap<String, Object>();
		String strStatus		= "";
		String strOrderId		= "";
		
		// 1초 후 polling (정보 갱신에 시간이 좀 걸림)
		CommonUtil.setTimeout(1000);
		
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
			
			// 에러 처리.
			if ( strResData.indexOf("ctmem:error") > 0 ) {
				
				map = CommonUtil.apiPollErrorProcess(strResData);

			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				strResXml = strResXml.replaceAll("response_poll_order_force", "response_data_jobs_job_order_force_job_type").replaceAll(" xmlns:ctmem=\"http://www.bmc.com/ctmem/schema900\"", "").replaceAll("ctmem:", "");
			
				// 언마샬링 해서 값을 담는다.
				JAXBElement<ResponseOrderForceJobType> dataRoot = (JAXBElement<ResponseOrderForceJobType>) CommonUtil.unmarshaller(ResponseOrderForceJobType.class, strResXml);
				
	            map.put("rCode", "1");
				map.put("rType", "response_data_jobs_job_order_force_job");
				map.put("rObject", dataRoot);
				
				strStatus	= CommonUtil.isNull(dataRoot.getValue().getStatus());
				
				if ( strStatus.equals("OK") ) {
					strOrderId 	= CommonUtil.isNull(dataRoot.getValue().getJobs().getJob().get(0).getJobData().getOrderId());	
				}
				
				map.put("order_id", strOrderId);
				map.put("status", 	strStatus);
			}		
			
		} catch (JAXBException e) {
			e.printStackTrace();
			
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");
		}
		
		return map;
	}
}