CREATE OR REPLACE PROCEDURE EZJOBS.sp_ez_doc_06_prc_new
(
    r_code 				OUT varchar2
, r_msg					OUT varchar2
, r_doc_cd 				OUT	varchar2

, p_flag 				varchar2
, p_doc_cd 				varchar2
, p_title 				varchar2
, p_content 			varchar2

, p_data_center 		varchar2
, p_file_nm 			varchar2
, p_act_gb 				varchar2
, p_seq 				varchar2
, p_table_name 			varchar2
, p_application 		varchar2
, p_group_name 			varchar2

, p_mem_name 			varchar2
, p_job_name 			varchar2
, p_description 		varchar2
, p_author 				varchar2
, p_owner 				varchar2
, p_priority 			varchar2
, p_critical 			varchar2
, p_task_type 			varchar2
, p_cyclic 				varchar2

, p_node_id 			varchar2
, p_rerun_interval 		varchar2
, p_rerun_interval_time varchar2
, p_mem_lib 			varchar2
, p_command 			varchar2
, p_confirm_flag 		varchar2

, p_days_cal 			varchar2
, p_weeks_cal 			varchar2
, p_retro 				varchar2
, p_max_wait 			varchar2
, p_rerun_max 			varchar2
, p_time_from 			varchar2
, p_time_until 			varchar2
, p_month_days		 	varchar2
, p_week_days 			varchar2

, p_month_1 			varchar2
, p_month_2 			varchar2
, p_month_3 			varchar2
, p_month_4 			varchar2
, p_month_5 			varchar2
, p_month_6 			varchar2
, p_month_7 			varchar2
, p_month_8 			varchar2
, p_month_9 			varchar2
, p_month_10 			varchar2
, p_month_11 			varchar2
, p_month_12 			varchar2
, p_count_cyclic_from 	varchar2

, p_time_zone 			varchar2
, p_multiagent 			varchar2
, p_user_daily 			varchar2
, p_schedule_and_or 	varchar2
, p_in_conditions_opt 	varchar2

, p_t_general_date 		varchar2
, p_t_conditions_in 	varchar2
, p_t_conditions_out 	varchar2
, p_t_resources_q 		varchar2
, p_t_resources_c 		varchar2
, p_t_set 				varchar2
, p_t_steps 			varchar2
, p_t_postproc 			varchar2
, p_t_sfile 			varchar2

, p_conf_cal 			varchar2
, p_shift 				varchar2
, p_shift_num 			varchar2
, p_t_tag_name 			varchar2
, p_interval_sequence 	varchar2
, p_specific_times 		varchar2
, p_tolerance 			varchar2
, p_cyclic_type 		varchar2
, p_active_from 		varchar2
, p_active_till 		varchar2
, p_apply_date 			varchar2
, p_apply_check 		varchar2
, p_dates_str 			varchar2

, p_post_approval_time 	varchar2
, p_post_approval_yn 	varchar2

, p_ind_cyclic 			varchar2
, p_grp_approval_userlist varchar2
, p_grp_alarm_userlist	varchar2

, p_s_user_cd 			varchar2
, p_s_user_ip 			varchar2
)

    IS

    v_user_line_cnt 	number;
    v_final_line_seq   	number;
    v_max_doc_cd    	varchar2(16);
    v_max_seq      		number;

    v_line_grp_cd 		number;
    v_user_line_seq 	integer;
    v_approval_type 	character(2);

    rec_affected 		number;
    v_ERROR 			EXCEPTION;

