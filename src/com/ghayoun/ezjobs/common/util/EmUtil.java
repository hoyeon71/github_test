package com.ghayoun.ezjobs.common.util;

import java.io.*;
import java.net.URLDecoder;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.ghayoun.ezjobs.t.domain.Doc01Bean;

public class EmUtil {

	protected final Log logger = LogFactory.getLog(getClass());
	
	

	// 작업 상태변환.
	public String updateAjf(String type, String order_id, Map map) throws Exception {

		String sType		= type;
		String sOrder_id 	= order_id;
		String sData_center = CommonUtil.isNull(map.get("data_center"));

		StringBuffer sb = new StringBuffer();

		try {

			sb.append("ctmpsm -UPDATEAJF ");
			sb.append(sOrder_id + " " + sType);

			logger.debug("Command : " + sb.toString());

			logger.info("updateFileCopy Start.");

			updateFileCopy(sb.toString(), sData_center);

			logger.info("updateAjf End.");

			return sType;

		} catch (Exception e) {
			logger.error("updateAjf Error.");
			logger.error(e.getMessage());
			return "";
		}
	}

	// 로컬에 작업 상태변환 파일 생성.
	private void updateFileCopy(String command, String data_center) {

		String sCommand 	= command;
		String sData_center = data_center;

		String sTempPath 	= "";
		String sFileName	= "";
		String sRealPath 	= "";
		
		try {

			char input[] = new char[sCommand.length()];
			sCommand.getChars(0, sCommand.length(), input, 0);

			sRealPath 		= URLDecoder.decode(getClass().getResource("/").getPath());
			String[] values = sRealPath.split("/");
			
			for ( int i = 0; i < values.length-1; i++) {				
				sTempPath += values[i] + "/";
			}
			
			sFileName = "CON_" + CommonUtil.getCurDate("YMDHM") + ".txt";
			
			// 해당폴더가 없으면 폴더를 생성한다.
			sTempPath = sTempPath + "files/EZ_DATA/" + CommonUtil.getCurDate("YMD") + "/";
			File folderTemp = new File(sTempPath);
			if (!folderTemp.exists()) folderTemp.mkdirs();
			
			sRealPath = sTempPath + sFileName;
			
			logger.debug("sRealPath : " + sRealPath);
			
			FileWriter fw = new FileWriter(sRealPath);
			fw.write(input);
			fw.close();
			
			// .bak 파일을 만들기 위해서.
			FileWriter bak_fw = new FileWriter(sRealPath.replace("txt", "bak"));
			bak_fw.write("");
			bak_fw.close();

			logger.info("updateFileCopy End!");

			logger.info("fileFtp Start.");			

			fileFtp(sRealPath, sData_center);
			
			// .bak 파일을 전송하기 위해서.
			fileFtp(sRealPath.replace("txt", "bak"), sData_center);
			
			logger.info("fileFtp End.");
		}

		catch (Exception e) {			
			logger.error("updateFileCopy Error.");
			logger.error(e.getMessage());
		}

	}

	// 로컬 파일을 Control-M 서버에 FTP로 전송.
	private void fileFtp(String real_path, String data_center) {

		String sReal_path = real_path;

		String sData_center = data_center;

		File f 		= new File(sReal_path);

		try {

			String host = CommonUtil.isNull(CommonUtil.getMessage("CM.FTP." + sData_center.toUpperCase() + ".HOST"));
			int port 	= Integer.parseInt(CommonUtil.isNull(CommonUtil.getMessage("CM.FTP." + sData_center.toUpperCase() + ".PORT"), "21"));
			String user = CommonUtil.isNull(CommonUtil.getMessage("CM.FTP." + sData_center.toUpperCase() + ".USER"));
			String pw 	= CommonUtil.isNull(CommonUtil.getMessage("CM.FTP." + sData_center.toUpperCase() + ".PW"));

			if (!"".equals(host)) {

				if ("FTP".equals(CommonUtil.isNull(CommonUtil.getMessage("CM.FTP." + sData_center.toUpperCase() + ".GB")))) {

					try {

						FtpUtil fu = new FtpUtil();

						if (fu.connect(host, port)) {

							if (fu.login(user, pw, true)) {

								logger.info("FTP Login Success!");

								fu.upFile("EZJOBS/EZ_DATA", f);
								
							} else {
								logger.error("fileFtp Login Error.");
								throw new Exception();
							}

						} else {
							logger.error("fileFtp Connect Error.");							
							throw new Exception();
						}

						fu.disconnect();
						
					} catch (Exception e) {
						logger.error("fileFtp Properties Error.");		
						logger.error(e.getMessage());
					}
				}
			}
		}

		catch (Exception e) {
			logger.error("fileFtp Error.");
			logger.error(e.getMessage());
		}
	}

