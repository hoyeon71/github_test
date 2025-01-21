package com.ghayoun.ezjobs.t.axis;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Map;
import java.util.Properties;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBElement;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.annotation.XmlEnumValue;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.bmc.ctmem.emapi.EMXMLInvoker;
import com.bmc.ctmem.emapi.InvokeException;
import com.bmc.ctmem.schema900.AndOrType;
import com.bmc.ctmem.schema900.AnyFolderType;
import com.bmc.ctmem.schema900.CriterionType;
import com.bmc.ctmem.schema900.CyclicTypeType;
import com.bmc.ctmem.schema900.DatesType;
import com.bmc.ctmem.schema900.DefJobType;
import com.bmc.ctmem.schema900.DefJobsType;
import com.bmc.ctmem.schema900.DefTaskType;
import com.bmc.ctmem.schema900.FilterType;
import com.bmc.ctmem.schema900.FolderType;
import com.bmc.ctmem.schema900.IntervalSequenceType;
import com.bmc.ctmem.schema900.JobRuleBasedCalType;
import com.bmc.ctmem.schema900.JobRuleBasedCalsType;
import com.bmc.ctmem.schema900.OperatorType;
import com.bmc.ctmem.schema900.ParamType;
import com.bmc.ctmem.schema900.RequestDefAddJobsType;
import com.bmc.ctmem.schema900.RequestDefCreateFolderType;
import com.bmc.ctmem.schema900.RequestDefDeleteJobsType;
import com.bmc.ctmem.schema900.RequestDefUploadFolderType;
import com.bmc.ctmem.schema900.ResponseDefAddJobsType;
import com.bmc.ctmem.schema900.ResponseDefCreateFolderType;
import com.bmc.ctmem.schema900.ResponseDefDeleteJobsType;
import com.bmc.ctmem.schema900.ResponseDefUploadFolderType;
import com.bmc.ctmem.schema900.SearchCriterionType;
import com.bmc.ctmem.schema900.SpecificTimesType;
import com.bmc.ctmem.schema900.StartEndTargetType;
import com.bmc.ctmem.schema900.YesNoType;
import com.ghayoun.ezjobs.common.util.CommonUtil;
import com.ghayoun.ezjobs.t.domain.Doc06Bean;

public class T_Manager5 {

	protected final Log logger = LogFactory.getLog(getClass());
	private int errCnt 			= 0;

