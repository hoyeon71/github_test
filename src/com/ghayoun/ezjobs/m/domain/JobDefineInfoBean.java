package com.ghayoun.ezjobs.m.domain;

import java.io.Serializable;

public class JobDefineInfoBean implements Serializable {
	
	private String order_id           	= "";
	private String table_id           	= "";
	private String job_id               = "";
	private String data_center          = "";
	private String table_name           = "";
	private String application          = "";
	private String group_name           = "";
	private String mem_name             = "";
	private String job_name             = "";
	private String description          = "";
	private String author               = "";
	private String owner                = "";
	private String priority             = "";
	private String critical             = "";
	private String task_type            = "";
	private String cyclic               = "";
	private String node_id              = "";
	private String rerun_interval       = "";
	private String rerun_interval_time  = "";
	private String mem_lib              = "";
	private String command              = "";
	private String confirm_flag         = "";
	private String days_cal             = "";
	private String weeks_cal            = "";
	private String retro                = "";
	private String max_wait             = "";
	private String rerun_max            = "";
	private String time_from            = "";
	private String time_until           = "";
	private String month_days           = "";
	private String week_days            = "";
	private String month_1              = "";
	private String month_2              = "";
	private String month_3              = "";
	private String month_4              = "";
	private String month_5              = "";
	private String month_6              = "";
	private String month_7              = "";
	private String month_8              = "";
	private String month_9              = "";
	private String month_10             = "";
	private String month_11             = "";
	private String month_12             = "";
	private String count_cyclic_from    = "";
	private String time_zone            = "";
	private String multiagent           = "";
	private String user_daily           = "";
	private String schedule_and_or      = "";
	private String in_conditions_opt    = "";
	private String t_general_date 		= "";
	private String t_conditions_in 		= "";
	private String t_conditions_out 	= "";
	private String t_resources_q 		= "";
	private String t_resources_c 		= "";
	private String t_set 				= "";
	private String t_steps 				= "";
	private String t_postproc 			= "";
	private String t_tag_name			= "";
	private String cpu_id				= "";
	
	private String cyclic_type	 		= "";	
	private String interval_sequence	= "";
	private String tolerance			= "";	
	private String specific_times		= "";
	
	private String active_from			= "";
	private String active_till			= "";
	
	private String data_center_name		= "";
	private String odate				= "";
	
	private String author_nm			= "";

	private String late_sub    			= "";
	private String late_time    		= "";
	private String late_exec    		= "";

	private String srNo 	               = "";
	private String chargePmNm 	           = "";
	private String projectManMonth 	       = "";
	private String projectNm 	           = "";
	private String srNonAttachedReason 	   = "";
	private String batchjobGrade 	       = "";
	private String error_description 	   = "";
	private String user_cd_2 	           = "";
	private String user_cd_3 	           = "";
	private String user_cd_4 	           = "";
	private String globalcond_yn 	       = "";
	private String online_impect_yn 	   = "";
	private String user_impect_yn 	       = "";
	private String concerned 	           = "";
	private String update_detail 	       = "";
	private String end_user                = "";
	private String data_destination        = "";
	private String moneybatchjob           = "";
	private String calendar_nm             = "";
	
	private String conf_cal     	        = "";
	private String shift    	    	    = "";
	private String shift_num            	= "";

	private String jobTypeGb           		= "";
	private String jobSchedGb             	= "";

	private String argument     	        = "";
	private String mcode_nm    	    	    = "";
	private String scode_nm            		= "";
	
	private String systemGb             	= "";
	
	private String 	monitor_interval	 	= "";
	private String 	monitor_time		 	= "";
	
	private String ref_table		 		= "";
	private String cc_yn		 			= "";
	private String cc_count		 			= "";
	
	private String success_sms_yn 			= "";
	
	
	private String job			 	= "";
	
	private String user_cd_1		= "";
	private String user_id_1        = "";  
	private String user_nm_1        = "";
	private String user_email_1     = "";
	private String user_hp_1        = "";
	private String user_tel_1       = "";
	private String dept_nm_1        = "";
	private String duty_nm_1        = "";
	private String part_nm_1        = "";
	
	private String user_id_2        = "";
	private String user_nm_2        = "";
	private String user_email_2     = "";
	private String user_hp_2        = "";
	private String user_tel_2       = "";
	private String dept_nm_2        = "";
	private String duty_nm_2        = "";
	private String part_nm_2        = "";
	
	private String user_id_3        = "";
	private String user_nm_3        = "";
	private String user_email_3     = "";
	private String user_hp_3        = "";
	private String user_tel_3       = "";
	private String dept_nm_3        = "";
	private String duty_nm_3        = "";
	private String part_nm_3        = "";
	
	private String user_id_4        = "";
	private String user_nm_4        = "";
	private String user_email_4     = "";
	private String user_hp_4        = "";
	private String user_tel_4       = "";
	private String dept_nm_4        = "";
	private String duty_nm_4        = "";
	private String part_nm_4        = "";

	private String user_cd_5		= "";
	private String user_id_5        = "";
	private String user_nm_5        = "";
	private String user_email_5     = "";
	private String user_hp_5        = "";
	private String user_tel_5       = "";
	private String dept_nm_5        = "";
	private String duty_nm_5        = "";
	private String part_nm_5        = "";
	
	private String user_cd_6		= "";
	private String user_id_6        = "";
	private String user_nm_6        = "";
	private String user_email_6     = "";
	private String user_hp_6        = "";
	private String user_tel_6       = "";
	private String dept_nm_6        = "";
	private String duty_nm_6        = "";
	private String part_nm_6        = "";
	
	private String user_cd_7		= "";
	private String user_id_7        = "";
	private String user_nm_7        = "";
	private String user_email_7     = "";
	private String user_hp_7        = "";
	private String user_tel_7       = "";
	private String dept_nm_7        = "";
	private String duty_nm_7        = "";
	private String part_nm_7        = "";
	
	private String user_cd_8		= "";
	private String user_id_8        = "";
	private String user_nm_8        = "";
	private String user_email_8     = "";
	private String user_hp_8        = "";
	private String user_tel_8       = "";
	private String dept_nm_8        = "";
	private String duty_nm_8        = "";
	private String part_nm_8        = "";
	