	// 작업 등록.
	public String createAjf(Map map) {		
		
		Doc01Bean docBean = null;
		
		docBean					= (Doc01Bean)map.get("doc01");
		
		String sData_center 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getData_center()));
		String sJob_name	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getJob_name()));
		String sTask_type	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getTask_type()));
		String sUser_daily	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getUser_daily()));
		String sDescription 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getDescription()));
		String sOwner		 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getOwner()));
		String sTable_name	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getTable_name()));
		String sAuthor		 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getAuthor()));
		String sApplication			= CommonUtil.E2K(CommonUtil.isNull(docBean.getApplication()));
		String sMem_name	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getMem_name()));
		String sGroup_name	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getGroup_name()));
		String sMem_lib		 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getMem_lib()));
		String sCommand		 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getCommand()));
		
		String sMonth_days			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_days()));
		String sDays_cal			= CommonUtil.E2K(CommonUtil.isNull(docBean.getDays_cal()));
		String sSchedule_and_or		= CommonUtil.E2K(CommonUtil.isNull(docBean.getSchedule_and_or()));
		String sWeek_days			= CommonUtil.E2K(CommonUtil.isNull(docBean.getWeek_days()));
		String sWeeks_cal	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getWeeks_cal()));
		String sMonth_1	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_1()));
		String sMonth_2	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_2()));
		String sMonth_3	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_3()));
		String sMonth_4	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_4()));
		String sMonth_5	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_5()));
		String sMonth_6	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_6()));
		String sMonth_7	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_7()));
		String sMonth_8	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_8()));
		String sMonth_9	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_9()));
		String sMonth_10	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_10()));
		String sMonth_11	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_11()));
		String sMonth_12	 		= CommonUtil.E2K(CommonUtil.isNull(docBean.getMonth_12()));
		String sRetro	 			= CommonUtil.E2K(CommonUtil.isNull(docBean.getRetro()));
		String sT_general_date		= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_general_date()));
		
		String sNode_id				= CommonUtil.E2K(CommonUtil.isNull(docBean.getNode_id()));
		String sPriority			= CommonUtil.E2K(CommonUtil.isNull(docBean.getPriority()));
		String sMultiagent			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMultiagent()));
		String sConfirm_flag		= CommonUtil.E2K(CommonUtil.isNull(docBean.getConfirm_flag()));
		String sCritical			= CommonUtil.E2K(CommonUtil.isNull(docBean.getCritical()));
		String sTime_from			= CommonUtil.E2K(CommonUtil.isNull(docBean.getTime_from()));
		String sTime_zone			= CommonUtil.E2K(CommonUtil.isNull(docBean.getTime_zone()));
		String sCyclic				= CommonUtil.E2K(CommonUtil.isNull(docBean.getCyclic()));
		String sRerun_interval		= CommonUtil.E2K(CommonUtil.isNull(docBean.getRerun_interval()));
		String sRerun_interval_time	= CommonUtil.E2K(CommonUtil.isNull(docBean.getRerun_interval_time()));
		String sCount_cyclic_from	= CommonUtil.E2K(CommonUtil.isNull(docBean.getCount_cyclic_from()));
		String sRerun_max			= CommonUtil.E2K(CommonUtil.isNull(docBean.getRerun_max()));
		String sMax_wait			= CommonUtil.E2K(CommonUtil.isNull(docBean.getMax_wait()));
		
		String sT_conditions_in		= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_conditions_in()));
		String sT_conditions_out	= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_conditions_out()));
		
		String sT_resources_q		= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_resources_q()));
		String sT_resources_c		= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_resources_c()));
		
		String sT_set				= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_set()));
		
		String sT_steps				= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_steps()));
		
		String sT_postproc			= CommonUtil.E2K(CommonUtil.isNull(docBean.getT_postproc()));
		
		StringBuffer sb = new StringBuffer();

		try {
			
			sTask_type 			= sTask_type.toUpperCase();
			
			if ( sSchedule_and_or.equals("0") ) {
				sSchedule_and_or = "OR";
			} else if ( sSchedule_and_or.equals("1") ) {
				sSchedule_and_or = "AND";
			}
			
			if ( sMonth_1.equals("0") ) {
				sMonth_1 = "'JAN' 'N'";
			} else if ( sMonth_1.equals("1") ) {
				sMonth_1 = "'JAN' 'Y'";
			}
			
			if ( sMonth_2.equals("0") ) {
				sMonth_2 = "'FEB' 'N'";
			} else if ( sMonth_2.equals("1") ) {
				sMonth_2 = "'FEB' 'Y'";
			}
			
			if ( sMonth_3.equals("0") ) {
				sMonth_3 = "'MAR' 'N'";
			} else if ( sMonth_3.equals("1") ) {
				sMonth_3 = "'MAR' 'Y'";
			}
			
			if ( sMonth_4.equals("0") ) {
				sMonth_4 = "'APR' 'N'";
			} else if ( sMonth_4.equals("1") ) {
				sMonth_4 = "'APR' 'Y'";
			}
			
			if ( sMonth_5.equals("0") ) {
				sMonth_5 = "'MAY' 'N'";
			} else if ( sMonth_5.equals("1") ) {
				sMonth_5 = "'MAY' 'Y'";
			}
			
			if ( sMonth_6.equals("0") ) {
				sMonth_6 = "'JUN' 'N'";
			} else if ( sMonth_6.equals("1") ) {
				sMonth_6 = "'JUN' 'Y'";
			}
			
			if ( sMonth_7.equals("0") ) {
				sMonth_7 = "'JUL' 'N'";
			} else if ( sMonth_7.equals("1") ) {
				sMonth_7 = "'JUL' 'Y'";
			}
			
			if ( sMonth_8.equals("0") ) {
				sMonth_8 = "'AUG' 'N'";
			} else if ( sMonth_8.equals("1") ) {
				sMonth_8 = "'AUG' 'Y'";
			}
			
			if ( sMonth_9.equals("0") ) {
				sMonth_9 = "'SEP' 'N'";
			} else if ( sMonth_9.equals("1") ) {
				sMonth_9 = "'SEP' 'Y'";
			}
			
			if ( sMonth_10.equals("0") ) {
				sMonth_10 = "'OCT' 'N'";
			} else if ( sMonth_10.equals("1") ) {
				sMonth_10 = "'OCT' 'Y'";
			}
			
			if ( sMonth_11.equals("0") ) {
				sMonth_11 = "'NOV' 'N'";
			} else if ( sMonth_11.equals("1") ) {
				sMonth_11 = "'NOV' 'Y'";
			}
			
			if ( sMonth_12.equals("0") ) {
				sMonth_12 = "'DEC' 'N'";
			} else if ( sMonth_12.equals("1") ) {
				sMonth_12 = "'DEC' 'Y'";
			}
			
			if ( sRetro.equals("0") ) {
				sRetro = "N";
			} else if ( sRetro.equals("1") ) {
				sRetro = "Y";
			}
			
			if ( sMultiagent.equals("0") ) {
				sMultiagent = "N";
			} else if ( sMultiagent.equals("1") ) {
				sMultiagent = "Y";
			}
			
			if ( sConfirm_flag.equals("0") ) {
				sConfirm_flag = "N";
			} else if ( sConfirm_flag.equals("1") ) {
				sConfirm_flag = "Y";
			}
			
			if ( sCritical.equals("0") ) {
				sCritical = "N";
			} else if ( sCritical.equals("1") ) {
				sCritical = "Y";
			}
			
			if ( sCyclic.equals("0") ) {
				sCyclic = "N";
			} else if ( sCyclic.equals("1") ) {
				sCyclic = "Y";
			}
			
			sCount_cyclic_from 			= sCount_cyclic_from.toUpperCase();			

			sb.append("ctmdefine" + "\\" + "\n");
			
			logger.info("General Start.");			
			// 기본정보 셋팅 시작
			if ( !sJob_name.equals("") ) {
				sb.append("\t -JOBNAME \t" 			+ "'" + sJob_name + "' \\"			+ "\n");	// 작업명
			}
			if ( !sTask_type.equals("") ) {
				sb.append("\t -TASKTYPE \t" 		+ "'" + sTask_type + "' \\" 		+ "\n");	// 작업타입
			}
			if ( !sDescription.equals("") ) {
				sb.append("\t -DESCRIPTION \t" 		+ "'" + sDescription + "' \\" 		+ "\n");	// 설명
			}
			if ( !sOwner.equals("") ) {
				sb.append("\t -OWNER \t" 			+ "'" + sOwner + "' \\"			+ "\n");	// 계정명
			}
			if ( !sTable_name.equals("") ) {
				sb.append("\t -TABLE \t" 			+ "'" + sTable_name + "' \\"		+ "\n");	// 스케줄테이블
			}
			if ( !sAuthor.equals("") ) {
				sb.append("\t -AUTHOR \t" 			+ "'" + sAuthor + "' \\"			+ "\n");	// 담당자
			}
			if ( !sApplication.equals("") ) {
				sb.append("\t -APPLICATION \t" 		+ "'" + sApplication + "' \\"		+ "\n");	// 어플리케이션
			}
			if ( !sMem_name.equals("") ) {
				sb.append("\t -MEMNAME \t" 			+ "'" + sMem_name + "' \\"			+ "\n");	// 파일이름
			}
			if ( !sGroup_name.equals("") ) {
				sb.append("\t -GROUP \t" 			+ "'" + sGroup_name + "' \\"		+ "\n");	// 그룹
			}
			if ( !sMem_lib.equals("") ) {
				sb.append("\t -MEMLIB \t" 			+ "'" + sMem_lib + "' \\"			+ "\n");	// 파일경로
			}			
			if ( !sTask_type.equals("JOB") ) {
				if ( !sCommand.equals("") ) {
					sb.append("\t -CMDLINE \t" 			+ "'" + sCommand + "'"			+ "\n");	// 실행명령어
				}
				
			}			
			// 기본정보 셋팅 끝				
			logger.info("General End.");
			
			logger.info("Scheduling Start.");			
			// 작업스케줄 셋팅 시작
			if ( !sMonth_days.equals("") ) {
				sb.append("\t -DAYS \t" 			+ "'" + sMonth_days + "' \\" 		+ "\n");	// 실행날짜
			}
			if ( !sDays_cal.equals("") ) {
				sb.append("\t -DAYSCAL \t" 			+ "'" + sDays_cal + "' \\" 		+ "\n");	// 월 캘린더
			}
			if ( !sSchedule_and_or.equals("") ) {
				sb.append("\t -CAL_ANDOR \t" 		+ "'" + sSchedule_and_or + "' \\" 	+ "\n");	// 조건
			}
			if ( !sWeek_days.equals("") ) {
				sb.append("\t -WEEKDAYS \t" 		+ "'" + sWeek_days + "' \\" 		+ "\n");	// 실행요일
			}
			if ( !sWeeks_cal.equals("") ) {
				sb.append("\t -WEEKCAL \t" 			+ "'" + sWeeks_cal + "' \\" 		+ "\n");	// 일 캘린더
			}
			if ( !sMonth_1.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_1 + " \\" 			+ "\n");	// JAN
			}
			if ( !sMonth_2.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_2 + " \\" 			+ "\n");	// FEB
			}
			if ( !sMonth_3.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_3 + " \\" 			+ "\n");	// MAR
			}
			if ( !sMonth_4.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_4 + " \\" 			+ "\n");	// APR
			}
			if ( !sMonth_5.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_5 + " \\" 			+ "\n");	// MAY
			}
			if ( !sMonth_6.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_6 + " \\" 			+ "\n");	// JUN
			}
			if ( !sMonth_7.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_7 + " \\" 			+ "\n");	// JUL
			}
			if ( !sMonth_8.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_8 + " \\" 			+ "\n");	// AUG
			}
			if ( !sMonth_9.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_9 + " \\" 			+ "\n");	// SEP
			}
			if ( !sMonth_10.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_10 + " \\" 		+ "\n");	// OCT
			}
			if ( !sMonth_11.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_11 + " \\" 		+ "\n");	// NOV
			}
			if ( !sMonth_12.equals("") ) {
				sb.append("\t -MONTH \t" 			+ sMonth_12 + " \\" 		+ "\n");	// DEC
			}
			if ( !sT_general_date.equals("") ) {
				sb.append("\t -DATE \t" 			+ "'" + sT_general_date + "' \\" 	+ "\n");	// 특정실행날짜		
			}
			// 작업스케줄 셋팅 끝			
			logger.info("Scheduling End.");
			
			logger.info("Execution Start.");			
			// 작업실행형태 셋팅 시작
			if ( !sNode_id.equals("") ) {
				sb.append("\t -NODEGRP \t" 			+ "'" + sNode_id + "' \\" 				+ "\n");	// Node ID/Group
			}			
			if ( !sPriority.equals("") ) {
				sb.append("\t -PRIORITY \t" 		+ "'" + sPriority + "' \\" 			+ "\n");	// priority
			}			
			if ( !sConfirm_flag.equals("") ) {
				sb.append("\t -CONFIRM \t" 			+ "'" + sConfirm_flag + "' \\" 		+ "\n");	// Wait for Confirm
			}
			if ( !sTime_from.equals("") ) {
				sb.append("\t -TIMEFROM \t" 		+ "'" + sTime_from + "' \\" 			+ "\n");	// Submit between			
			}
			if ( !sCyclic.equals("") ) {
				sb.append("\t -CYCLIC \t" 			+ "'" + sCyclic + "' \\" 				+ "\n");	// Cyclic Job
			}
			if ( !sRerun_interval.equals("") ) {
				sb.append("\t -INTERVAL \t" 		+ "'" + sRerun_interval + sRerun_interval_time + "' \\" + "\n");	// Rerun every + Time Setting
			}
			if ( !sCount_cyclic_from.equals("") ) {
				sb.append("\t -INTERVALFROM \t" 	+ "'" + sCount_cyclic_from + "' \\" 	+ "\n");	// from job's
			}
			if ( !sRerun_max.equals("") ) {
				sb.append("\t -MAXRERUN \t" 		+ "'" + sRerun_max + "' \\" 			+ "\n");	// Maximum Reruns
			}
			if ( !sMax_wait.equals("") ) {
				sb.append("\t -MAXWAIT \t" 			+ "'" + sMax_wait + "' \\" 			+ "\n");	// Max Wait		
			}				
			// 작업실행형태 셋팅 끝
			logger.info("Execution End.");			
			
			logger.info("Conditions In Condition Start.");		
			// Condition In Condition 셋팅 시작
			if ( !sT_conditions_in.equals("") ) {			
			
				String sT_conditions_in_arr[] = sT_conditions_in.split("[|]");			
				for (int i = 0; i < sT_conditions_in_arr.length; i++) {
					
					String sT_conditions_in_arr_1[] = sT_conditions_in_arr[i].split("[,]");
					String sInTotal = "";
					for (int j = 0; j < sT_conditions_in_arr_1.length; j++) {
						
						if ( j == 2 ) {
							
							if ( sT_conditions_in_arr_1[j].equals("and") ) {
								sT_conditions_in_arr_1[j] = "AND";
							} else if ( sT_conditions_in_arr_1[j].equals("or") ) { 
								sT_conditions_in_arr_1[j] = "OR";
							}
						}
						
						sInTotal += "'" + sT_conditions_in_arr_1[j] + "' ";					
					}
					
					if ( !sT_conditions_in.equals("") ) {
						sb.append("\t -INCOND \t" 		+ sInTotal		+  "\\" + "\n");	// In Condition 		
					}						
				}
			}
			// Condition In Condition 셋팅 끝
			logger.info("Conditions In Condition End.");
			
			logger.info("Conditions Out Condition Start.");	
			// Condition Out Condition 셋팅 시작
			if ( !sT_conditions_out.equals("") ) {		
				String sT_conditions_out_arr[] = sT_conditions_out.split("[|]");			
				for (int i = 0; i < sT_conditions_out_arr.length; i++) {
					
					String sT_conditions_out_arr_1[] = sT_conditions_out_arr[i].split("[,]");
					String sOutTotal = "";
					for (int j = 0; j < sT_conditions_out_arr_1.length; j++) {
						
						if ( j == 2 ) {
							
							if ( sT_conditions_out_arr_1[j].equals("delete") ) {
								sT_conditions_out_arr_1[j] = "DEL";
							} else if ( sT_conditions_out_arr_1[j].equals("add") ) { 
								sT_conditions_out_arr_1[j] = "ADD";
							}
						}
						
						sOutTotal += "'" + sT_conditions_out_arr_1[j] + "' ";					
					}
					
					if ( !sT_conditions_out.equals("") ) {
						sb.append("\t -OUTCOND \t" 		+ sOutTotal		+  "\\" + "\n");	// Out Condition 		
					}				
				}
			}
			// Condition Out Condition 셋팅  끝
			logger.info("Conditions Out Condition End.");

			logger.info("Resources Quantitative resources Start.");
			// Resource Quantitative resources 셋팅 시작
			if ( !sT_resources_q.equals("") ) {	
				String sT_resources_q_arr[] = sT_resources_q.split("[|]");	
				
				for (int i = 0; i < sT_resources_q_arr.length; i++) {
					
					String sT_resources_q_arr_1[] = sT_resources_q_arr[i].split("[,]");
					String sQTotal = "";
					for (int j = 0; j < sT_resources_q_arr_1.length; j++) {
						
						sQTotal += "'" + sT_resources_q_arr_1[j] + "' ";					
					}
					
					if ( !sT_resources_q.equals("") ) {
						sb.append("\t -QUANTITATIVE \t" 		+ sQTotal		+  "\\" + "\n");	// Quantitative resources 		
					}
				}
			}
			// Resource Quantitative resources 셋팅 끝
			logger.info("Resources Quantitative resources End.");
			
			logger.info("Resources Control resources Start.");			
			// Resource Control resources 셋팅 시작
			if ( !sT_resources_c.equals("") ) {	
				String sT_resources_c_arr[] = sT_resources_c.split("[|]");			
				for (int i = 0; i < sT_resources_c_arr.length; i++) {
					
					String sT_resources_c_arr_1[] = sT_resources_c_arr[i].split("[,]");
					String sCTotal = "";
					for (int j = 0; j < sT_resources_c_arr_1.length; j++) {
						
						if ( j == 1 ) {
							if ( sT_resources_c_arr_1[j].equals("exclusive") ) {
								sT_resources_c_arr_1[j] = "E";
							} else if ( sT_resources_c_arr_1[j].equals("shared") ) {
								sT_resources_c_arr_1[j] = "S";
							}
						}
						
						sCTotal += "'" + sT_resources_c_arr_1[j] + "' ";					
					}
					
					if ( !sT_resources_c.equals("") ) {
						sb.append("\t -CONTROL \t" 		+ sCTotal		+  "\\" + "\n");	// Control resources 		
					}				 
				}
			}
			// Resource Control resources 셋팅 끝
			logger.info("Resources Control resources End.");
			
			logger.info("Set Start.");
			// 변수 셋팅 시작
			if ( !sT_set.equals("") ) {	
				String sT_set_arr[] = sT_set.split("[|]");			
				for (int i = 0; i < sT_set_arr.length; i++) {
					
					String sT_set_arr_1[] = sT_set_arr[i].split("[,]");
					String sAutoTotal = "";
					for (int j = 0; j < sT_set_arr_1.length; j++) {
						
						if ( j==0 ) {
							sAutoTotal += "'%%" + sT_set_arr_1[j] + "' ";
						} else {					
							sAutoTotal += "'" + sT_set_arr_1[j] + "' ";
						}
					}
					
					if ( !sT_set.equals("") ) {
						sb.append("\t -AUTOEDIT \t" 		+ sAutoTotal		+  "\\" + "\n");	// 변수 		
					}				 
				}
			}
			// 변수 셋팅 셋팅 끝
			logger.info("Set End.");
			
			logger.info("Steps Start.");
			// Step 셋팅 시작			
			if ( !sT_steps.equals("") ) {	
				String sT_steps_arr[] = sT_steps.split("[|]");			
				for (int i = 0; i < sT_steps_arr.length; i++) {
					
					String sT_steps_arr_1[] = sT_steps_arr[i].split("[,]");		
					
					String sOnDo	= sT_steps_arr_1[0];
					String sTotal	= "";
					
					if ( sOnDo.equals("O") ) {
						for ( int j = 0; j < sT_steps_arr_1.length; j++ ) {
							if ( j != 0 && j != 1 ) {
								sTotal += "'" + sT_steps_arr_1[j] + "' ";
							}
						}
						
						//sTotal = sTotal.substring(0, sTotal.length()-1); 
						
						if ( !sTotal.equals("") ) {
							sb.append("\t -ON \t" 	+ sTotal 	+ " \\" + "\n");	// Step 		
						}							
					}
					
					if ( sOnDo.equals("A") ) {
						for ( int j = 0; j < sT_steps_arr_1.length; j++ ) {
							if ( j != 0 ) {
								
								if ( sT_steps_arr_1[1].equals("OK")) {
									sTotal = " -DOOK";
								} else if ( sT_steps_arr_1[1].equals("NOTOK")) {
									sTotal = " -DONOTOK";
								} else if ( sT_steps_arr_1[1].equals("RERUN")) {
									sTotal = " -DORERUN";
								} else if ( sT_steps_arr_1[1].equals("Sysout")) {
									sTotal = " -DOSYSOUT";									
									sTotal += " '" + sT_steps_arr_1[2].toUpperCase() + "' ";
				
									if ( sT_steps_arr_1.length > 3 ) {
										
										sTotal += " '" + sT_steps_arr_1[3] + "' ";
									}
									
								} else if ( sT_steps_arr_1[1].equals("Stop Cyclic")) {
									sTotal = " -DOSTOPCYCLIC";						
								} else if ( sT_steps_arr_1[1].equals("Shout")) {
									sTotal = " -DOSHOUT";									
									sTotal += " '" + sT_steps_arr_1[2] + "' ";
									
									if ( sT_steps_arr_1[3].equals("regular") ) {
										sT_steps_arr_1[3] = "R"; 
									} else if ( sT_steps_arr_1[3].equals("urgent") ) {
										sT_steps_arr_1[3] = "U";
									} else if ( sT_steps_arr_1[3].equals("very_urgent") ) {
										sT_steps_arr_1[3] = "V";
									}
									
									sTotal += " '" + sT_steps_arr_1[3] + "' ";
									sTotal += " '" + sT_steps_arr_1[4] + "' ";
									
								} else if ( sT_steps_arr_1[j].equals("Condition")) {
									sTotal = " -DOCOND";
									sTotal += " '" + sT_steps_arr_1[2] + "' ";
									sTotal += " '" + sT_steps_arr_1[3] + "' ";
									
									if ( sT_steps_arr_1[4].equals("add") ) {
										sT_steps_arr_1[4] = "ADD"; 
									} else if ( sT_steps_arr_1[4].equals("delete") ) {
										sT_steps_arr_1[4] = "DEL";
									} 
									
									sTotal += " '" + sT_steps_arr_1[4] + "' ";
									
								} else if ( sT_steps_arr_1[1].equals("Set-Var")) {
									sTotal = " -DOAUTOEDIT";		
									sTotal += " '" + sT_steps_arr_1[2] + "' ";
									sTotal += " '" + sT_steps_arr_1[3] + "' ";
								} else if ( sT_steps_arr_1[j].equals("Force-Job")) {
									sTotal = " -DOFORCEJOB";
									sTotal += " '" + sT_steps_arr_1[2] + "' ";
									sTotal += " '" + sT_steps_arr_1[3] + "' ";
									sTotal += " '" + sT_steps_arr_1[4] + "' ";
								} else if ( sT_steps_arr_1[j].equals("Mail")) {
									sTotal = " -DOMAIL";	
									sTotal += " '" + sT_steps_arr_1[2] + "' ";
									sTotal += " '" + sT_steps_arr_1[3] + "' ";
									
									if ( sT_steps_arr_1[5].equals("regular") ) {
										sT_steps_arr_1[5] = "R"; 
									} else if ( sT_steps_arr_1[5].equals("urgent") ) {
										sT_steps_arr_1[5] = "U";
									} else if ( sT_steps_arr_1[5].equals("very_urgent") ) {
										sT_steps_arr_1[5] = "V";
									}
									
									sTotal += " '" + sT_steps_arr_1[5] + "' ";									
									sTotal += " '" + sT_steps_arr_1[4] + "' ";		
									sTotal += " '" + sT_steps_arr_1[6] + "' ";
								}			
							}						
						}
						
						if ( !sTotal.equals("") ) {
							sb.append("\t" 	+ sTotal 	+ " \\" + "\n");	// Step 		
						}								
					}						
				}
			}
			// Step 셋팅 끝		
			logger.info("Steps End.");
			
			logger.info("PostProc Start.");
			// PostProc 셋팅 시작
			if ( !sT_postproc.equals("") ) {	
				String sT_postproc_arr[] = sT_postproc.split("[|]");
				
				for (int i = 0; i < sT_postproc_arr.length; i++) {				
					String sT_postproc_arr_1[] = sT_postproc_arr[i].split("[,]");					
					
					String sWhen	= sT_postproc_arr_1[0];
					String sParm 	= sT_postproc_arr_1[1];
					String sTo 		= sT_postproc_arr_1[2];
					String sUrgency = sT_postproc_arr_1[3];
					String sMessage = sT_postproc_arr_1[4];
					
					if ( sUrgency.equals("regular")) {
						sUrgency = "R";
					} else if ( sUrgency.equals("urgent")) {
						sUrgency = "U";
					} else if ( sUrgency.equals("very_urgent")) {
						sUrgency = "V";
					}
					
					String sTotal	= "";
										
					if ( sWhen.equals("ok")) {
						sTotal = "'OK' '" + sTo + "' '" + sUrgency + "' '" + sMessage + "'";				
					} else if ( sWhen.equals("not_ok")) {
						sTotal = "'NOTOK' '" + sTo + "' '" + sUrgency + "' '" + sMessage + "'";
					} else if ( sWhen.equals("rerun")) {
						sTotal = "'RERUN' '" + sTo + "' '" + sUrgency + "' '" + sMessage + "'";
					} else if ( sWhen.equals("late_submission")) {
						sTotal = "'LATESUB' '" + sTo + "' '" + sUrgency + "' '" + sMessage + "' '" + sParm + "'";
					} else if ( sWhen.equals("late_time")) {
						sTotal = "'LATETIME' '" + sTo + "' '" + sUrgency + "' '" + sMessage + "' '" + sParm + "'";
					} else if ( sWhen.equals("execution_time")) {
						sTotal = "'EXECTIME' '" + sTo + "' '" + sUrgency + "' '" + sMessage + "' '" + sParm + "'";
					}
					
					sb.append("\t -SHOUT \t" 	+ sTotal 	+ " \\" + "\n");	// PostProc
				}
			}
			// PostProc 셋팅 끝	
			logger.info("PostProc End.");

			logger.debug("Command : " + sb.toString());

			logger.info("createFileCopy Start.");

			createFileCopy(sb.toString(), sData_center);

			logger.info("createAjf End.");		
			
			return sData_center;
		}
		
		catch (Exception e) {
			logger.error("createAjf Error.");
			logger.error(e.getMessage());
			return "";
		}
		
		
	}
	
	// 로컬에  작업 등록 파일 생성.
	private void createFileCopy(String command, String data_center) {

		String sCommand 	= command;
		String sData_center = data_center;

		String sTempPath 	= "";
		String sFileName	= "";
		String sRealPath 	= "";
		
		try {

			char input[] = new char[sCommand.length()];
			sCommand.getChars(0, sCommand.length(), input, 0);

			sRealPath 		= URLDecoder.decode(getClass().getResource("/").getPath());
			String[] values = sRealPath.split("/");
			
			for ( int i = 0; i < values.length-1; i++) {				
				sTempPath += values[i] + "/";				
			}
		
			//sFileName = CommonUtil.getCurDate("YMDH") + "_" + sOrder_id + ".txt";
			sFileName = "DEF_" + CommonUtil.getCurDate("YMDHM") + ".txt";
			
			// 해당폴더가 없으면 폴더를 생성한다.
			sTempPath = sTempPath + "files/EZ_DATA/" + CommonUtil.getCurDate("YMD") + "/";
			File folderTemp = new File(sTempPath);
			if (!folderTemp.exists()) folderTemp.mkdirs();
			
			sRealPath = sTempPath + sFileName;
			
			logger.debug("sRealPath : " + sRealPath);
			
			FileWriter fw = new FileWriter(sRealPath);
			fw.write(input);
			fw.close();
			
			// .bak 파일을 만들기 위해서.
			FileWriter bak_fw = new FileWriter(sRealPath.replace("txt", "bak"));
			bak_fw.write("");
			bak_fw.close();
			
			logger.info("fileCopy End!");

			logger.info("fileFtp Start.");			

			fileFtp(sRealPath, sData_center);
			
			// .bak 파일을 전송하기 위해서.
			fileFtp(sRealPath.replace("txt", "bak"), sData_center);
			
			logger.info("fileFtp End.");
		}

		catch (Exception e) {			
			logger.error("fileCopy Error.");
			logger.error(e.getMessage());
		}

	}

	// 작업 삭제.
	public String deleteAjf() {

		return "";
	}
}