	//
	public static String getUserToken() {
		HttpServletRequest request 	= ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();
		String strUserToken = "";

		try {
			CommonUtil.emLogin(request);
			strUserToken = CommonUtil.isNull(request.getSession().getAttribute("USER_TOKEN"));
		} catch (ServletException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return strUserToken;
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> defCreateJobs(Map<String, Object> map){
		
		String reqXml 	= "";
		String resXml 	= "";
		String resTitle = "";
		String resXml2 	= "";
		
		try{
			
			int table_cnt = CommonUtil.getDefTableCnt(map);
			
			if(table_cnt == 0){
				reqXml = defCreateTableJobs(map);
			}else{
				reqXml = defAddJobs(map);
			}	
			
			logger.info("#T_Manager5 | defCreateJobs | reqXml :::"+reqXml);
			
			String resData 	= invokeRequest(reqXml);
			logger.info("#T_Manager5 | defCreateJobs | resData :::"+resData);
			
			if(resData.indexOf("ctmem:error") > 0){		//에러일경우
				map = CommonUtil.apiErrorProcess(resData);
				logger.info("#T_Manager5 | defCreateJobs | resData Error Map :::"+map);
			}else{
				resXml = resData.substring(resData.indexOf("ctmem")-1);
				resTitle = resXml.substring(resXml.indexOf("ctmem")+6, resXml.indexOf("xmlns")-1);
				resXml = resXml.substring(0, resXml.lastIndexOf("ctmem")+6) + resTitle + ">";
				
				// [org.apache.xerces.impl.io.MalformedByteSequenceException: 1-바이트 UTF-8 순서 중 1바이트가 올바르지 않습니다.]
				// LANG=C 환경에서 위의 에러가 나면서 Exception 떨어지기 때문에 table_name 제거해보았다.
				resXml2 = resXml.substring(0, resXml.indexOf("<ctmem:folder_name>")+19);
				resXml2	+= resXml.substring(resXml.indexOf("</ctmem:folder_name>"), resXml.length());
				
				if(table_cnt == 0){
					JAXBElement<ResponseDefCreateFolderType> dataRoot = (JAXBElement<ResponseDefCreateFolderType>) CommonUtil.unmarshaller(ResponseDefCreateFolderType.class, resXml2);
			            
					map.put("rCode", "1");
					map.put("rType", "response_def_create_table");
					map.put("rObject", dataRoot);
					
				}else{
					JAXBElement<ResponseDefAddJobsType> dataRoot = (JAXBElement<ResponseDefAddJobsType>) CommonUtil.unmarshaller(ResponseDefAddJobsType.class, resXml2);
			            
			        map.put("rCode", "1");
			        map.put("rType", "response_def_create_jobs");
					map.put("rObject", dataRoot);
				}
			}
		}catch(JAXBException je){	
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", "API 통신 에러!");		
		}catch(Exception e){
			map.put("rCode", "0");
			map.put("rType", "fault_type");
			map.put("rMsg", e.toString());			
		}
		
		return map;
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
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
            	
				password = T_Manager4.GetValFromXml(request,"password");
				
				if (password.length() > 0 && request.indexOf("request_register") > 0) {
					
					encoded_passwd 	= invoker.BuildPasswordString(password);					
					request 		= request.replaceFirst(password, encoded_passwd);
//					request 		= request.substring(0, request.indexOf("<ctmem:password>")) + "<ctmem:password>" + encoded_passwd + request.substring(request.indexOf("</ctmem:password>"), request.length());
				}
				
				System.out.println(request);
				
				response = invoker.invoke(request);
            }
            
            catch (InvokeException ex) {
            	
            	logger.error("#T_Manager5 | getMajorCode() : " + ex.getMajorCode() );
            	logger.error("#T_Manager5 | getMinorCode() : " + ex.getMinorCode());
            	logger.error("#T_Manager5 | getMessage() : " + ex.getMessage() );
            	logger.error("#T_Manager5 | getReason() : " + ex.getReason() );
            }
            catch (Exception ex) {
                
            }
        }
                     
        return response;
    }
		
