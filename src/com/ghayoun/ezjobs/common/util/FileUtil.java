package com.ghayoun.ezjobs.common.util;

import java.io.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.context.ContextLoader;

import com.ghayoun.ezjobs.m.domain.DefJobBean;
import com.ghayoun.ezjobs.m.domain.JobDefineInfoBean;
import com.ghayoun.ezjobs.m.domain.JobLogBean;
import com.ghayoun.ezjobs.m.service.PopupDefJobDetailService;
import com.ghayoun.ezjobs.t.domain.ActiveJobBean;

public class FileUtil {

	public void copyFile(InputStream is, FileOutputStream fos) 
												throws IOException{
		try{
			byte[] bytes = new byte[1024];
			int len = 0;
			while( (len = is.read(bytes)) > 0 ){                
				fos.write(bytes, 0, len);
			}
		}catch(IOException ioe){
			ioe.printStackTrace();
			throw ioe;
		}
	}
	

    public void copyFile(File from_file, File to_file) 
								throws IOException{
    	InputStream is= null;
        FileOutputStream fos = null;
    	try{
			is = new FileInputStream(from_file);
			fos = new FileOutputStream(to_file);
			
			byte[] bytes = new byte[1024];
			int len = 0;
			while( (len = is.read(bytes)) > 0 ){                
				fos.write(bytes, 0, len);
			}
		}catch(IOException ioe){
			ioe.printStackTrace();
			throw ioe;
		}finally{
			if(is != null) is.close();
			if(fos != null) fos.close();
		}
	}
    	
	
	public void delDir(File file) {  

		if ( file.exists() ){
			File[] files = file.listFiles();
			for( int i = 0; files!=null && i < files.length; i++) {
				if (files[i].isDirectory()) {
					delDir(files[i]);
				}else{
					files[i].delete();
				}
			}
			file.delete();
		}
	} 
	
	public static void activeJobListWrite(String file_nm, List<ActiveJobBean> activeJobList){
		
		FileWriter fw = null;
		BufferedWriter bw = null;
		String str = "";
		
		try{
			
			fw = new FileWriter(file_nm, false);
			bw = new BufferedWriter(fw);
			
			str += "순번★작업명★작업설명★테이블명★애플리케이션★그룹★상태★변경자";
			bw.write(str);
			str = "";
			for(int i=0;i<activeJobList.size();i++){	
				
				ActiveJobBean bean = activeJobList.get(i);
				
				String state_result = "";
				String state_result2 = "";
			
				if( CommonUtil.isNull(bean.getState_result(), "").equals("Wait Condition") || CommonUtil.isNull(bean.getState_result(), "").equals("Wait Time") ){
					state_result += CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
					state_result += state_result2;				
				}else{
					state_result += CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_"));
					state_result += state_result2;				
				}
				
				str += (i+1)+"★";
				str += CommonUtil.isNull(bean.getJob_name(),bean.getMemname())+"★";
				str += CommonUtil.isNull(bean.getDescription())+"★";
				str += CommonUtil.isNull(bean.getOrder_table())+"★";
				str += CommonUtil.isNull(bean.getApplication())+"★";
				str += CommonUtil.isNull(bean.getGroup_name())+"★";
				str += CommonUtil.isNull(state_result)+"★";			
				str += CommonUtil.isNull(bean.getUser_nm());
				
				bw.newLine();
				bw.write(str);
				str = "";				
			}
			
			bw.close();
			
		}catch(Exception e){
			e.getMessage();
		}finally{
			try{ if(fw != null) fw.close(); } catch(Exception e){}
			try{ if(bw != null) bw.close(); } catch(Exception e){}
		}
	}
	
