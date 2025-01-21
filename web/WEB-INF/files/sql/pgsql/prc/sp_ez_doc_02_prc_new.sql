CREATE OR REPLACE FUNCTION ezjobs.sp_ez_doc_02_prc_new(OUT r_code character varying, OUT r_msg character varying, OUT r_doc_cd character varying, p_flag character varying, p_doc_cd character varying, p_doc_gb character varying, p_title character varying, p_content character varying, p_table_id character varying, p_job_id character varying, p_data_center character varying, p_table_name character varying, p_application character varying, p_group_name character varying, p_mem_name character varying, p_job_name character varying, p_description character varying, p_author character varying, p_owner character varying, p_priority character varying, p_critical character varying, p_task_type character varying, p_cyclic character varying, p_node_id character varying, p_rerun_interval character varying, p_rerun_interval_time character varying, p_mem_lib character varying, p_command character varying, p_confirm_flag character varying, p_days_cal character varying, p_weeks_cal character varying, p_retro character varying, p_max_wait character varying, p_rerun_max character varying, p_time_from character varying, p_time_until character varying, p_month_days character varying, p_week_days character varying, p_month_1 character varying, p_month_2 character varying, p_month_3 character varying, p_month_4 character varying, p_month_5 character varying, p_month_6 character varying, p_month_7 character varying, p_month_8 character varying, p_month_9 character varying, p_month_10 character varying, p_month_11 character varying, p_month_12 character varying, p_count_cyclic_from character varying, p_time_zone character varying, p_multiagent character varying, p_user_daily character varying, p_schedule_and_or character varying, p_in_conditions_opt character varying, p_t_general_date character varying, p_t_conditions_in character varying, p_t_conditions_out character varying, p_t_resources_q character varying, p_t_resources_c character varying, p_t_set character varying, p_t_steps character varying, p_t_postproc character varying, p_t_sfile character varying, p_temp_doc_cd character varying, p_t_tag_name character varying, p_interval_sequence character varying, p_specific_times character varying, p_tolerance character varying, p_cyclic_type character varying, p_active_from character varying, p_active_till character varying, p_apply_date character varying, p_apply_check character varying, p_sr_code character varying, p_conf_cal character varying, p_shift character varying, p_shift_num character varying, p_dates_str character varying, p_monitor_time character varying, p_monitor_interval character varying, p_filesize_comparison character varying, p_num_of_iterations character varying, p_stop_time character varying, p_post_approval_time character varying, p_post_approval_yn character varying, p_grp_approval_userlist character varying, p_grp_alarm_userlist character varying, p_s_user_cd character varying, p_s_user_ip character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_user_line_cnt 	numeric;
    v_final_line_seq   	numeric;
    v_max_doc_cd    	character varying(16);

    v_line_grp_cd 		int4;
    v_user_cd 			int4;
    v_approval_gb 		character(2);
    idx 				integer;
    v_user_line_seq 	integer;
    v_approval_type 	character(2);

    rec_affected 		numeric;

BEGIN

    if p_flag ='ins' then
        begin

            SELECT 'EZJ' || TO_CHAR(current_timestamp,'yyyymmdd') || LPAD(nextval('ezjobs.doc_master_seq')::text,5,'0')
            INTO v_max_doc_cd;

            r_doc_cd := v_max_doc_cd;

            insert into ezjobs.ez_doc_master  (
                                                doc_cd
                                               ,doc_gb
                                               ,user_cd
                                               ,state_cd

                                               ,ins_date
                                               ,ins_user_cd
                                               ,ins_user_ip
            )
            values (
                       v_max_doc_cd
                   ,p_doc_gb
                   ,p_s_user_cd::integer
                   ,'00'

                   ,current_timestamp
                   ,p_s_user_cd::integer
                   ,p_s_user_ip
                   )
            ;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            insert into ezjobs.ez_doc_02  (
                                            doc_cd
                                           ,title
                                           ,content

                                           ,table_id
                                           ,job_id
                                           ,data_center
                                           ,table_name
                                           ,application
                                           ,group_name
                                           ,mem_name
                                           ,job_name
                                           ,description
                                           ,author
                                           ,owner
                                           ,priority
                                           ,critical
                                           ,task_type
                                           ,cyclic
                                           ,node_id
                                           ,rerun_interval
                                           ,rerun_interval_time
                                           ,mem_lib
                                           ,command
                                           ,confirm_flag
                                           ,days_cal
                                           ,weeks_cal
                                           ,retro
                                           ,max_wait
                                           ,rerun_max
                                           ,time_from
                                           ,time_until
                                           ,month_days
                                           ,week_days
                                           ,month_1
                                           ,month_2
                                           ,month_3
                                           ,month_4
                                           ,month_5
                                           ,month_6
                                           ,month_7
                                           ,month_8
                                           ,month_9
                                           ,month_10
                                           ,month_11
                                           ,month_12
                                           ,count_cyclic_from
                                           ,time_zone
                                           ,multiagent
                                           ,user_daily
                                           ,schedule_and_or
                                           ,in_conditions_opt

                                           ,t_general_date
                                           ,t_conditions_in
                                           ,t_conditions_out
                                           ,t_resources_q
                                           ,t_resources_c
                                           ,t_set
                                           ,t_steps
                                           ,t_postproc

                                           ,t_sfile
                                           ,t_tag_name

                                           ,interval_sequence
                                           ,specific_times
                                           ,tolerance
                                           ,cyclic_type

                                           ,active_from
                                           ,active_till

                                           ,apply_date
                                           ,apply_check
                                           ,sr_code

                                           ,conf_cal
                                           ,shift
                                           ,shift_num
                                           ,dates_str
                                           ,monitor_time
                                           ,monitor_interval
                                           ,filesize_comparison
                                           ,num_of_iterations
                                           ,stop_time

            )
            values (
                       v_max_doc_cd
                   ,p_title
                   ,p_content

                   ,(case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end)
                   ,(case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end)
                   ,p_data_center
                   ,p_table_name
                   ,p_application
                   ,p_group_name
                   ,p_mem_name
                   ,p_job_name
                   ,p_description
                   ,p_author
                   ,p_owner
                   ,p_priority
                   ,p_critical
                   ,p_task_type
                   ,p_cyclic
                   ,p_node_id
                   ,p_rerun_interval
                   ,p_rerun_interval_time
                   ,p_mem_lib
                   ,p_command
                   ,p_confirm_flag
                   ,p_days_cal
                   ,p_weeks_cal
                   ,p_retro
                   ,(case when p_max_wait is not null and length(p_max_wait)>0 then cast(p_max_wait as numeric) else 0 end)
                   ,(case when p_rerun_max is not null and length(p_rerun_max)>0 then cast(p_rerun_max as numeric) else 0 end)
                   ,p_time_from
                   ,p_time_until
                   ,p_month_days
                   ,p_week_days
                   ,p_month_1
                   ,p_month_2
                   ,p_month_3
                   ,p_month_4
                   ,p_month_5
                   ,p_month_6
                   ,p_month_7
                   ,p_month_8
                   ,p_month_9
                   ,p_month_10
                   ,p_month_11
                   ,p_month_12
                   ,p_count_cyclic_from
                   ,p_time_zone
                   ,p_multiagent
                   ,p_user_daily
                   ,p_schedule_and_or
                   ,p_in_conditions_opt

                   ,p_t_general_date
                   ,p_t_conditions_in
                   ,p_t_conditions_out
                   ,p_t_resources_q
                   ,p_t_resources_c
                   ,p_t_set
                   ,p_t_steps
                   ,p_t_postproc

                   ,p_t_sfile
                   ,p_t_tag_name

                   ,p_interval_sequence
                   ,p_specific_times
                   ,(case when p_tolerance is not null and length(p_tolerance)>0 then cast(p_tolerance as numeric) else 0 end)
                   ,p_cyclic_type

                   ,p_active_from
                   ,p_active_till

                   ,REPLACE(p_apply_date, '/', '')
                   ,p_apply_check
                   ,p_sr_code

                   ,p_conf_cal
                   ,p_shift
                   ,p_shift_num
                   ,p_dates_str

                   ,p_monitor_time
                   ,p_monitor_interval
                   ,p_filesize_comparison
                   ,p_num_of_iterations
                   ,p_stop_time

                   )
            ;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

        end;
    end if;

    if p_flag ='udt' or p_flag = 'draft' or p_flag = 'post_draft' or p_flag = 'draft_admin' then
        begin

            r_doc_cd := p_doc_cd;

            if p_flag ='udt' then
                begin
                    update ezjobs.ez_doc_master
                    set
                        udt_date 	        = current_timestamp
                      ,udt_user_cd 	    = p_s_user_cd::integer
                      ,udt_user_ip        = p_s_user_ip
                      ,post_approval_yn   = p_post_approval_yn
                    where doc_cd = p_doc_cd
                    ;

                    GET DIAGNOSTICS rec_affected := ROW_COUNT;
                    if rec_affected < 1 then
                        begin
                            r_code := '-1';
                            r_msg := 'ERROR.01';
                            RAISE EXCEPTION 'rec_affected 0';
                        end;
                    end if;

                end;
            end if;

            if p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin'  then
                begin

                    update ezjobs.ez_doc_master
                    set
                        dept_nm = (select t2.dept_nm from ezjobs.ez_user t1, ezjobs.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd::integer )
                      ,duty_nm = (select t2.duty_nm from ezjobs.ez_user t1, ezjobs.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd::integer )
                      ,state_cd = '01'
                      ,draft_date = current_timestamp
                      ,cur_approval_seq = 1
                      ,post_approval_yn = case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn end

                      ,udt_date 	= current_timestamp
                      ,udt_user_cd 	= p_s_user_cd::integer
                      ,udt_user_ip = p_s_user_ip
                    where doc_cd = p_doc_cd
                    ;

                    GET DIAGNOSTICS rec_affected := ROW_COUNT;
                    if rec_affected < 1 then
                        begin
                            r_code := '-1';
                            r_msg := 'ERROR.01';
                            RAISE EXCEPTION 'rec_affected 0';
                        end;
                    end if;

                    if p_flag ='draft' or p_flag ='post_draft' then
                        begin

                            -- 필수결재선 그룹 코드 GET
                            SELECT admin_line_grp_cd
                            INTO v_line_grp_cd
                            FROM ezjobs.EZ_ADMIN_APPROVAL_GROUP
                            WHERE use_yn = 'Y'
                              AND post_approval_yn = case when p_flag = 'post_draft' then 'Y' else 'N' end
                              AND doc_gubun = '01';

                            GET DIAGNOSTICS rec_affected := ROW_COUNT;
                            if rec_affected < 1 then
                                begin
                                    r_code := '-1';
                                    r_msg := 'ERROR.56';
                                    RAISE EXCEPTION 'rec_affected 0';
                                end;
                            end if;

                            -- 결재선 셋팅 공통 함수 호출
                            -- 2023.06.27 강명준
                            rec_affected := (select ezjobs.SP_EZ_DOC_APPROVAL_SET_PRC(p_s_user_cd, p_s_user_ip, p_doc_cd, v_line_grp_cd, p_grp_approval_userList, p_grp_alarm_userlist));

                        end;
                    end if;

                    if p_flag = 'draft_admin' then
                        begin

                            insert into ezjobs.ez_approval_doc  (
                                                                  doc_cd
                                                                 ,seq
                                                                 ,user_cd
                                                                 ,dept_nm
                                                                 ,duty_nm
                                                                 ,approval_cd

                                                                 ,ins_date
                                                                 ,ins_user_cd
                                                                 ,ins_user_ip

                            )values (
                                        p_doc_cd
                                    ,1
                                    ,p_s_user_cd::integer
                                    ,(select t2.dept_nm from ezjobs.ez_user t1, ezjobs.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd::integer )
                                    ,(select t2.duty_nm from ezjobs.ez_user t1, ezjobs.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd::integer )
                                    ,'01'

                                    ,current_timestamp
                                    ,p_s_user_cd::integer
                                    ,p_s_user_ip
                                    )
                            ;

                            GET DIAGNOSTICS rec_affected := ROW_COUNT;
                            if rec_affected < 1 then
                                begin
                                    r_code := '-1';
                                    r_msg := 'ERROR.01';
                                    RAISE EXCEPTION 'rec_affected 0';
                                end;
                            end if;

                        end;
                    end if;

                end;
            end if;

            update ezjobs.ez_doc_02
            set
                title 	                = (CASE WHEN p_flag = 'draft_admin' then '[관리자 즉시결재]' ELSE p_title END)
              ,content 	            	= p_content

              ,table_id               = (case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end)
              ,job_id                 = (case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end)
              ,data_center            = p_data_center
              ,table_name             = p_table_name
              ,application            = p_application
              ,group_name             = p_group_name
              ,mem_name               = p_mem_name
              ,job_name               = p_job_name
              ,description            = p_description
              ,author                 = p_author
              ,owner                  = p_owner
              ,priority               = p_priority
              ,critical               = p_critical
              ,task_type              = p_task_type
              ,cyclic                 = p_cyclic
              ,node_id                = p_node_id
              ,rerun_interval         = p_rerun_interval
              ,rerun_interval_time    = p_rerun_interval_time
              ,mem_lib                = p_mem_lib
              ,command                = p_command
              ,confirm_flag           = p_confirm_flag
              ,days_cal               = p_days_cal
              ,weeks_cal              = p_weeks_cal
              ,retro                  = p_retro
              ,max_wait               = (case when p_max_wait is not null and length(p_max_wait)>0 then cast(p_max_wait as numeric) else 0 end)
              ,rerun_max              = (case when p_rerun_max is not null and length(p_rerun_max)>0 then cast(p_rerun_max as numeric) else 0 end)
              ,time_from              = p_time_from
              ,time_until             = p_time_until
              ,month_days             = p_month_days
              ,week_days              = p_week_days
              ,month_1                = p_month_1
              ,month_2                = p_month_2
              ,month_3                = p_month_3
              ,month_4                = p_month_4
              ,month_5                = p_month_5
              ,month_6                = p_month_6
              ,month_7                = p_month_7
              ,month_8                = p_month_8
              ,month_9                = p_month_9
              ,month_10               = p_month_10
              ,month_11               = p_month_11
              ,month_12               = p_month_12
              ,count_cyclic_from      = p_count_cyclic_from
              ,time_zone              = p_time_zone
              ,multiagent             = p_multiagent
              ,user_daily             = p_user_daily
              ,schedule_and_or        = p_schedule_and_or
              ,in_conditions_opt      = p_in_conditions_opt

              ,t_general_date 		= p_t_general_date
              ,t_conditions_in 		= p_t_conditions_in
              ,t_conditions_out 		= p_t_conditions_out
              ,t_resources_q 			= p_t_resources_q
              ,t_resources_c 			= p_t_resources_c
              ,t_set 					= p_t_set
              ,t_steps 				= p_t_steps
              ,t_postproc 			= p_t_postproc

              ,t_sfile                = p_t_sfile
              ,t_tag_name             = p_t_tag_name
              ,interval_sequence		= p_interval_sequence
              ,specific_times			= p_specific_times
              ,tolerance				= (case when p_tolerance is not null and length(p_tolerance)>0 then cast(p_tolerance as numeric) else 0 end)
              ,cyclic_type			= p_cyclic_type

              ,active_from			= p_active_from
              ,active_till			= p_active_till

              ,apply_date				= REPLACE(p_apply_date, '/', '')
              ,apply_check			= p_apply_check
              ,sr_code                = p_sr_code

              ,conf_cal			    = p_conf_cal
              ,shift			        = p_shift
              ,shift_num			    = p_shift_num
              ,dates_str			    = p_dates_str

              ,monitor_time		    = p_monitor_time
              ,monitor_interval	    = p_monitor_interval
              ,filesize_comparison    = p_filesize_comparison
              ,num_of_iterations      = p_num_of_iterations
              ,stop_time              = p_stop_time

            where doc_cd = p_doc_cd
            ;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

        end;
    end if;

    if p_flag ='del' then
        begin

            r_doc_cd := p_doc_cd;

            delete from ezjobs.ez_approval_doc where doc_cd = p_doc_cd;

            delete from ezjobs.ez_doc_02 where doc_cd = p_doc_cd;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            delete from ezjobs.ez_doc_master where doc_cd = p_doc_cd;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;


        end;
    end if;


    r_code := '1';
    r_msg := 'DEBUG.01';
    return;

EXCEPTION
    WHEN OTHERS THEN
        IF r_code = '-1' THEN
            IF r_msg IS NULL THEN
                r_msg := 'ERROR.01';
            END IF;
        ELSE
            r_code := '-2';
            r_msg := SQLERRM;
        END IF;

END;
$function$
;