BEGIN

    if p_flag ='temp_ins' OR p_flag ='v_temp_ins' then
        begin
            /*
			SELECT 'EZJ' || TO_CHAR(sysdate,'yyyymmdd') || LPAD((COALESCE(REPLACE(MAX(doc_cd),'EZJ'|| TO_CHAR(sysdate,'yyyymmdd'),''),0)+1),5,'0')
			INTO v_max_doc_cd
			from EZJOBS.ez_doc_master
			where doc_cd like 'EZJ'|| to_char(sysdate,'yyyymmdd') || '%' ;
			*/

            SELECT 'EZJ' || TO_CHAR(sysdate,'yyyymmdd') || LPAD(doc_master_seq.nextval,5,'0')
            INTO v_max_doc_cd
            FROM DUAL;

            r_doc_cd := v_max_doc_cd;

            insert into EZJOBS.ez_doc_master (
                doc_cd,
                doc_gb,
                user_cd,
                dept_nm,
                duty_nm,
                state_cd,

                ins_date,
                ins_user_cd,
                ins_user_ip
            )
            values (
                       v_max_doc_cd,
                       '06',
                       p_s_user_cd,
                       (select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd ),
                       (select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd ),
                       '00',

                       sysdate,
                       p_s_user_cd,
                       p_s_user_ip
                   );


            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

            insert into EZJOBS.ez_doc_06 (
                doc_cd,
                title,
                content,
                data_center,
                table_name,
                file_nm,
                act_gb,
                apply_date,
                apply_check
            )
            values (
                       v_max_doc_cd,
                       p_title,
                       p_content,
                       p_data_center,
                       p_table_name,
                       p_file_nm,
                       p_act_gb,
                       REPLACE(p_apply_date, '/', ''),
                       p_apply_check
                   );

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

        end;
    end if;

    if p_flag ='detail_ins' then
        begin

            select NVL(MAX(seq), 0) + 1
            into v_max_seq
            from EZJOBS.ez_doc_06_detail
            where doc_cd = p_doc_cd;

            insert into EZJOBS.ez_doc_06_detail  (
                                                     doc_cd
                                                   , seq
                                                   , table_name
                                                   , application
                                                   , group_name
                                                   , mem_name
                                                   , job_name
                                                   , description
                                                   , author
                                                   , owner
                                                   , priority
                                                   , critical
                                                   , task_type
                                                   , cyclic
                                                   , node_id
                                                   , rerun_interval
                                                   , rerun_interval_time
                                                   , mem_lib
                                                   , command
                                                   , confirm_flag
                                                   , days_cal
                                                   , weeks_cal
                                                   , retro
                                                   , max_wait
                                                   , rerun_max
                                                   , time_from
                                                   , time_until
                                                   , month_days
                                                   , week_days
                                                   , month_1
                                                   , month_2
                                                   , month_3
                                                   , month_4
                                                   , month_5
                                                   , month_6
                                                   , month_7
                                                   , month_8
                                                   , month_9
                                                   , month_10
                                                   , month_11
                                                   , month_12
                                                   , count_cyclic_from
                                                   , time_zone
                                                   , multiagent
                                                   , user_daily
                                                   , schedule_and_or
                                                   , in_conditions_opt
                                                   , t_general_date
                                                   , t_conditions_in
                                                   , t_conditions_out
                                                   , t_resources_q
                                                   , t_resources_c
                                                   , t_set
                                                   , t_steps
                                                   , t_postproc
                                                   , t_sfile
                                                   , conf_cal
                                                   , shift
                                                   , shift_num
                                                   , t_tag_name
                                                   , interval_sequence
                                                   , specific_times
                                                   , tolerance
                                                   , cyclic_type
                                                   , active_from
                                                   , active_till
                                                   , dates_str
                                                   , ind_cyclic
            )
            values (
                       p_doc_cd
                   , v_max_seq
                   , p_table_name
                   , p_application
                   , p_group_name
                   , p_mem_name
                   , p_job_name
                   , p_description
                   , p_author
                   , p_owner
                   , p_priority
                   , p_critical
                   , p_task_type
                   , p_cyclic
                   , p_node_id
                   , p_rerun_interval
                   , p_rerun_interval_time
                   , p_mem_lib
                   , p_command
                   , p_confirm_flag
                   , p_days_cal
                   , p_weeks_cal
                   , p_retro
                   ,(case when p_max_wait is not null and length(p_max_wait)>0 then cast(p_max_wait as number) else 0 end)
                   ,(case when p_rerun_max is not null and length(p_rerun_max)>0 then cast(p_rerun_max as number) else 0 end)
                   , p_time_from
                   , p_time_until
                   , p_month_days
                   , p_week_days
                   , p_month_1
                   , p_month_2
                   , p_month_3
                   , p_month_4
                   , p_month_5
                   , p_month_6
                   , p_month_7
                   , p_month_8
                   , p_month_9
                   , p_month_10
                   , p_month_11
                   , p_month_12
                   , p_count_cyclic_from
                   , p_time_zone
                   , p_multiagent
                   , p_user_daily
                   , p_schedule_and_or
                   , p_in_conditions_opt
                   , p_t_general_date
                   , p_t_conditions_in
                   , p_t_conditions_out
                   , p_t_resources_q
                   , p_t_resources_c
                   , p_t_set
                   , p_t_steps
                   , p_t_postproc
                   , p_t_sfile
                   , p_conf_cal
                   , p_shift
                   , p_shift_num
                   , p_t_tag_name
                   , p_interval_sequence
                   , p_specific_times
                   ,(case when p_tolerance is not null and length(p_tolerance)>0 then cast(p_tolerance as number) else 0 end)
                   , p_cyclic_type
                   , p_active_from
                   , p_active_till
                   , p_dates_str
                   , p_ind_cyclic
                   );

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

        end;
    end if;

    if p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin' then
        begin

            r_doc_cd := p_doc_cd;

            if p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin' then
                begin

                    update EZJOBS.ez_doc_master
                    set
                        dept_nm		 	= (select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd )
                      ,duty_nm 			= (select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd )
                      ,state_cd 		= '01'
                      ,draft_date 		= sysdate
                      ,cur_approval_seq = 1
                      ,post_approval_yn = (case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn END)

                      ,udt_date 		= sysdate
                      ,udt_user_cd 		= p_s_user_cd
                      ,udt_user_ip 		= p_s_user_ip
                    where doc_cd = p_doc_cd
                    ;


                    if SQL%ROWCOUNT < 1 then
                        BEGIN
                            r_code := '-1';
                            r_msg := 'ERROR.01';
                            RAISE v_ERROR;
                        END;
                    end if;

                    update EZJOBS.ez_doc_06
                    set title = (CASE WHEN p_flag = 'draft_admin' then '[관리자 즉시결재]' ELSE p_title END)
                    where doc_cd = p_doc_cd
                    ;

                    if SQL%ROWCOUNT < 1 then
                        BEGIN
                            r_code := '-1';
                            r_msg := 'ERROR.01';
                            RAISE v_ERROR;
                        END;
                    end if;

                    if p_flag ='draft' or p_flag ='post_draft' then
                        begin

                            -- 필수결재선 그룹 코드 GET
                            SELECT admin_line_grp_cd
                            INTO v_line_grp_cd
                            FROM EZJOBS.EZ_ADMIN_APPROVAL_GROUP
                            WHERE use_yn = 'Y'
                              AND post_approval_yn = (CASE WHEN p_flag = 'post_draft' THEN 'Y' ELSE 'N' END)
                              AND doc_gubun = '01';

                            --                            GET DIAGNOSTICS rec_affected := ROW_COUNT;
