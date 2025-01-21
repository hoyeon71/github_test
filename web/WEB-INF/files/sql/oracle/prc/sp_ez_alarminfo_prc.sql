CREATE OR REPLACE PROCEDURE ezjobs.SP_EZ_ALARMINFO_PRC
(
    r_code out varchar2
,r_msg out varchar2

,p_flag varchar2
,p_row_num varchar2
,p_alarm_standard varchar2
,p_alarm_min varchar2
,p_alarm_max varchar2
,p_alarm_unit varchar2
,p_alarm_time varchar2
,p_alarm_over varchar2
,p_alarm_over_time varchar2

,p_s_user_cd varchar2
,p_s_user_ip varchar2
) is

    v_chk_cnt number;
    v_max_cnt number;

    v_ERROR EXCEPTION;

BEGIN

    if p_flag ='ins' then
        begin

            select nvl(max(alarm_seq),0) + 1
            into v_max_cnt
            from ezjobs.ez_alarm_info
            ;

            insert into ezjobs.ez_alarm_info  (
                                                 alarm_seq
                                                ,alarm_standard
                                                ,alarm_min
                                                ,alarm_max
                                                ,alarm_unit
                                                ,alarm_time
                                                ,alarm_over
                                                ,alarm_over_time
            )
            values (
                       v_max_cnt
                   ,p_alarm_standard
                   ,p_alarm_min
                   ,p_alarm_max
                   ,p_alarm_unit
                   ,p_alarm_time
                   ,p_alarm_over
                   ,p_alarm_over_time

                   )
            ;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='udt' then
        begin

            update ezjobs.ez_alarm_info
            set
                alarm_standard = p_alarm_standard
              ,alarm_min = p_alarm_min
              ,alarm_max = p_alarm_max
              ,alarm_unit = p_alarm_unit
              ,alarm_time = p_alarm_time
              ,alarm_over = p_alarm_over
              ,alarm_over_time = p_alarm_over_time

            where alarm_seq = p_row_num
            ;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='del' then
        begin
            DELETE FROM ezjobs.ez_alarm_info
            WHERE alarm_seq = p_row_num
            ;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    r_code := '1';
    r_msg := 'DEBUG.01';
    return;


EXCEPTION
    WHEN v_ERROR THEN
        ROLLBACK;
    WHEN OTHERS THEN
        r_code := '-1';
        r_msg := 'ERROR.01';
        ROLLBACK;


END;