	public Map<String, Object> deleteJobs(Map<String, Object> map){
		
		String strUserToken		= CommonUtil.isNull(map.get("userToken"));
		
		System.out.println("작업지운다.");
		
		Doc06Bean docBean			= (Doc06Bean)map.get("doc06");
		
		String strDataCenter 		= CommonUtil.isNull(docBean.getData_center());
		String strDataCenterName 	= CommonUtil.isNull(docBean.getData_center_name());
		String strTableName 		= CommonUtil.isNull(docBean.getTable_name());		
		String strApplication 		= CommonUtil.isNull(docBean.getApplication());
		String strGroupName 		= CommonUtil.isNull(docBean.getGroup_name());
		String strJobName 			= CommonUtil.isNull(docBean.getJob_name());
		
		// DATA_CENTER에 SCODE_CD,SCODE_ENG_NM 으로 설정 되어 있음.
		if ( !strDataCenter.equals("") && strDataCenter.indexOf(",") > -1 ) { 
			strDataCenter = strDataCenter.split(",")[1];
		}
		if ( !strDataCenterName.equals("") && strDataCenterName.indexOf("-") > -1 ) { 
			strDataCenterName = strDataCenterName.split("-")[1];
		}

		try {
			
			JAXBContext context 				= JAXBContext.newInstance(RequestDefDeleteJobsType.class);			
			RequestDefDeleteJobsType reqType 	= new RequestDefDeleteJobsType();
			java.io.StringWriter sw 			= new java.io.StringWriter();
			
			// 테이블 설정.
			AnyFolderType anyFolderType = new AnyFolderType();
			anyFolderType.setControlM(strDataCenter);
			anyFolderType.setFolderName(strTableName);
			
			ArrayList<ParamType> alTmp = new ArrayList<>();
			
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
			
			ArrayList<SearchCriterionType> alTmp2 = new ArrayList<>();
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
		
	@SuppressWarnings({ "unchecked", "rawtypes" })
	public String defAddJobs(Map<String, Object> map){

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		
		Doc06Bean docBean			= (Doc06Bean)map.get("doc06");
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
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib(), "FILE_PATH");
		String strMemName			= CommonUtil.isNull(docBean.getMem_name(), "FILE_NAME");
		String strOwner				= CommonUtil.isNull(docBean.getOwner());
		String strAuthor			= CommonUtil.isNull(docBean.getAuthor());
		//String strDescription		= CommonUtil.encode(CommonUtil.isNull(docBean.getDescription()));
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
		
		String strApplType			= "OS";
		
		//String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getInd_cyclic());
		
		if ( strCountCyclicFrom.equals("T") ) {
			strCountCyclicFrom = "target";
		} else if ( strCountCyclicFrom.equals("S") ) {
			strCountCyclicFrom = "start";
		} else if ( strCountCyclicFrom.equals("E") ) {
			strCountCyclicFrom = "end";
		}
		
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
		
		strCommand = strCommand.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
		
		String strRerunIntervalMent = "";
		if ( !strRerunInterval.equals("") ) {			
			strRerunIntervalMent = CommonUtil.lpad(strRerunInterval, 5, "0");
		}
			
		try {
		
			logger.info("#T_Manager5 | defAddJobs | userToken :::"+strUserToken);
			logger.info("#T_Manager5 | defAddJobs | job_name :::"+strJobName);
			
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
			logger.debug("#T_Manager5 | defAddJobs | In Condition :::"+strTconditionIn);
			if ( strTconditionIn.length() > 0 ) {
				defJobType.setInConditions(T_Manager4.getInConditions(strTconditionIn));
			}
			
			// Out Condition.
			logger.debug("#T_Manager5 | defAddJobs | Out Condition :::"+strTconditionOut);
			if ( strTconditionOut.length() > 0 ) {
				defJobType.setOutConditions(T_Manager4.getOutConditions(strTconditionOut));
			}
			
			// Quantitatvie Resouce.
			logger.debug("#T_Manager5 | defAddJobs | Quantitatvie Resouce :::"+strTresourcesQ);
			if ( strTresourcesQ.length() > 0 ) {
				defJobType.setQuantitativeResources(T_Manager4.getQresources(strTresourcesQ));
			}
			
			// Control Resouce.
			logger.debug("#T_Manager5 | defAddJobs | Control Resouce :::"+strTresourcesC);
			if ( strTresourcesC.length() > 0 ) {
				defJobType.setControlResources(T_Manager4.getCresources(strTresourcesC));
			}
			
			// Set 변수.
			logger.debug("#T_Manager5 | defAddJobs | Set variable :::"+strTset);
			if ( strTset.length() > 0 ) {
				defJobType.setVariableAssignments(T_Manager4.getVariableAssignments(strTset));
			}
			
			// Step.
			logger.debug("#T_Manager5 | defAddJobs | Steps :::"+strTsteps);
			if ( strTsteps.length() > 0 ) {				
				defJobType.setOnDoStatements(T_Manager4.getOnDoStatements(strTsteps));				
			}
			
			// PostProc.
			logger.debug("#T_Manager5 | defAddJobs | PostProc :::"+strTpostproc);
			if ( strTpostproc.length() > 0 ) {				
				defJobType.setShouts(T_Manager4.getShouts(strTpostproc));				
			}
			
		    // Tag.
			logger.debug("#T_Manager5 | defAddJobs | Tag :::"+strTtagName);
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
		
			logger.debug("#T_Manager5 | defAddJobs | strReqXml :::"+strReqXml);
			
		} catch (JAXBException e) {
			logger.error("#T_Manager5 | defAddJobs | exception :::"+e.getMessage());
		}
		
		return strReqXml;
	}
	
	public String defCreateTableJobs(Map<String, Object> map){

		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		
		Doc06Bean docBean = (Doc06Bean)map.get("doc06");
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
		String strMemLib			= CommonUtil.isNull(docBean.getMem_lib(), "FILE_PATH");
		String strMemName			= CommonUtil.isNull(docBean.getMem_name(), "FILE_NAME");
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
		
		String strApplType			= "OS";
		
		//String strCountCyclicFrom	= CommonUtil.isNull(docBean.getCount_cyclic_from());
		String strCountCyclicFrom	= CommonUtil.isNull(docBean.getInd_cyclic());
		
		if ( strCountCyclicFrom.equals("T") ) {
			strCountCyclicFrom = "target";
		} else if ( strCountCyclicFrom.equals("S") ) {
			strCountCyclicFrom = "start";
		} else if ( strCountCyclicFrom.equals("E") ) {
			strCountCyclicFrom = "end";
		}
		
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
		String strUserDaily			= CommonUtil.isNull(docBean.getUser_daily());
	
		strCommand = strCommand.replaceAll("&apos;","\'").replace("&amp;quot;","\"").replace("&quot;","\"").replace("&lt;","<").replace("&gt;",">");
		
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
				
		try {
			
			logger.info("#T_Manager5 | defCreateTableJobs | userToken :::"+strUserToken);
			logger.info("#T_Manager5 | defCreateTableJobs | job_name :::"+strJobName);
			
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
			
			logger.debug("#T_Manager5 | defCreateTableJobs | In Condition :::"+strTconditionIn);
			// In Condition.
			if ( strTconditionIn.length() > 0 ) {
				defJobType.setInConditions(T_Manager4.getInConditions(strTconditionIn));
			}
			
			logger.debug("#T_Manager5 | defCreateTableJobs | Out Condition :::"+strTconditionOut);
			// Out Condition.
			if ( strTconditionOut.length() > 0 ) {
				defJobType.setOutConditions(T_Manager4.getOutConditions(strTconditionOut));
			}
			
			logger.debug("#T_Manager5 | defCreateTableJobs | Quantitatvie Resouce :::"+strTresourcesQ);
			// Quantitatvie Resouce.
			if ( strTresourcesQ.length() > 0 ) {
				defJobType.setQuantitativeResources(T_Manager4.getQresources(strTresourcesQ));
			}
			
			logger.debug("#T_Manager5 | defCreateTableJobs | Control Resouce :::"+strTresourcesC);
			// Control Resouce.
			if ( strTresourcesC.length() > 0 ) {
				defJobType.setControlResources(T_Manager4.getCresources(strTresourcesC));
			}
			
			logger.debug("#T_Manager5 | defCreateTableJobs | Set variable :::"+strTset);
			// Set 변수.
			if ( strTset.length() > 0 ) {
				defJobType.setVariableAssignments(T_Manager4.getVariableAssignments(strTset));
			}
			
			logger.debug("#T_Manager5 | defCreateTableJobs | Steps :::"+strTsteps);
			// Step.
			if ( strTsteps.length() > 0 ) {				
				defJobType.setOnDoStatements(T_Manager4.getOnDoStatements(strTsteps));				
			}
			
			logger.debug("#T_Manager5 | defCreateTableJobs | PostProc :::"+strTpostproc);
			// PostProc.
			if ( strTpostproc.length() > 0 ) {				
				defJobType.setShouts(T_Manager4.getShouts(strTpostproc));				
			}

		    // Tag.
			logger.debug("#T_Manager5 | defCreateTableJobs | Tag :::"+strTtagName);
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
			
			logger.debug("#T_Manager5 | defCreateTableJobs | strReqXml :::"+strReqXml);
		} catch (JAXBException e) {
			//e.printStackTrace();
			logger.error("#T_Manager5 | defCreateTableJobs | exception :::"+e.getMessage());
		}
		
		return strReqXml;
	}
	
	public Map defUploadjobs(Map map){
		
		String strUserToken			= CommonUtil.isNull(map.get("userToken"));
		String strDataCenter 		= CommonUtil.isNull(map.get("data_center"));
		String strTableName 		= CommonUtil.isNull(map.get("table_name"));
		String strParentTableName	= "";
		
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
				System.out.println("진짜 에러 맞냐?" + map);

			// 성공 처리.
			} else {

				// 리턴 XML 값을 언마샬링 할 수 있게 가공.
				strResXml 			= strResData.substring(strResData.indexOf("ctmem")-1);				
				String strResTitle 	= strResXml.substring(strResXml.indexOf("ctmem")+6, strResXml.indexOf("xmlns")-1);
				strResXml 			= strResXml.substring(0, strResXml.lastIndexOf("ctmem")+6) + strResTitle + ">";
				
				// 언마샬링 해서 값을 담는다.
	            JAXBElement<ResponseDefUploadFolderType> dataRoot = (JAXBElement<ResponseDefUploadFolderType>) CommonUtil.unmarshaller(ResponseDefUploadFolderType.class, strResXml);
	            
	            System.out.println("진짜 에러 아니잖아!!?" + dataRoot);
	            
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
	
}
