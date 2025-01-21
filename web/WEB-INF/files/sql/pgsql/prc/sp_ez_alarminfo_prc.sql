CREATE OR REPLACE FUNCTION ezjobs.sp_ez_alarminfo_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_row_num character varying, p_alarm_standard character varying, p_alarm_min character varying, p_alarm_max character varying, p_alarm_unit character varying, p_alarm_time character varying, p_alarm_over character varying, p_alarm_over_time character varying, p_s_user_cd character varying, p_s_user_ip character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_chk_cnt 		numeric;
    v_max_cnt 		numeric;

    rec_affected 	numeric;

BEGIN

    if p_flag ='ins' then
        begin

            select COALESCE(max(alarm_seq),0) + 1
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

            where alarm_seq = p_row_num::integer
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
            DELETE FROM ezjobs.ez_alarm_info
            WHERE alarm_seq = p_row_num::integer
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

    r_code := '1';
    r_msg := 'DEBUG.01';
    return;


EXCEPTION
    WHEN OTHERS THEN
        r_code := '-1';
        if r_msg IS NULL then
            r_msg := 'ERROR.01';
        end if;
        r_code := '-2';
        r_msg := SQLERRM;

END;
$function$
;