--                            if rec_affected < 1 then
--                                begin
--                                    r_code := '-1';
--                                    r_msg := 'ERROR.56';
--                                    RAISE EXCEPTION 'rec_affected 0';
--                                end;
--                            end if;
                            if SQL%ROWCOUNT < 1 then
                                BEGIN
                                    r_code := '-1';
                                    r_msg := 'ERROR.56';
                                    RAISE v_ERROR;
                                END;
                            end if;

                            -- 결재선 셋팅 공통 함수 호출
                            -- 2023.06.03 강명준
                            SP_EZ_DOC_APPROVAL_SET_PRC(p_s_user_cd, p_s_user_ip, p_doc_cd, v_line_grp_cd, p_grp_approval_userList, p_grp_alarm_userlist);

                        end;
                    end if;

                    if p_flag ='draft_admin' then
                        begin

                            insert into EZJOBS.ez_approval_doc  (
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
                                    ,p_s_user_cd
                                    ,(select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd )
                                    ,(select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd )
                                    ,'01'

                                    ,sysdate
                                    ,p_s_user_cd
                                    ,p_s_user_ip
                                    )
                            ;

                            if SQL%ROWCOUNT < 1 then
                                BEGIN
                                    r_code := '-1';
                                    r_msg := 'ERROR.01';
                                    RAISE v_ERROR;
                                END;
                            end if;

                        end;
                    end if;

                end;
            end if;

        end;
    end if;

    if p_flag ='del' then
        begin

            r_doc_cd := p_doc_cd;

            delete from EZJOBS.ez_approval_doc where doc_cd = p_doc_cd;

            delete from EZJOBS.ez_doc_06_detail where doc_cd = p_doc_cd;

            delete from EZJOBS.ez_doc_06 where doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

            delete from EZJOBS.ez_doc_master where doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
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