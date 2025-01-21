CREATE OR REPLACE PROCEDURE EZJOBS.SP_EZ_LOG_PRC
(
    r_code OUT			varchar2,
    r_msg OUT			varchar2,

    p_flag				varchar2,
    p_order_id			varchar2,
    p_before_status		varchar2,
    p_after_status		varchar2,
    p_data_center		varchar2,
    p_owner				varchar2,

    p_time_from			varchar2,
    p_time_until		varchar2,
    p_priority			varchar2,
    p_rerun_max			varchar2,
    p_command			varchar2,
    p_cyclic			varchar2,
    p_rerun_interval	varchar2,
    p_node_id			varchar2,

    p_t_set				varchar2,
    p_t_conditions_in	varchar2,
    p_t_conditions_out	varchar2,

    p_job_name			varchar2,
    p_send_gubun		varchar2,
    p_message			varchar2,
    p_send_info			varchar2,
    p_send_user_cd		varchar2,
    p_return_code		varchar2,
    p_send_date			varchar2,
    p_odate				varchar2,
    p_send_desc			varchar2,

    p_description       varchar2,
    p_avg_runtime       varchar2,
    p_alarm_standard    varchar2,
    p_alarm_time        varchar2,
    p_alarm_over        varchar2,
    p_alarm_over_time   varchar2,
    p_rerun_counter     varchar2,
    p_send_description  varchar2,
    p_sysout			varchar2,

    p_s_user_cd			varchar2,
    p_s_user_ip			varchar2
) IS

    v_max_cnt 			number;
    v_ERROR 			EXCEPTION;

BEGIN

    IF p_flag ='login' THEN
        BEGIN

            SELECT coalesce(MAX(login_cd), 0) + 1
            INTO v_max_cnt
            FROM EZJOBS.EZ_LOGIN_LOG;

            INSERT INTO EZJOBS.EZ_LOGIN_LOG  (
                                                login_cd
                                               ,ins_date
                                               ,ins_user_cd
                                               ,ins_user_ip
            )
            VALUES (
                       v_max_cnt
                   ,sysdate
                   ,p_s_user_cd
                   ,p_s_user_ip
                   );

            IF SQL%ROWCOUNT < 1 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            END IF;

        END;
    END IF;

    IF p_flag ='avg_del' THEN
        BEGIN

            DELETE FROM EZJOBS.EZ_AVG_INFO WHERE order_id = p_order_id;

            IF SQL%ROWCOUNT < 1 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            END IF;

        END;
    END IF;

    IF p_flag ='send' THEN
        BEGIN

            SELECT coalesce(MAX(send_cd), 0) + 1
            INTO v_max_cnt
            FROM EZJOBS.EZ_SEND_LOG;

            INSERT INTO EZJOBS.EZ_SEND_LOG  (
                                               send_cd
                                              ,data_center
                                              ,job_name
                                              ,order_id
                                              ,send_gubun
                                              ,message
                                              ,odate
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
                   ,(SELECT scode_cd FROM EZJOBS.EZ_SCODE WHERE mcode_cd = 'M51' AND scode_eng_nm = p_send_gubun)
                   ,p_message
                   ,p_odate
                   ,p_send_info
                   ,p_send_user_cd
                   ,(CASE WHEN p_send_date IS NULL THEN sysdate ELSE TO_DATE(p_send_date, 'yyyymmddhh24miss') END)
                   ,p_return_code
                   ,(CASE WHEN p_send_date IS NULL THEN sysdate ELSE TO_DATE(p_send_date, 'yyyymmddhh24miss') END)
                   ,p_send_desc
                   ,p_rerun_counter
                   ,(SELECT scode_cd FROM EZJOBS.EZ_SCODE WHERE mcode_cd = 'M93' AND scode_nm = p_send_description)
                   );

            IF SQL%ROWCOUNT < 1 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            END IF;
        END;
    END IF;

    IF p_flag ='overSend' THEN
        BEGIN

            INSERT INTO EZJOBS.EZ_OVER_SEND  (
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
                   ,sysdate
                   ,p_alarm_standard
                   ,p_alarm_time
                   ,p_alarm_over
                   ,p_alarm_over_time
                   );

            IF SQL%ROWCOUNT < 1 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            END IF;
        END;
    END IF;

    if p_flag ='cond_log' then
        begin

            INSERT INTO EZJOBS.EZ_COND_HISTORY  (
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
                   ,p_s_user_cd
                   ,sysdate
                   );

            IF SQL%ROWCOUNT < 1 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            END IF;

        end;
    end if;

    if p_flag ='sysout' then
        begin

            UPDATE EZJOBS.ez_runinfo_history SET
                                                   sysout_yn     = 'Y',
                                                   sysout     	  = p_sysout

            WHERE order_id = p_order_id and rerun_counter = p_rerun_counter;

            IF SQL%ROWCOUNT < 1 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            END IF;

        end;
    end if;

    r_code := '1';
    r_msg := 'DEBUG.01';
    RETURN;

EXCEPTION
    WHEN v_ERROR THEN
        ROLLBACK;
    WHEN OTHERS THEN
        r_code := '-2';
        r_msg := '[' || SQLCODE || '] ' || SQLERRM;
        ROLLBACK;
END;