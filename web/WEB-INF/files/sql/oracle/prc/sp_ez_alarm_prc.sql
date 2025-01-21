CREATE OR REPLACE PROCEDURE ezjobs.sp_ez_alarm_prc
(
    r_code 					OUT varchar2,
    r_msg 					OUT varchar2,

    p_flag 						varchar2,
    p_alarm_cd 					varchar2,
    p_user_cd 					varchar2,
    p_action_yn 				varchar2,
    p_action_gubun 				varchar2,
    p_action_date 				varchar2,
    p_recur_yn 					varchar2,
    p_error_gubun 				varchar2,
    p_error_description 		varchar2,
    p_solution_description 		varchar2,
    p_confirm_yn 				varchar2,
    p_s_user_cd 				varchar2
)
    is

    v_chk_cnt 					number;
    v_max_cnt 					number;

    v_ERROR 					EXCEPTION;

BEGIN

    if p_flag = 'udt' then
        begin

            UPDATE ezjobs.EZ_ALARM SET
                                         user_cd                	= p_user_cd,
                                         action_yn            	= p_action_yn,
                                         action_gubun            	= p_action_gubun,
                                         action_date        	 	= (CASE WHEN p_action_date = '' THEN NULL ELSE p_action_date END),
                                         recur_yn             	= p_recur_yn,
                                         error_gubun          	= p_error_gubun,
                                         error_description   	  	= p_error_description,
                                         solution_description 	= p_solution_description,
                                         update_time          	= current_timestamp,
                                         update_user_cd       	= p_s_user_cd
            WHERE alarm_cd = p_alarm_cd;

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
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
            WHERE alarm_cd = p_alarm_cd;

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

        end;
    end if;

    if p_flag = 'udt_all' then
        begin

            UPDATE ezjobs.EZ_ALARM SET
                                         user_cd                	= (CASE WHEN p_user_cd = '' THEN NULL ELSE p_user_cd END),
                                         action_yn            	= p_action_yn,
                                         action_gubun            	= p_action_gubun,
                                         error_description   	  	= p_error_description,
                                         update_time          	= current_timestamp,
                                         update_user_cd       	= p_s_user_cd
            WHERE alarm_cd = p_alarm_cd;

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

        end;
    end if;

    if p_flag = 'confirm_all' then
        begin

            UPDATE ezjobs.EZ_ALARM SET
                                         confirm_user_cd		= p_s_user_cd,
                                         confirm_yn           = p_confirm_yn,
                                         confirm_time       	= current_timestamp
            WHERE alarm_cd = p_alarm_cd;

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

        end;
    end if;

    if p_flag = 'del' then
        begin

            UPDATE ezjobs.EZ_ALARM SET del_yn = 'Y'
            WHERE alarm_cd = p_alarm_cd;

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