	private String user_cd_9		= "";
	private String user_id_9        = "";
	private String user_nm_9        = "";
	private String user_email_9     = "";
	private String user_hp_9        = "";
	private String user_tel_9       = "";
	private String dept_nm_9        = "";
	private String duty_nm_9        = "";
	private String part_nm_9        = "";
	
	private String user_cd_10		= "";
	private String user_id_10        = "";
	private String user_nm_10        = "";
	private String user_email_10     = "";
	private String user_hp_10        = "";
	private String user_tel_10       = "";
	private String dept_nm_10        = "";
	private String duty_nm_10        = "";
	private String part_nm_10        = "";
	
	
	private String ins_date       = "";
	private String ins_user_cd    = "";
	private String ins_user_ip    = "";
	private String udt_date       = "";
	private String udt_user_cd    = "";
	private String udt_user_ip    = "";
	
	
	private String sms_1        		= "";
	private String sms_2        		= "";
	private String sms_3   		     	= "";
	private String sms_4  	      		= "";	
	private String sms_5  	      		= "";	
	private String sms_6  	      		= "";	
	private String sms_7  	      		= "";	
	private String sms_8  	      		= "";	
	private String sms_9  	      		= "";	
	private String sms_10  	      		= "";	
	
	private String error_description_ment    = "";
	private String trans_yn	      		= "";	

	private String send_gubun	     	= "";
	private String mail_1		     	= "";
	private String mail_2	    	 	= "";
	private String mail_3		     	= "";
	private String mail_4		     	= "";
	private String mail_5		     	= "";
	private String mail_6		     	= "";
	private String mail_7		     	= "";
	private String mail_8		     	= "";
	private String mail_9		     	= "";
	private String mail_10		     	= "";
	
	private String batchJobGrade		    = "";
	private String attach_file			    = "";
	
	private String	chargePMNm				= "";
	private String	errfiles				= "";
	private String	CALL_1					= "";
	private String	CALL_2					= "";
	private String	CALL_3					= "";
	private String	CALL_4					= "";
	private String	MSG_1					= "";
	private String	MSG_2					= "";
	private String	MSG_3					= "";
	private String	MSG_4					= "";
	private String susiType            		= "";
	
	private String mcode_nm_ment      		= "";
	
	
	private String doc_gb					= ""; 
	private String doc_cd 					= "";
	private String cmd_line					= "";
	private String memname					= "";
	private String creation_date			= "";
	private String from_time				= "";
	private String to_time					= "";
	
	private String apply_date				= "";
	private String draft_date				= "";
	
	private String title      			    = "";
	private String content       		    = "";
	private String seq       		 	    = "";
	
	private String user_nm     		 	    = "";
	private String dept_nm     		 	    = "";
	private String duty_nm     		 	    = "";
	
	private String host_date				= "";
	
	private String out_yn 					= "";
	private String in_yn 					= "";
	private String ums_yn 					= "";
	//CTM상 POSTPROC 데이터 비교하기 위한 컬럼 추가(24.01.09 김은희)
	private String when_cond 				= "";
	private String message					= "";
	private String shout_time				= "";
	private String mapper_description		= "";
	
	private String appl_type				= "";
	
	private String cmjob_transfer			= "";

