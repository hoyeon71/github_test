CREATE OR REPLACE FUNCTION ezjobs.sp_ez_log_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_order_id character varying, p_before_status character varying, p_after_status character varying, p_data_center character varying, p_owner character varying, p_time_from character varying, p_time_until character varying, p_priority character varying, p_rerun_max character varying, p_command character varying, p_cyclic character varying, p_rerun_interval character varying, p_node_id character varying, p_t_set character varying, p_t_conditions_in character varying, p_t_conditions_out character varying, p_job_name character varying, p_send_gubun character varying, p_message character varying, p_send_info character varying, p_send_user_cd character varying, p_return_code character varying, p_send_date character varying, p_odate character varying, p_send_desc character varying, p_description character varying, p_avg_runtime character varying, p_alarm_standard character varying, p_alarm_time character varying, p_alarm_over character varying, p_alarm_over_time character varying, p_rerun_counter character varying, p_send_description character varying, p_sysout character varying, p_s_user_cd character varying, p_s_user_ip character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_max_cnt 		numeric;
    rec_affected 	numeric;

BEGIN

    if p_flag ='login' then
        begin

            SELECT coalesce(MAX(login_cd), 0) + 1
            INTO v_max_cnt
            FROM ezjobs.EZ_LOGIN_LOG;

            INSERT INTO ezjobs.EZ_LOGIN_LOG  (
                                               login_cd
                                              ,ins_date
                                              ,ins_user_cd
                                              ,ins_user_ip
            )
            VALUES (
                       v_max_cnt
                   ,current_timestamp
                   ,p_s_user_cd::integer
                   ,p_s_user_ip
                   );

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

    if p_flag ='avg_del' then
        begin

            DELETE FROM ezjobs.EZ_AVG_INFO WHERE order_id = p_order_id;

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

    if p_flag ='status' then
        begin

            SELECT NVL(MAX(status_cd), 0) + 1
            INTO v_max_cnt
            FROM ezjobs.EZ_STATUS_LOG;

            INSERT INTO ezjobs.EZ_STATUS_LOG  (
                                                status_cd
                                               ,order_id
                                               ,before_status
                                               ,after_status
                                               ,job_name
                                               ,ins_date
                                               ,ins_user_cd
                                               ,ins_user_ip
            )
            VALUES (
                       v_max_cnt
                   ,p_order_id
                   ,p_before_status
                   ,p_after_status
                   ,p_job_name
                   ,current_timestamp
                   ,p_s_user_cd::integer
                   ,p_s_user_ip
                   );

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

    if p_flag ='ajob' then
        begin

            SELECT coalesce(MAX(ajob_cd), 0) + 1
            INTO v_max_cnt
            FROM ezjobs.EZ_LOG_AJOB;

            INSERT INTO ezjobs.EZ_LOG_AJOB  (
                                              ajob_cd
                                             ,data_center
                                             ,order_id
                                             ,owner
                                             ,time_from
                                             ,time_until
                                             ,priority
                                             ,rerun_max
                                             ,command
                                             ,cyclic
                                             ,rerun_interval
                                             ,node_id
                                             ,t_set
                                             ,t_conditions_in
                                             ,t_conditions_out
                                             ,ins_date
                                             ,ins_user_cd
                                             ,ins_user_ip
            )
            VALUES (
                       v_max_cnt
                   ,p_data_center
                   ,p_order_id
                   ,p_owner
                   ,p_time_from
                   ,p_time_until
                   ,p_priority
                   ,p_rerun_max
                   ,p_command
                   ,p_cyclic
                   ,p_rerun_interval
                   ,p_node_id
                   ,p_t_set
                   ,p_t_conditions_in
                   ,p_t_conditions_out
                   ,current_timestamp
                   ,p_s_user_cd::integer
                   ,p_s_user_ip
                   );

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

    if p_flag ='send' then
        begin

            SELECT coalesce(MAX(send_cd), 0) + 1
            INTO v_max_cnt
            FROM ezjobs.EZ_SEND_LOG;

            INSERT INTO ezjobs.EZ_SEND_LOG  (
                                              send_cd
                                             ,data_center
                                             ,job_name
                                             ,order_id
                                             ,send_gubun
                                             ,message
                                             ,send_info
                                             ,send_user_cd
                                             ,send_date
                                             ,return_code
                                             ,return_date
                                             ,send_desc
                                             ,rerun_counter
                                             ,send_description
            )
            VALUES (
                       v_max_cnt
                   ,p_data_center
                   ,p_job_name
                   ,p_order_id
                   ,(SELECT scode_cd FROM ezjobs.EZ_SCODE WHERE mcode_cd = 'M51' AND scode_eng_nm = p_send_gubun)
                   ,p_message
                   ,p_send_info
                   ,p_send_user_cd::integer
                   ,current_timestamp
                   ,p_return_code
                   ,current_timestamp
                   ,p_send_desc
                   ,p_rerun_counter::integer
                   ,(SELECT scode_cd FROM ezjobs.EZ_SCODE WHERE mcode_cd = 'M93' AND scode_nm = p_send_description)

                   );

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

    IF p_flag ='overSend' THEN
        BEGIN

            INSERT INTO ezjobs.EZ_OVER_SEND  (
                                               data_center
                                              ,job_name
                                              ,description
                                              ,avg_runtime
                                              ,order_id
                                              ,odate
                                              ,send_date
                                              ,alarm_standard
                                              ,alarm_time
                                              ,alarm_over
                                              ,alarm_over_time
            )
            VALUES (
                       p_data_center
                   ,p_job_name
                   ,p_description
                   ,p_avg_runtime
                   ,p_order_id
                   ,p_odate
                   ,current_timestamp
                   ,p_alarm_standard
                   ,p_alarm_time
                   ,p_alarm_over
                   ,p_alarm_over_time
                   );

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;
        END;
    END IF;

    if p_flag ='cond_log' then
        begin

            INSERT INTO ezjobs.EZ_COND_HISTORY  (
                                                  gubun
                                                 ,condition_name
                                                 ,odate
                                                 ,ins_user_cd
                                                 ,ins_date
            )
            VALUES (
                       p_send_gubun
                   ,p_t_conditions_in
                   ,p_odate
                   ,p_s_user_cd::integer
                   ,current_timestamp
                   );

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

    if p_flag ='sysout' then
        begin

            UPDATE ezjobs.ez_runinfo_history SET
                                                  sysout_yn     = 'Y',
                                                  sysout     	  = p_sysout

            WHERE order_id = p_order_id and rerun_counter = p_rerun_counter::integer;

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
