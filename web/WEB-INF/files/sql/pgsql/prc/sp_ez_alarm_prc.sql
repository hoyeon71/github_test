CREATE OR REPLACE FUNCTION ezjobs.sp_ez_alarm_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_alarm_cd character varying, p_user_cd character varying, p_action_yn character varying, p_action_gubun character varying, p_action_date character varying, p_recur_yn character varying, p_error_gubun character varying, p_error_description character varying, p_solution_description character varying, p_confirm_yn character varying, p_s_user_cd character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_chk_cnt 			numeric;
    v_max_cnt 			numeric;

    rec_affected 	numeric;

BEGIN

    if p_flag = 'udt' then
        begin

            UPDATE ezjobs.EZ_ALARM SET
                user_cd                	= p_user_cd::integer,
				   action_yn            	= p_action_yn,
				   action_gubun            	= p_action_gubun,
				   action_date        	 	= (CASE WHEN p_action_date = '' THEN NULL ELSE p_action_date END),
				   recur_yn             	= p_recur_yn,
				   error_gubun          	= p_error_gubun,
				   error_description   	  	= p_error_description,
				   solution_description 	= p_solution_description,
				   update_time          	= current_timestamp,
				   update_user_cd       	= p_s_user_cd::integer
            WHERE alarm_cd = p_alarm_cd;

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

    if p_flag = 'user_udt' then
        begin

            UPDATE ezjobs.EZ_ALARM SET
                                        --user_cd                	= p_user_cd,
                                        action_yn            	= p_action_yn,
                                        action_gubun            	= p_action_gubun,
                                        action_date        	 	= (CASE WHEN p_action_date = '' THEN NULL ELSE p_action_date END),
                                        recur_yn             	= p_recur_yn,
                                        error_gubun          	= p_error_gubun,
                                        error_description   	  	= p_error_description,
                                        solution_description 	= p_solution_description
                                        --update_time          	= sysdate,
                                        --update_user_cd       	= p_s_user_cd
            WHERE alarm_cd = p_alarm_cd::integer;

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

    if p_flag = 'udt_all' then
        begin

            UPDATE ezjobs.EZ_ALARM SET
                                        user_cd                	= (CASE WHEN p_user_cd = '' THEN NULL ELSE p_user_cd::integer END),
                                        action_yn            	= p_action_yn,
                                        action_gubun            	= p_action_gubun,
                                        error_description   	  	= p_error_description,
                                        update_time          	= current_timestamp,
                                        update_user_cd       	= p_s_user_cd::integer
            WHERE alarm_cd = p_alarm_cd::integer;

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

    if p_flag = 'confirm_all' then
        begin

            UPDATE ezjobs.EZ_ALARM SET
                confirm_user_cd		= p_s_user_cd::integer,
				   confirm_yn           = p_confirm_yn,
				   confirm_time       	= current_timestamp
            WHERE alarm_cd = p_alarm_cd::integer;

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

    if p_flag = 'del' then
        begin

            UPDATE ezjobs.EZ_ALARM SET del_yn = 'Y'
            WHERE alarm_cd = p_alarm_cd::integer;

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