	public String getMapper_description() { return mapper_description; }
	public void setMapper_description(String mapper_description) { this.mapper_description = mapper_description; }
	public String getMessage() { return message; }
	public void setMessage(String message) { this.message = message; }
	public String getShout_time() { return shout_time; }
	public void setShout_time(String shout_time) { this.shout_time = shout_time; }
	public String getWhen_cond() { return when_cond; }
	public void setWhen_cond(String when_cond) { this.when_cond = when_cond; }
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getUser_cd_1() {
		return user_cd_1;
	}
	public void setUser_cd_1(String user_cd_1) {
		this.user_cd_1 = user_cd_1;
	}
	public String getUser_id_1() {
		return user_id_1;
	}
	public void setUser_id_1(String user_id_1) {
		this.user_id_1 = user_id_1;
	}
	public String getUser_nm_1() {
		return user_nm_1;
	}
	public void setUser_nm_1(String user_nm_1) {
		this.user_nm_1 = user_nm_1;
	}
	public String getUser_email_1() {
		return user_email_1;
	}
	public void setUser_email_1(String user_email_1) {
		this.user_email_1 = user_email_1;
	}
	public String getUser_hp_1() {
		return user_hp_1;
	}
	public void setUser_hp_1(String user_hp_1) {
		this.user_hp_1 = user_hp_1;
	}
	public String getUser_tel_1() {
		return user_tel_1;
	}
	public void setUser_tel_1(String user_tel_1) {
		this.user_tel_1 = user_tel_1;
	}
	public String getDept_nm_1() {
		return dept_nm_1;
	}
	public void setDept_nm_1(String dept_nm_1) {
		this.dept_nm_1 = dept_nm_1;
	}
	public String getDuty_nm_1() {
		return duty_nm_1;
	}
	public void setDuty_nm_1(String duty_nm_1) {
		this.duty_nm_1 = duty_nm_1;
	}
	public String getPart_nm_1() {
		return part_nm_1;
	}
	public void setPart_nm_1(String part_nm_1) {
		this.part_nm_1 = part_nm_1;
	}
	public String getUser_id_2() {
		return user_id_2;
	}
	public void setUser_id_2(String user_id_2) {
		this.user_id_2 = user_id_2;
	}
	public String getUser_nm_2() {
		return user_nm_2;
	}
	public void setUser_nm_2(String user_nm_2) {
		this.user_nm_2 = user_nm_2;
	}
	public String getUser_email_2() {
		return user_email_2;
	}
	public void setUser_email_2(String user_email_2) {
		this.user_email_2 = user_email_2;
	}
	public String getUser_hp_2() {
		return user_hp_2;
	}
	public void setUser_hp_2(String user_hp_2) {
		this.user_hp_2 = user_hp_2;
	}
	public String getUser_tel_2() {
		return user_tel_2;
	}
	public void setUser_tel_2(String user_tel_2) {
		this.user_tel_2 = user_tel_2;
	}
	public String getDept_nm_2() {
		return dept_nm_2;
	}
	public void setDept_nm_2(String dept_nm_2) {
		this.dept_nm_2 = dept_nm_2;
	}
	public String getDuty_nm_2() {
		return duty_nm_2;
	}
	public void setDuty_nm_2(String duty_nm_2) {
		this.duty_nm_2 = duty_nm_2;
	}
	public String getPart_nm_2() {
		return part_nm_2;
	}
	public void setPart_nm_2(String part_nm_2) {
		this.part_nm_2 = part_nm_2;
	}
	public String getUser_id_3() {
		return user_id_3;
	}
	public void setUser_id_3(String user_id_3) {
		this.user_id_3 = user_id_3;
	}
	public String getUser_nm_3() {
		return user_nm_3;
	}
	public void setUser_nm_3(String user_nm_3) {
		this.user_nm_3 = user_nm_3;
	}
	public String getUser_email_3() {
		return user_email_3;
	}
	public void setUser_email_3(String user_email_3) {
		this.user_email_3 = user_email_3;
	}
	public String getUser_hp_3() {
		return user_hp_3;
	}
	public void setUser_hp_3(String user_hp_3) {
		this.user_hp_3 = user_hp_3;
	}
	public String getUser_tel_3() {
		return user_tel_3;
	}
	public void setUser_tel_3(String user_tel_3) {
		this.user_tel_3 = user_tel_3;
	}
	public String getDept_nm_3() {
		return dept_nm_3;
	}
	public void setDept_nm_3(String dept_nm_3) {
		this.dept_nm_3 = dept_nm_3;
	}
	public String getDuty_nm_3() {
		return duty_nm_3;
	}
	public void setDuty_nm_3(String duty_nm_3) {
		this.duty_nm_3 = duty_nm_3;
	}
	public String getPart_nm_3() {
		return part_nm_3;
	}
	public void setPart_nm_3(String part_nm_3) {
		this.part_nm_3 = part_nm_3;
	}
	public String getUser_id_4() {
		return user_id_4;
	}
	public void setUser_id_4(String user_id_4) {
		this.user_id_4 = user_id_4;
	}
	public String getUser_nm_4() {
		return user_nm_4;
	}
	public void setUser_nm_4(String user_nm_4) {
		this.user_nm_4 = user_nm_4;
	}
	public String getUser_email_4() {
		return user_email_4;
	}
	public void setUser_email_4(String user_email_4) {
		this.user_email_4 = user_email_4;
	}
	public String getUser_hp_4() {
		return user_hp_4;
	}
	public void setUser_hp_4(String user_hp_4) {
		this.user_hp_4 = user_hp_4;
	}
	public String getUser_tel_4() {
		return user_tel_4;
	}
	public void setUser_tel_4(String user_tel_4) {
		this.user_tel_4 = user_tel_4;
	}
	public String getDept_nm_4() {
		return dept_nm_4;
	}
	public void setDept_nm_4(String dept_nm_4) {
		this.dept_nm_4 = dept_nm_4;
	}
	public String getDuty_nm_4() {
		return duty_nm_4;
	}
	public void setDuty_nm_4(String duty_nm_4) {
		this.duty_nm_4 = duty_nm_4;
	}
	public String getPart_nm_4() {
		return part_nm_4;
	}
	public void setPart_nm_4(String part_nm_4) {
		this.part_nm_4 = part_nm_4;
	}
	public String getUser_cd_5() {
		return user_cd_5;
	}
	public void setUser_cd_5(String user_cd_5) {
		this.user_cd_5 = user_cd_5;
	}
	public String getUser_id_5() {
		return user_id_5;
	}
	public void setUser_id_5(String user_id_5) {
		this.user_id_5 = user_id_5;
	}
	public String getUser_nm_5() {
		return user_nm_5;
	}
	public void setUser_nm_5(String user_nm_5) {
		this.user_nm_5 = user_nm_5;
	}
	public String getUser_email_5() {
		return user_email_5;
	}
	public void setUser_email_5(String user_email_5) {
		this.user_email_5 = user_email_5;
	}
	public String getUser_hp_5() {
		return user_hp_5;
	}
	public void setUser_hp_5(String user_hp_5) {
		this.user_hp_5 = user_hp_5;
	}
	public String getUser_tel_5() {
		return user_tel_5;
	}
	public void setUser_tel_5(String user_tel_5) {
		this.user_tel_5 = user_tel_5;
	}
	public String getDept_nm_5() {
		return dept_nm_5;
	}
	public void setDept_nm_5(String dept_nm_5) {
		this.dept_nm_5 = dept_nm_5;
	}
	public String getDuty_nm_5() {
		return duty_nm_5;
	}
	public void setDuty_nm_5(String duty_nm_5) {
		this.duty_nm_5 = duty_nm_5;
	}
	public String getPart_nm_5() {
		return part_nm_5;
	}
	public void setPart_nm_5(String part_nm_5) {
		this.part_nm_5 = part_nm_5;
	}
	public String getUser_cd_6() {
		return user_cd_6;
	}
	public void setUser_cd_6(String user_cd_6) {
		this.user_cd_6 = user_cd_6;
	}
	public String getUser_id_6() {
		return user_id_6;
	}
	public void setUser_id_6(String user_id_6) {
		this.user_id_6 = user_id_6;
	}
	public String getUser_nm_6() {
		return user_nm_6;
	}
	public void setUser_nm_6(String user_nm_6) {
		this.user_nm_6 = user_nm_6;
	}
	public String getUser_email_6() {
		return user_email_6;
	}
	public void setUser_email_6(String user_email_6) {
		this.user_email_6 = user_email_6;
	}
	public String getUser_hp_6() {
		return user_hp_6;
	}
	public void setUser_hp_6(String user_hp_6) {
		this.user_hp_6 = user_hp_6;
	}
	public String getUser_tel_6() {
		return user_tel_6;
	}
	public void setUser_tel_6(String user_tel_6) {
		this.user_tel_6 = user_tel_6;
	}
	public String getDept_nm_6() {
		return dept_nm_6;
	}
	public void setDept_nm_6(String dept_nm_6) {
		this.dept_nm_6 = dept_nm_6;
	}
	public String getDuty_nm_6() {
		return duty_nm_6;
	}
	public void setDuty_nm_6(String duty_nm_6) {
		this.duty_nm_6 = duty_nm_6;
	}
	public String getPart_nm_6() {
		return part_nm_6;
	}
	public void setPart_nm_6(String part_nm_6) {
		this.part_nm_6 = part_nm_6;
	}
	public String getUser_cd_7() {
		return user_cd_7;
	}
	public void setUser_cd_7(String user_cd_7) {
		this.user_cd_7 = user_cd_7;
	}
	public String getUser_id_7() {
		return user_id_7;
	}
	public void setUser_id_7(String user_id_7) {
		this.user_id_7 = user_id_7;
	}
	public String getUser_nm_7() {
		return user_nm_7;
	}
	public void setUser_nm_7(String user_nm_7) {
		this.user_nm_7 = user_nm_7;
	}
	public String getUser_email_7() {
		return user_email_7;
	}
	public void setUser_email_7(String user_email_7) {
		this.user_email_7 = user_email_7;
	}
	public String getUser_hp_7() {
		return user_hp_7;
	}
	public void setUser_hp_7(String user_hp_7) {
		this.user_hp_7 = user_hp_7;
	}
	public String getUser_tel_7() {
		return user_tel_7;
	}
	public void setUser_tel_7(String user_tel_7) {
		this.user_tel_7 = user_tel_7;
	}
	public String getDept_nm_7() {
		return dept_nm_7;
	}
	public void setDept_nm_7(String dept_nm_7) {
		this.dept_nm_7 = dept_nm_7;
	}
	public String getDuty_nm_7() {
		return duty_nm_7;
	}
	public void setDuty_nm_7(String duty_nm_7) {
		this.duty_nm_7 = duty_nm_7;
	}
	public String getPart_nm_7() {
		return part_nm_7;
	}
	public void setPart_nm_7(String part_nm_7) {
		this.part_nm_7 = part_nm_7;
	}
	public String getUser_cd_8() {
		return user_cd_8;
	}
	public void setUser_cd_8(String user_cd_8) {
		this.user_cd_8 = user_cd_8;
	}
	public String getUser_id_8() {
		return user_id_8;
	}
	public void setUser_id_8(String user_id_8) {
		this.user_id_8 = user_id_8;
	}
	public String getUser_nm_8() {
		return user_nm_8;
	}
	public void setUser_nm_8(String user_nm_8) {
		this.user_nm_8 = user_nm_8;
	}
	public String getUser_email_8() {
		return user_email_8;
	}
	public void setUser_email_8(String user_email_8) {
		this.user_email_8 = user_email_8;
	}
	public String getUser_hp_8() {
		return user_hp_8;
	}
	public void setUser_hp_8(String user_hp_8) {
		this.user_hp_8 = user_hp_8;
	}
	public String getUser_tel_8() {
		return user_tel_8;
	}
	public void setUser_tel_8(String user_tel_8) {
		this.user_tel_8 = user_tel_8;
	}
	public String getDept_nm_8() {
		return dept_nm_8;
	}
	public void setDept_nm_8(String dept_nm_8) {
		this.dept_nm_8 = dept_nm_8;
	}
	public String getDuty_nm_8() {
		return duty_nm_8;
	}
	public void setDuty_nm_8(String duty_nm_8) {
		this.duty_nm_8 = duty_nm_8;
	}
	public String getPart_nm_8() {
		return part_nm_8;
	}
	public void setPart_nm_8(String part_nm_8) {
		this.part_nm_8 = part_nm_8;
	}
	public String getUser_cd_9() {
		return user_cd_9;
	}
	public void setUser_cd_9(String user_cd_9) {
		this.user_cd_9 = user_cd_9;
	}
	public String getUser_id_9() {
		return user_id_9;
	}
	public void setUser_id_9(String user_id_9) {
		this.user_id_9 = user_id_9;
	}
	public String getUser_nm_9() {
		return user_nm_9;
	}
	public void setUser_nm_9(String user_nm_9) {
		this.user_nm_9 = user_nm_9;
	}
	public String getUser_email_9() {
		return user_email_9;
	}
	public void setUser_email_9(String user_email_9) {
		this.user_email_9 = user_email_9;
	}
	public String getUser_hp_9() {
		return user_hp_9;
	}
	public void setUser_hp_9(String user_hp_9) {
		this.user_hp_9 = user_hp_9;
	}
	public String getUser_tel_9() {
		return user_tel_9;
	}
	public void setUser_tel_9(String user_tel_9) {
		this.user_tel_9 = user_tel_9;
	}
	public String getDept_nm_9() {
		return dept_nm_9;
	}
	public void setDept_nm_9(String dept_nm_9) {
		this.dept_nm_9 = dept_nm_9;
	}
	public String getDuty_nm_9() {
		return duty_nm_9;
	}
	public void setDuty_nm_9(String duty_nm_9) {
		this.duty_nm_9 = duty_nm_9;
	}
	public String getPart_nm_9() {
		return part_nm_9;
	}
	public void setPart_nm_9(String part_nm_9) {
		this.part_nm_9 = part_nm_9;
	}
	public String getUser_cd_10() {
		return user_cd_10;
	}
	public void setUser_cd_10(String user_cd_10) {
		this.user_cd_10 = user_cd_10;
	}
	public String getUser_id_10() {
		return user_id_10;
	}
	public void setUser_id_10(String user_id_10) {
		this.user_id_10 = user_id_10;
	}
	public String getUser_nm_10() {
		return user_nm_10;
	}
	public void setUser_nm_10(String user_nm_10) {
		this.user_nm_10 = user_nm_10;
	}
	public String getUser_email_10() {
		return user_email_10;
	}
	public void setUser_email_10(String user_email_10) {
		this.user_email_10 = user_email_10;
	}
	public String getUser_hp_10() {
		return user_hp_10;
	}
	public void setUser_hp_10(String user_hp_10) {
		this.user_hp_10 = user_hp_10;
	}
	public String getUser_tel_10() {
		return user_tel_10;
	}
	public void setUser_tel_10(String user_tel_10) {
		this.user_tel_10 = user_tel_10;
	}
	public String getDept_nm_10() {
		return dept_nm_10;
	}
	public void setDept_nm_10(String dept_nm_10) {
		this.dept_nm_10 = dept_nm_10;
	}
	public String getDuty_nm_10() {
		return duty_nm_10;
	}
	public void setDuty_nm_10(String duty_nm_10) {
		this.duty_nm_10 = duty_nm_10;
	}
	public String getPart_nm_10() {
		return part_nm_10;
	}
	public void setPart_nm_10(String part_nm_10) {
		this.part_nm_10 = part_nm_10;
	}
	public String getIns_date() {
		return ins_date;
	}
	public void setIns_date(String ins_date) {
		this.ins_date = ins_date;
	}
	public String getIns_user_cd() {
		return ins_user_cd;
	}
	public void setIns_user_cd(String ins_user_cd) {
		this.ins_user_cd = ins_user_cd;
	}
	public String getIns_user_ip() {
		return ins_user_ip;
	}
	public void setIns_user_ip(String ins_user_ip) {
		this.ins_user_ip = ins_user_ip;
	}
	public String getUdt_date() {
		return udt_date;
	}
	public void setUdt_date(String udt_date) {
		this.udt_date = udt_date;
	}
	public String getUdt_user_cd() {
		return udt_user_cd;
	}
	public void setUdt_user_cd(String udt_user_cd) {
		this.udt_user_cd = udt_user_cd;
	}
	public String getUdt_user_ip() {
		return udt_user_ip;
	}
	public void setUdt_user_ip(String udt_user_ip) {
		this.udt_user_ip = udt_user_ip;
	}
	public String getSms_1() {
		return sms_1;
	}
	public void setSms_1(String sms_1) {
		this.sms_1 = sms_1;
	}
	public String getSms_2() {
		return sms_2;
	}
	public void setSms_2(String sms_2) {
		this.sms_2 = sms_2;
	}
	public String getSms_3() {
		return sms_3;
	}
	public void setSms_3(String sms_3) {
		this.sms_3 = sms_3;
	}
	public String getSms_4() {
		return sms_4;
	}
	public void setSms_4(String sms_4) {
		this.sms_4 = sms_4;
	}
	public String getSms_5() {
		return sms_5;
	}
	public void setSms_5(String sms_5) {
		this.sms_5 = sms_5;
	}
	public String getSms_6() {
		return sms_6;
	}
	public void setSms_6(String sms_6) {
		this.sms_6 = sms_6;
	}
	public String getSms_7() {
		return sms_7;
	}
	public void setSms_7(String sms_7) {
		this.sms_7 = sms_7;
	}
	public String getSms_8() {
		return sms_8;
	}
	public void setSms_8(String sms_8) {
		this.sms_8 = sms_8;
	}
	public String getSms_9() {
		return sms_9;
	}
	public void setSms_9(String sms_9) {
		this.sms_9 = sms_9;
	}
	public String getSms_10() {
		return sms_10;
	}
	public void setSms_10(String sms_10) {
		this.sms_10 = sms_10;
	}
	public String getError_description_ment() {
		return error_description_ment;
	}
	public void setError_description_ment(String error_description_ment) {
		this.error_description_ment = error_description_ment;
	}
	public String getTrans_yn() {
		return trans_yn;
	}
	public void setTrans_yn(String trans_yn) {
		this.trans_yn = trans_yn;
	}
	public String getSend_gubun() {
		return send_gubun;
	}
	public void setSend_gubun(String send_gubun) {
		this.send_gubun = send_gubun;
	}
	public String getMail_1() {
		return mail_1;
	}
	public void setMail_1(String mail_1) {
		this.mail_1 = mail_1;
	}
	public String getMail_2() {
		return mail_2;
	}
	public void setMail_2(String mail_2) {
		this.mail_2 = mail_2;
	}
	public String getMail_3() {
		return mail_3;
	}
	public void setMail_3(String mail_3) {
		this.mail_3 = mail_3;
	}
	public String getMail_4() {
		return mail_4;
	}
	public void setMail_4(String mail_4) {
		this.mail_4 = mail_4;
	}
	public String getMail_5() {
		return mail_5;
	}
	public void setMail_5(String mail_5) {
		this.mail_5 = mail_5;
	}
	public String getMail_6() {
		return mail_6;
	}
	public void setMail_6(String mail_6) {
		this.mail_6 = mail_6;
	}
	public String getMail_7() {
		return mail_7;
	}
	public void setMail_7(String mail_7) {
		this.mail_7 = mail_7;
	}
	public String getMail_8() {
		return mail_8;
	}
	public void setMail_8(String mail_8) {
		this.mail_8 = mail_8;
	}
	public String getMail_9() {
		return mail_9;
	}
	public void setMail_9(String mail_9) {
		this.mail_9 = mail_9;
	}
	public String getMail_10() {
		return mail_10;
	}
	public void setMail_10(String mail_10) {
		this.mail_10 = mail_10;
	}
	public String getBatchJobGrade() {
		return batchJobGrade;
	}
	public void setBatchJobGrade(String batchJobGrade) {
		this.batchJobGrade = batchJobGrade;
	}
	public String getAttach_file() {
		return attach_file;
	}
	public void setAttach_file(String attach_file) {
		this.attach_file = attach_file;
	}
	public String getChargePMNm() {
		return chargePMNm;
	}
	public void setChargePMNm(String chargePMNm) {
		this.chargePMNm = chargePMNm;
	}
	public String getErrfiles() {
		return errfiles;
	}
	public void setErrfiles(String errfiles) {
		this.errfiles = errfiles;
	}
	public String getCALL_1() {
		return CALL_1;
	}
	public void setCALL_1(String cALL_1) {
		CALL_1 = cALL_1;
	}
	public String getCALL_2() {
		return CALL_2;
	}
	public void setCALL_2(String cALL_2) {
		CALL_2 = cALL_2;
	}
	public String getCALL_3() {
		return CALL_3;
	}
	public void setCALL_3(String cALL_3) {
		CALL_3 = cALL_3;
	}
	public String getCALL_4() {
		return CALL_4;
	}
	public void setCALL_4(String cALL_4) {
		CALL_4 = cALL_4;
	}
	public String getMSG_1() {
		return MSG_1;
	}
	public void setMSG_1(String mSG_1) {
		MSG_1 = mSG_1;
	}
	public String getMSG_2() {
		return MSG_2;
	}
	public void setMSG_2(String mSG_2) {
		MSG_2 = mSG_2;
	}
	public String getMSG_3() {
		return MSG_3;
	}
	public void setMSG_3(String mSG_3) {
		MSG_3 = mSG_3;
	}
	public String getMSG_4() {
		return MSG_4;
	}
	public void setMSG_4(String mSG_4) {
		MSG_4 = mSG_4;
	}
	public String getSusiType() {
		return susiType;
	}
	public void setSusiType(String susiType) {
		this.susiType = susiType;
	}
	public String getMcode_nm_ment() {
		return mcode_nm_ment;
	}
	public void setMcode_nm_ment(String mcode_nm_ment) {
		this.mcode_nm_ment = mcode_nm_ment;
	}
	public String getDoc_gb() {
		return doc_gb;
	}
	public void setDoc_gb(String doc_gb) {
		this.doc_gb = doc_gb;
	}
	public String getDoc_cd() {
		return doc_cd;
	}
	public void setDoc_cd(String doc_cd) {
		this.doc_cd = doc_cd;
	}
	public String getCmd_line() {
		return cmd_line;
	}
	public void setCmd_line(String cmd_line) {
		this.cmd_line = cmd_line;
	}
	public String getMemname() {
		return memname;
	}
	public void setMemname(String memname) {
		this.memname = memname;
	}
	public String getCreation_date() {
		return creation_date;
	}
	public void setCreation_date(String creation_date) {
		this.creation_date = creation_date;
	}
	public String getFrom_time() {
		return from_time;
	}
	public void setFrom_time(String from_time) {
		this.from_time = from_time;
	}
	public String getTo_time() {
		return to_time;
	}
	public void setTo_time(String to_time) {
		this.to_time = to_time;
	}
	public String getApply_date() {
		return apply_date;
	}
	public void setApply_date(String apply_date) {
		this.apply_date = apply_date;
	}
	public String getDraft_date() {
		return draft_date;
	}
	public void setDraft_date(String draft_date) {
		this.draft_date = draft_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSeq() {
		return seq;
	}
	public void setSeq(String seq) {
		this.seq = seq;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getDuty_nm() {
		return duty_nm;
	}
	public void setDuty_nm(String duty_nm) {
		this.duty_nm = duty_nm;
	}
	public String getHost_date() {
		return host_date;
	}
	public void setHost_date(String host_date) {
		this.host_date = host_date;
	}
	public String getTable_id() {
		return table_id;
	}
	public void setTable_id(String table_id) {
		this.table_id = table_id;
	}
	public String getJob_id() {
		return job_id;
	}
	public void setJob_id(String job_id) {
		this.job_id = job_id;
	}
	public String getData_center() {
		return data_center;
	}
	public void setData_center(String data_center) {
		this.data_center = data_center;
	}
	public String getTable_name() {
		return table_name;
	}
	public void setTable_name(String table_name) {
		this.table_name = table_name;
	}
	public String getApplication() {
		return application;
	}
	public void setApplication(String application) {
		this.application = application;
	}
	public String getGroup_name() {
		return group_name;
	}
	public void setGroup_name(String group_name) {
		this.group_name = group_name;
	}
	public String getMem_name() {
		return mem_name;
	}
	public void setMem_name(String mem_name) {
		this.mem_name = mem_name;
	}
	public String getJob_name() {
		return job_name;
	}
	public void setJob_name(String job_name) {
		this.job_name = job_name;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getOwner() {
		return owner;
	}
	public void setOwner(String owner) {
		this.owner = owner;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getCritical() {
		return critical;
	}
	public void setCritical(String critical) {
		this.critical = critical;
	}
	public String getTask_type() {
		return task_type;
	}
	public void setTask_type(String task_type) {
		this.task_type = task_type;
	}
	public String getCyclic() {
		return cyclic;
	}
	public void setCyclic(String cyclic) {
		this.cyclic = cyclic;
	}
	public String getNode_id() {
		return node_id;
	}
	public void setNode_id(String node_id) {
		this.node_id = node_id;
	}
	public String getRerun_interval() {
		return rerun_interval;
	}
	public void setRerun_interval(String rerun_interval) {
		this.rerun_interval = rerun_interval;
	}
	public String getRerun_interval_time() {
		return rerun_interval_time;
	}
	public void setRerun_interval_time(String rerun_interval_time) {
		this.rerun_interval_time = rerun_interval_time;
	}
	public String getMem_lib() {
		return mem_lib;
	}
	public void setMem_lib(String mem_lib) {
		this.mem_lib = mem_lib;
	}
	public String getCommand() {
		return command;
	}
	public void setCommand(String command) {
		this.command = command;
	}
	public String getConfirm_flag() {
		return confirm_flag;
	}
	public void setConfirm_flag(String confirm_flag) {
		this.confirm_flag = confirm_flag;
	}
	public String getDays_cal() {
		return days_cal;
	}
	public void setDays_cal(String days_cal) {
		this.days_cal = days_cal;
	}
	public String getWeeks_cal() {
		return weeks_cal;
	}
	public void setWeeks_cal(String weeks_cal) {
		this.weeks_cal = weeks_cal;
	}
	public String getRetro() {
		return retro;
	}
	public void setRetro(String retro) {
		this.retro = retro;
	}
	public String getMax_wait() {
		return max_wait;
	}
	public void setMax_wait(String max_wait) {
		this.max_wait = max_wait;
	}
	public String getRerun_max() {
		return rerun_max;
	}
	public void setRerun_max(String rerun_max) {
		this.rerun_max = rerun_max;
	}
	public String getTime_from() {
		return time_from;
	}
	public void setTime_from(String time_from) {
		this.time_from = time_from;
	}
	public String getTime_until() {
		return time_until;
	}
	public void setTime_until(String time_until) {
		this.time_until = time_until;
	}
	public String getMonth_days() {
		return month_days;
	}
	public void setMonth_days(String month_days) {
		this.month_days = month_days;
	}
	public String getWeek_days() {
		return week_days;
	}
	public void setWeek_days(String week_days) {
		this.week_days = week_days;
	}
	public String getMonth_1() {
		return month_1;
	}
	public void setMonth_1(String month_1) {
		this.month_1 = month_1;
	}
	public String getMonth_2() {
		return month_2;
	}
	public void setMonth_2(String month_2) {
		this.month_2 = month_2;
	}
	public String getMonth_3() {
		return month_3;
	}
	public void setMonth_3(String month_3) {
		this.month_3 = month_3;
	}
	public String getMonth_4() {
		return month_4;
	}
	public void setMonth_4(String month_4) {
		this.month_4 = month_4;
	}
	public String getMonth_5() {
		return month_5;
	}
	public void setMonth_5(String month_5) {
		this.month_5 = month_5;
	}
	public String getMonth_6() {
		return month_6;
	}
	public void setMonth_6(String month_6) {
		this.month_6 = month_6;
	}
	public String getMonth_7() {
		return month_7;
	}
	public void setMonth_7(String month_7) {
		this.month_7 = month_7;
	}
	public String getMonth_8() {
		return month_8;
	}
	public void setMonth_8(String month_8) {
		this.month_8 = month_8;
	}
	public String getMonth_9() {
		return month_9;
	}
	public void setMonth_9(String month_9) {
		this.month_9 = month_9;
	}
	public String getMonth_10() {
		return month_10;
	}
	public void setMonth_10(String month_10) {
		this.month_10 = month_10;
	}
	public String getMonth_11() {
		return month_11;
	}
	public void setMonth_11(String month_11) {
		this.month_11 = month_11;
	}
	public String getMonth_12() {
		return month_12;
	}
	public void setMonth_12(String month_12) {
		this.month_12 = month_12;
	}
	public String getCount_cyclic_from() {
		return count_cyclic_from;
	}
	public void setCount_cyclic_from(String count_cyclic_from) {
		this.count_cyclic_from = count_cyclic_from;
	}
	public String getTime_zone() {
		return time_zone;
	}
	public void setTime_zone(String time_zone) {
		this.time_zone = time_zone;
	}
	public String getMultiagent() {
		return multiagent;
	}
	public void setMultiagent(String multiagent) {
		this.multiagent = multiagent;
	}
	public String getUser_daily() {
		return user_daily;
	}
	public void setUser_daily(String user_daily) {
		this.user_daily = user_daily;
	}
	public String getSchedule_and_or() {
		return schedule_and_or;
	}
	public void setSchedule_and_or(String schedule_and_or) {
		this.schedule_and_or = schedule_and_or;
	}
	public String getIn_conditions_opt() {
		return in_conditions_opt;
	}
	public void setIn_conditions_opt(String in_conditions_opt) {
		this.in_conditions_opt = in_conditions_opt;
	}
	public String getT_general_date() {
		return t_general_date;
	}
	public void setT_general_date(String t_general_date) {
		this.t_general_date = t_general_date;
	}
	public String getT_conditions_in() {
		return t_conditions_in;
	}
	public void setT_conditions_in(String t_conditions_in) {
		this.t_conditions_in = t_conditions_in;
	}
	public String getT_conditions_out() {
		return t_conditions_out;
	}
	public void setT_conditions_out(String t_conditions_out) {
		this.t_conditions_out = t_conditions_out;
	}
	public String getT_resources_q() {
		return t_resources_q;
	}
	public void setT_resources_q(String t_resources_q) {
		this.t_resources_q = t_resources_q;
	}
	public String getT_resources_c() {
		return t_resources_c;
	}
	public void setT_resources_c(String t_resources_c) {
		this.t_resources_c = t_resources_c;
	}
	public String getT_set() {
		return t_set;
	}
	public void setT_set(String t_set) {
		this.t_set = t_set;
	}
	public String getT_steps() {
		return t_steps;
	}
	public void setT_steps(String t_steps) {
		this.t_steps = t_steps;
	}
	public String getT_postproc() {
		return t_postproc;
	}
	public void setT_postproc(String t_postproc) {
		this.t_postproc = t_postproc;
	}
	
	
	
	//
	public String getMonth(int n){
		if(n==1) return getMonth_1();
		if(n==2) return getMonth_2();
		if(n==3) return getMonth_3();
		if(n==4) return getMonth_4();
		if(n==5) return getMonth_5();
		if(n==6) return getMonth_6();
		if(n==7) return getMonth_7();
		if(n==8) return getMonth_8();
		if(n==9) return getMonth_9();
		if(n==10) return getMonth_10();
		if(n==11) return getMonth_11();
		if(n==12) return getMonth_12();
		
		return "";
	}
	public String getT_tag_name() {
		return t_tag_name;
	}
	public void setT_tag_name(String tTagName) {
		t_tag_name = tTagName;
	}
	public String getCyclic_type() {
		return cyclic_type;
	}
	public void setCyclic_type(String cyclicType) {
		cyclic_type = cyclicType;
	}
	public String getInterval_sequence() {
		return interval_sequence;
	}
	public void setInterval_sequence(String intervalSequence) {
		interval_sequence = intervalSequence;
	}
	public String getTolerance() {
		return tolerance;
	}
	public void setTolerance(String tolerance) {
		this.tolerance = tolerance;
	}
	public String getSpecific_times() {
		return specific_times;
	}
	public void setSpecific_times(String specificTimes) {
		specific_times = specificTimes;
	}
	public String getOrder_id() {
		return order_id;
	}
	public void setOrder_id(String orderId) {
		order_id = orderId;
	}
	public String getActive_from() {
		return active_from;
	}
	public void setActive_from(String activeFrom) {
		active_from = activeFrom;
	}
	public String getActive_till() {
		return active_till;
	}
	public void setActive_till(String activeTill) {
		active_till = activeTill;
	}
	public String getData_center_name() {
		return data_center_name;
	}
	public void setData_center_name(String dataCenterName) {
		data_center_name = dataCenterName;
	}
	public String getOdate() {
		return odate;
	}
	public void setOdate(String odate) {
		this.odate = odate;
	}
	public String getAuthor_nm() {
		return author_nm;
	}
	public void setAuthor_nm(String author_nm) {
		this.author_nm = author_nm;
	}
	public String getSrNo() {
		return srNo;
	}
	public void setSrNo(String srNo) {
		this.srNo = srNo;
	}
	public String getChargePmNm() {
		return chargePmNm;
	}
	public void setChargePmNm(String chargePmNm) {
		this.chargePmNm = chargePmNm;
	}
	public String getProjectManMonth() {
		return projectManMonth;
	}
	public void setProjectManMonth(String projectManMonth) {
		this.projectManMonth = projectManMonth;
	}
	public String getProjectNm() {
		return projectNm;
	}
	public void setProjectNm(String projectNm) {
		this.projectNm = projectNm;
	}
	public String getSrNonAttachedReason() {
		return srNonAttachedReason;
	}
	public void setSrNonAttachedReason(String srNonAttachedReason) {
		this.srNonAttachedReason = srNonAttachedReason;
	}
	public String getBatchjobGrade() {
		return batchjobGrade;
	}
	public void setBatchjobGrade(String batchjobGrade) {
		this.batchjobGrade = batchjobGrade;
	}
	public String getError_description() {
		return error_description;
	}
	public void setError_description(String error_description) {
		this.error_description = error_description;
	}
	public String getUser_cd_2() {
		return user_cd_2;
	}
	public void setUser_cd_2(String user_cd_2) {
		this.user_cd_2 = user_cd_2;
	}
	public String getUser_cd_3() {
		return user_cd_3;
	}
	public void setUser_cd_3(String user_cd_3) {
		this.user_cd_3 = user_cd_3;
	}
	public String getUser_cd_4() {
		return user_cd_4;
	}
	public void setUser_cd_4(String user_cd_4) {
		this.user_cd_4 = user_cd_4;
	}
	public String getGlobalcond_yn() {
		return globalcond_yn;
	}
	public void setGlobalcond_yn(String globalcond_yn) {
		this.globalcond_yn = globalcond_yn;
	}
	public String getOnline_impect_yn() {
		return online_impect_yn;
	}
	public void setOnline_impect_yn(String online_impect_yn) {
		this.online_impect_yn = online_impect_yn;
	}
	public String getUser_impect_yn() {
		return user_impect_yn;
	}
	public void setUser_impect_yn(String user_impect_yn) {
		this.user_impect_yn = user_impect_yn;
	}
	public String getConcerned() {
		return concerned;
	}
	public void setConcerned(String concerned) {
		this.concerned = concerned;
	}
	public String getUpdate_detail() {
		return update_detail;
	}
	public void setUpdate_detail(String update_detail) {
		this.update_detail = update_detail;
	}
	public String getEnd_user() {
		return end_user;
	}
	public void setEnd_user(String end_user) {
		this.end_user = end_user;
	}
	public String getMoneybatchjob() {
		return moneybatchjob;
	}
	public void setMoneybatchjob(String moneybatchjob) {
		this.moneybatchjob = moneybatchjob;
	}
	public String getCalendar_nm() {
		return calendar_nm;
	}
	public void setCalendar_nm(String calendar_nm) {
		this.calendar_nm = calendar_nm;
	}
	public String getLate_sub() {
		return late_sub;
	}
	public void setLate_sub(String late_sub) {
		this.late_sub = late_sub;
	}
	public String getLate_time() {
		return late_time;
	}
	public void setLate_time(String late_time) {
		this.late_time = late_time;
	}
	public String getLate_exec() {
		return late_exec;
	}
	public void setLate_exec(String late_exec) {
		this.late_exec = late_exec;
	}
	public String getData_destination() {
		return data_destination;
	}
	public void setData_destination(String data_destination) {
		this.data_destination = data_destination;
	}
	public String getConf_cal() {
		return conf_cal;
	}
	public void setConf_cal(String conf_cal) {
		this.conf_cal = conf_cal;
	}
	public String getShift() {
		return shift;
	}
	public void setShift(String shift) {
		this.shift = shift;
	}
	public String getShift_num() {
		return shift_num;
	}
	public void setShift_num(String shift_num) {
		this.shift_num = shift_num;
	}
	public String getJobTypeGb() {
		return jobTypeGb;
	}
	public void setJobTypeGb(String jobTypeGb) {
		this.jobTypeGb = jobTypeGb;
	}
	public String getJobSchedGb() {
		return jobSchedGb;
	}
	public void setJobSchedGb(String jobSchedGb) {
		this.jobSchedGb = jobSchedGb;
	}
	public String getMcode_nm() {
		return mcode_nm;
	}
	public void setMcode_nm(String mcode_nm) {
		this.mcode_nm = mcode_nm;
	}
	public String getScode_nm() {
		return scode_nm;
	}
	public void setScode_nm(String scode_nm) {
		this.scode_nm = scode_nm;
	}
	public String getArgument() {
		return argument;
	}
	public void setArgument(String argument) {
		this.argument = argument;
	}
	public String getSystemGb() {
		return systemGb;
	}
	public void setSystemGb(String systemGb) {
		this.systemGb = systemGb;
	}
	public String getMonitor_interval() {
		return monitor_interval;
	}
	public void setMonitor_interval(String monitor_interval) {
		this.monitor_interval = monitor_interval;
	}
	public String getMonitor_time() {
		return monitor_time;
	}
	public void setMonitor_time(String monitor_time) {
		this.monitor_time = monitor_time;
	}
	public String getCpu_id() {
		return cpu_id;
	}
	public void setCpu_id(String cpu_id) {
		this.cpu_id = cpu_id;
	}
	public String getRef_table() {
		return ref_table;
	}
	public void setRef_table(String ref_table) {
		this.ref_table = ref_table;
	}
	public String getCc_yn() {
		return cc_yn;
	}
	public void setCc_yn(String cc_yn) {
		this.cc_yn = cc_yn;
	}
	public String getCc_count() {
		return cc_count;
	}
	public void setCc_count(String cc_count) {
		this.cc_count = cc_count;
	}
	public String getSuccess_sms_yn() {
		return success_sms_yn;
	}
	public void setSuccess_sms_yn(String success_sms_yn) {
		this.success_sms_yn = success_sms_yn;
	}
	public String getOut_yn() {
		return out_yn;
	}
	public void setOut_yn(String out_yn) {
		this.out_yn = out_yn;
	}
	public String getIn_yn() {
		return in_yn;
	}
	public void setIn_yn(String in_yn) {
		this.in_yn = in_yn;
	}
	public String getUms_yn() {
		return ums_yn;
	}
	public void setUms_yn(String ums_yn) {
		this.ums_yn = ums_yn;
	}
	public String getAppl_type() {
		return appl_type;
	}
	public void setAppl_type(String appl_type) {
		this.appl_type = appl_type;
	}
	public String getCmjob_transfer() {
		return cmjob_transfer;
	}
	public void setCmjob_transfer(String cmjob_transfer) {
		this.cmjob_transfer = cmjob_transfer;
	}
	
}