	public static void defJobListWrite(String file_nm, List<DefJobBean> defJobList){
		
		FileWriter fw = null;
		BufferedWriter bw = null;
		String str = "";
		
		try{
					
			String	strApplication			= "";
			String	strGroup_name			= "";	
			String	strJob_name				= "";		
			String	strDescription			= "";	
			String	strMem_name				= "";		
			String	strMem_lib				= "";		
			String	strAuthor				= "";		
			String	strOwner				= "";			
			String	strTask_type			= "";			
			String	strArgument				= "";		
			String	strJobTypeGb			= "";		
			String	strJobSchedGb			= "";		
			String	strMcode_nm				= "";			
			String	strScode_nm				= "";			
			String	strNode_id				= "";		
			String	strPriority				= "";						
			String	strCritical				= "";						
			String	strCyclic				= "";		
			String	strRerun_interval		= "";
			String	strRerun_max			= "";						
			String	strCount_cyclic_from_org	= "";
			String	strCount_cyclic_from	= "";
			String	strCommand				= "";		
			String	strConfirm_flag_org		= "";
			String	strConfirm_flag			= "";
			String	strMax_wait				= "";						
			String	strTime_from			= "";					
			String	strTime_until			= "";
			String	strCalendar_nm			= "";			
			String	strInCondition_tmp		= "";
			String	strInCondition_org		= "";
			String	strInCondition			= "";
			String	strOutCondition_tmp		= "";
			String	strOutCondition			= "";
			String	strOutCondition_org		= "";
			String	strT_resources_q		= "";	
			String	strT_resources_c		= "";	
			String	strT_set				= "";			
			String	strT_steps				= "";		
			String	strT_postproc			= "";
			String	strIn_odate				= "";
			String	strOut_odate			= "";
			String	strIn_sign				= "";
			String	strOut_sign				= "";			
			String strLate_sub 			  ="";
			String strLate_time  		  ="";
			String strLate_exec  		  ="";
			String strSrNo  			  ="";
			String strChargePmNm  		  ="";
			String strProjectManMonth 	  ="";
			String strProjectNm  		  ="";
			String strSrNonAttachedReason ="";
			String strBatchjobGrade  	 ="";
			String strError_description  ="";
			String strUser_cd_2  		 ="";
			String strUser_cd_3  		 ="";
			String strUser_cd_4  		 ="";
			String strGlobalcond_yn  	 ="";
			String strOnline_impect_yn   ="";
			String strUser_impect_yn     ="";
			String strConcerned  		 ="";
			String strUpdate_detail 	 ="";
			String strData_destination 	 ="";
			String strEnd_user	  		 ="";
			String strMoneybatchjob 	 ="";
			String strSystemGb			 = "";			
			String strMonitor_time		= "";
			String strMonitor_interval	= "";
			String strUserNm			= "";
			String strCreationTime		= "";
			
			PopupDefJobDetailService s = (PopupDefJobDetailService)ContextLoader.getCurrentWebApplicationContext().getBean("mPopupDefJobDetailService");
			
			fw = new FileWriter(file_nm, false);
			bw = new BufferedWriter(fw);
			
			str += "순번★시스템구분★작업유형구분★작업주기구분★애플리케이션★그룹명★대그룹★소그룹★작업명★작업설명★실행쉘경로★실행쉘이름★Argument★담당자(사번)★담당자(이름)★";
			str += "실행계정명★작업타입★서버명★우선순위★critical★cyclic★rerun_interval★rerun_max★count_cyclic_from★실행명령어★모니터링시간★";
			str += "모니터링주기★confirm_falg★시작시간★종료시간★캘린더명★선행작업조건★후행작업조건★t_steps★시작한계시간★종료한계시간★";
			str += "수행한계시간★SR번호★담당PM★프로젝트공수★프로젝트명★SR미첨부사유★배치작업등급★As-Is작업명★담당자2★담당자3★담당자4★";
			//str += "글로벌컨디션발행여부★목표복구시간★온라인배치영향도★대고객영향도★점검사항★수정내역요약★Data수신처★End_User★작업소요시간★금전성재치여부";
			str += "글로벌컨디션발행여부★목표복구시간★온라인배치영향도★대고객영향도★점검사항★수정내역요약★타겟테이블(SAM파일)★End_User★작업소요시간★금전성재치여부★등록일";
			
			bw.write(str);
			str = "";
			for(int i=0;i<defJobList.size();i++){	
								
				Map<String, Object> m = new HashMap();
				m.put("job_name",defJobList.get(i).getJob_name());
				//m.put("table_id",defJobList.get(i).getTable_id());
				//m.put("job_id",defJobList.get(i).getJob_id());
				m.put("SCHEMA", CommonUtil.getMessage("DB.SCHEMA."+CommonUtil.getMessage("DB_GUBUN")+"."+CommonUtil.getMessage("SERVER_GB")));
				
				try{
					
					JobDefineInfoBean bean = s.dGetJobDefineInfo(m);
					
					strApplication			= CommonUtil.E2K(CommonUtil.isNull(bean.getApplication()));
					strGroup_name			= CommonUtil.E2K(CommonUtil.isNull(bean.getGroup_name()));	
					strJob_name				= CommonUtil.E2K(CommonUtil.isNull(bean.getJob_name()));		
					strDescription			= CommonUtil.E2K(CommonUtil.isNull(bean.getDescription()));	
					strMem_name				= CommonUtil.E2K(CommonUtil.isNull(bean.getMem_name()));	
					strMem_lib				= CommonUtil.E2K(CommonUtil.isNull(bean.getMem_lib()));	
					strAuthor				= CommonUtil.E2K(CommonUtil.isNull(bean.getAuthor()));		
					strOwner				= CommonUtil.E2K(CommonUtil.isNull(bean.getOwner()));		
					strTask_type			= CommonUtil.isNull(bean.getTask_type());		
					strNode_id				= CommonUtil.E2K(CommonUtil.isNull(bean.getNode_id()));	
					strPriority				= CommonUtil.isNull(bean.getPriority());      				
					strCritical				= CommonUtil.isNull(bean.getCritical());						
					strCyclic				= CommonUtil.isNull(bean.getCyclic());			
					strRerun_interval		= CommonUtil.isNull(bean.getRerun_interval());	
					strRerun_max			= CommonUtil.isNull(bean.getRerun_max());						
					strCount_cyclic_from_org	= CommonUtil.isNull(bean.getCount_cyclic_from());
					strT_resources_q 			= CommonUtil.isNull(bean.getT_resources_q());
					strT_resources_c 			= CommonUtil.isNull(bean.getT_resources_c());
					strT_set					= CommonUtil.isNull(bean.getT_set());
					strT_steps					= CommonUtil.isNull(bean.getT_steps());
					strT_postproc				= CommonUtil.isNull(bean.getT_postproc());					
								
					if ( strT_set.indexOf("FileWatch-INT_FILE_SEARCHES") > -1 ) { 
						strMonitor_interval = strT_set.substring(strT_set.indexOf("FileWatch-INT_FILE_SEARCHES,")+28, strT_set.indexOf("|FileWatch-INT_FILESIZE_COMPARISON,"));
					}
					if ( strT_set.indexOf("FileWatch-TIME_LIMIT") > -1 ) { 
						strMonitor_time = strT_set.substring(strT_set.indexOf("FileWatch-TIME_LIMIT,")+21, strT_set.indexOf("|FileWatch-START_TIME,"));
					}
									
					DefJobBean bean2 = (DefJobBean)defJobList.get(i);
					
					strIn_odate 				= CommonUtil.isNull(bean2.getIn_strOdate());
					strOut_odate 				= CommonUtil.isNull(bean2.getOut_strOdate());
					strIn_sign 					= CommonUtil.isNull(bean2.getIn_sign());
					strOut_sign 				= CommonUtil.isNull(bean2.getOut_sign());			
				
					if("E".equals(strCount_cyclic_from_org)){
						strCount_cyclic_from = "end";
					}else if("S".equals(strCount_cyclic_from_org)){
						strCount_cyclic_from = " ";
		
					}else{
						strCount_cyclic_from = " ";
					}
					
					
					if("+".equals(strOut_sign)){
						strOut_sign = "add";
					}else if("-".equals(strOut_sign)){
						strOut_sign = "del";
					}else{
						strOut_sign = "";
					}
					
					if("A".equals(strIn_sign)){
						strIn_sign = "and";
					}else if("O".equals(strIn_sign)){
						strIn_sign = "or";
					}else{
						strIn_sign = "";
					}
					strCommand				= CommonUtil.E2K(CommonUtil.isNull(bean2.getCmd_line()));		
					strConfirm_flag_org		= CommonUtil.E2K(CommonUtil.isNull(bean.getConfirm_flag()));
					if("Y".equals(strConfirm_flag_org)){
						strConfirm_flag		= "1";	
		
					}else{
						strConfirm_flag		= "0";
					}
					strConfirm_flag_org		= CommonUtil.E2K(CommonUtil.isNull(bean.getConfirm_flag()));	
					strMax_wait				= CommonUtil.E2K(CommonUtil.isNull(bean.getMax_wait()));						
					strTime_from			= CommonUtil.E2K(CommonUtil.isNull(bean2.getFrom_time()));				
					strTime_until			= CommonUtil.E2K(CommonUtil.isNull(bean2.getTo_time()));
					strInCondition_tmp	= CommonUtil.E2K(CommonUtil.isNull(bean2.getIn_condition()));
					strInCondition_org	= strInCondition_tmp.replace(",",",ODAT,and|");
					if("".equals(strInCondition_org)){
						strInCondition	    = "";
					}else{
						strInCondition	    = strInCondition_org+",ODAT,and";
					}
					
					strOutCondition_tmp = CommonUtil.E2K(CommonUtil.isNull(bean2.getOut_condition()));
					strOutCondition_org	= strOutCondition_tmp.replace(",",",ODAT,add|");
					if("".equals(strOutCondition_org)){
						strOutCondition	    = "";
					}else{
						strOutCondition	= strOutCondition_org+",ODAT,add";
					}
					
					
					strLate_sub 		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getLate_sub()));
					strLate_time  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getLate_time()));
					strLate_exec  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getLate_exec()));
					strSrNo  			   = CommonUtil.E2K(CommonUtil.isNull(bean2.getSrNo()));
					strChargePmNm  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getChargePmNm()));
					strProjectManMonth 	   = CommonUtil.E2K(CommonUtil.isNull(bean2.getProjectManMonth()));
					strProjectNm  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getProjectNm()));
					strSrNonAttachedReason = CommonUtil.E2K(CommonUtil.isNull(bean2.getSrNonAttachedReason()));
					strBatchjobGrade  	   = CommonUtil.E2K(CommonUtil.isNull(bean2.getBatchjobGrade()));
					strError_description   = CommonUtil.E2K(CommonUtil.isNull(bean2.getError_description()));
					strUser_cd_2  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_2()));
					strUser_cd_3  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_3()));
					strUser_cd_4  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_cd_4()));
					strGlobalcond_yn  	   = CommonUtil.E2K(CommonUtil.isNull(bean2.getGlobalcond_yn()));
					strUserNm				= CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_nm()));
					strCreationTime			= CommonUtil.E2K(CommonUtil.isNull(bean2.getCreation_time()));
					
					if ( !strCreationTime.equals("") ) {
						strCreationTime = CommonUtil.getDateFormat(1, strCreationTime);
					}
					
					if("0".equals(strGlobalcond_yn)){
						strGlobalcond_yn		= "N";	
		
					}else{
						strGlobalcond_yn		= "Y";
					}
					strOnline_impect_yn    = CommonUtil.E2K(CommonUtil.isNull(bean2.getOnline_impect_yn()));
					
					if("0".equals(strOnline_impect_yn)){
						strOnline_impect_yn		= "N";	
		
					}else{
						strOnline_impect_yn		= "Y";
					}
					strUser_impect_yn      = CommonUtil.E2K(CommonUtil.isNull(bean2.getUser_impect_yn()));
					
					if("0".equals(strUser_impect_yn)){
						strUser_impect_yn		= "N";	
		
					}else{
						strUser_impect_yn		= "Y";
					}
					strConcerned  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getConcerned()));
					strUpdate_detail 	   = CommonUtil.E2K(CommonUtil.isNull(bean2.getUpdate_detail()));
					strEnd_user	  		   = CommonUtil.E2K(CommonUtil.isNull(bean2.getEnd_user()));
					strData_destination    = CommonUtil.E2K(CommonUtil.isNull(bean2.getData_destination()));
					strMoneybatchjob 	   = CommonUtil.E2K(CommonUtil.isNull(bean2.getMoneybatchjob()));
					strCalendar_nm 	  		= CommonUtil.E2K(CommonUtil.isNull(bean2.getCalendar_nm()));
					strArgument				= CommonUtil.E2K(CommonUtil.isNull(bean2.getArgument()));		
					strJobTypeGb			= CommonUtil.E2K(CommonUtil.isNull(bean2.getJobTypeGb()));		
					strJobSchedGb			= CommonUtil.E2K(CommonUtil.isNull(bean2.getJobSchedGb()));		
					strMcode_nm				= CommonUtil.E2K(CommonUtil.isNull(bean2.getMcode_nm()));			
					strScode_nm				= CommonUtil.E2K(CommonUtil.isNull(bean2.getScode_nm()));	
					strSystemGb				= CommonUtil.E2K(CommonUtil.isNull(bean2.getSystemGb()));
					strArgument				= CommonUtil.E2K(CommonUtil.isNull(bean2.getArgument()));
				}catch(Exception e){
					e.getMessage();
				}
				
				
				str += (i+1)+"★";
				str += strSystemGb+"★";
				str += strJobTypeGb+"★";
				str += strJobSchedGb+"★";
				str += strApplication+"★";
				str += strGroup_name+"★";
				str += strMcode_nm+"★";
				str += strScode_nm+"★";
				str += strJob_name+"★";
				str += strDescription+"★";
				str += strMem_lib+"★";
				str += strMem_name+"★";
				str += strArgument+"★";
				str += strAuthor+"★";
				str += strUserNm+"★";
				str += strOwner+"★";
				str += strTask_type+"★";
				str += strNode_id+"★";
				str += strPriority+"★";
				str += strCritical+"★";
				str += strCyclic+"★";
				str += strRerun_interval+"★";
				str += strRerun_max+"★";
				str += strCount_cyclic_from+"★";
				str += strCommand+"★";
				str += strMonitor_time+"★";
				str += strMonitor_interval+"★";
				str += strConfirm_flag+"★";
				str += strTime_from+"★";
				str += strTime_until+"★";
				str += strCalendar_nm+"★";
				str += strInCondition+"★";
				str += strOutCondition+"★";
				str += strT_steps+"★";
				str += strLate_sub+"★";
				str += strLate_time+"★";
				str += strLate_exec+"★";
				str += strSrNo+"★";
				str += strChargePmNm+"★";
				str += strProjectManMonth+"★";
				str += strProjectNm+"★";
				str += strSrNonAttachedReason+"★";
				str += strBatchjobGrade+"★";
				str += strError_description+"★";
				str += strUser_cd_2+"★";
				str += strUser_cd_3+"★";
				str += strUser_cd_4+"★";
				str += strGlobalcond_yn+"★";
				str += strOnline_impect_yn+"★";
				str += strUser_impect_yn+"★";
				str += strConcerned+"★";
				str += strUpdate_detail+"★";
				str += strData_destination+"★";
				str += strEnd_user+"★";
				str += strMoneybatchjob+"★";
				str += strCreationTime;
						
				bw.newLine();
				bw.write(str);
				str = "";				
			}
			
			bw.close();
				
			
		}catch(Exception e){
			e.getMessage();
		}finally{
			try{ if(fw != null) fw.close(); } catch(Exception e){}
			try{ if(bw != null) bw.close(); } catch(Exception e){}
		}
	}
	
	public static void jobLogListWrite(String file_nm, List<JobLogBean> jobLogList, Map<String, Object> paramMap){
		
		FileWriter fw = null;
		BufferedWriter bw = null;
		String str = "";
		
		try{
			
			fw = new FileWriter(file_nm, false);
			bw = new BufferedWriter(fw);
			
			str += "순번★ODATE★시작일시★종료일시★수행시간★평균수행시간★실행횟수★작업명★작업설명★수행서버★상태★FROM_TIME";
			bw.write(str);
			
			String data_center 	= CommonUtil.isNull(paramMap.get("data_center"));
			boolean bMf = false;
			String aMf[] = CommonUtil.isNull(CommonUtil.getMessage("MF_LIST")).split(",");
			for( int i=0; aMf!=null && i<aMf.length; i++){
				if( data_center.equals(aMf[i]) ) bMf = true;
			}
			
			str = "";
			for(int i=0;i<jobLogList.size();i++){	
				
				JobLogBean bean = (JobLogBean)jobLogList.get(i);
				
				int rerun_counter = Integer.parseInt(CommonUtil.isNull(bean.getRerun_counter(),"0"));
				if(bMf && !"".equals(CommonUtil.isNull(bean.getStart_time()).trim())) rerun_counter++;
				
				String strFromTime = CommonUtil.isNull(bean.getFrom_time());
				
				if ( !strFromTime.equals("") ) {
					strFromTime = strFromTime.substring(0, 2) + ":" + strFromTime.substring(2, 4);
				}
				
				String strAvgRunTimeHHMISS = "";
				String strAvgRunTime = CommonUtil.isNull(bean.getAvg_run_time());
				
				if ( !strAvgRunTime.equals("") ) {
					strAvgRunTimeHHMISS = CommonUtil.getTimeFormat(Integer.parseInt(strAvgRunTime));				
				}
				
				String strStateResult2 	= "";
				String strHoldflag		= CommonUtil.isNull(bean.getHoldflag());
				
				if ( strHoldflag.equals("Y") ) {
					//strStateResult2 	= " [" + CommonUtil.isNull(bean.getState_result2()) + "]";
					strStateResult2 	= " [HOLD]";
				}
				
				String strOdate	= "20" + CommonUtil.isNull(bean.getOdate());
				strOdate		= strOdate.substring(0, 4) + "/" + strOdate.substring(4, 6) + "/" + strOdate.substring(6, 8);
				
				str += (i+1)+"★";
				str += strOdate+"★";
				str += CommonUtil.getDateFormat(1,bean.getStart_time(),"-")+"★";
				str += CommonUtil.getDateFormat(1,bean.getEnd_time(),"")+"★";
				str += CommonUtil.getDiffTime( CommonUtil.getDateFormat(1,bean.getStart_time()),CommonUtil.getDateFormat(1,bean.getEnd_time()))+"★";
				str += strAvgRunTimeHHMISS+"★";
				str += rerun_counter+"★";
				str += CommonUtil.E2K(bean.getJob_name(),bean.getMemname())+"★";
				str += CommonUtil.E2K(bean.getDescription(),"")+"★";
				str += CommonUtil.E2K(bean.getNode_id(),"")+"★";
				str += CommonUtil.getMessage("JOB_STATUS."+CommonUtil.isNull(bean.getState_result()).replaceAll(" ","_")) + strStateResult2+"★";
				str += strFromTime;
								
				bw.newLine();
				bw.write(str);
				str = "";				
			}
			
			bw.close();
			
		}catch(Exception e){
			e.getMessage();
		}finally{
			try{ if(fw != null) fw.close(); } catch(Exception e){}
			try{ if(bw != null) bw.close(); } catch(Exception e){}
		}
	}
	
	public static String readFile(File f) {
		
		InputStream in = null;
		String output = "";
		try {
			in = new FileInputStream(f);
			BufferedReader br = new BufferedReader(new InputStreamReader(in,"UTF8"));
			
			String line = null;
			while((line = br.readLine())!=null)
			{
				output += (line+"\n");
			}
			
		} catch (Exception e) {
			e.printStackTrace();      
		} finally {
			try {
				if(in!=null){in.close();in=null;};
			} catch(Exception e) {} 
		}
		return output;
	}
}