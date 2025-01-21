CREATE OR REPLACE FUNCTION ezjobs.sp_ez_duty_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_duty_cd character varying, p_duty_nm character varying, p_duty_id character varying, p_s_user_cd character varying, p_s_user_ip character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_chk_cnt numeric;
    v_max_cnt numeric;

    rec_affected 	numeric;

BEGIN

    if p_flag ='ins' then
        begin

            select ezjobs.NVL(max(duty_cd),0) + 1
            into v_max_cnt
            from ezjobs.ez_duty
            ;

            insert into ezjobs.ez_duty  (
                                          duty_cd
                                         ,duty_nm

                                         ,ins_date
                                         ,ins_user_cd
                                         ,ins_user_ip
            )
            values (
                       v_max_cnt
                   ,p_duty_nm

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

    if p_flag ='udt' then
        begin

            update ezjobs.ez_duty
            set
                duty_nm = p_duty_nm

              ,udt_date 	= current_timestamp
              ,udt_user_cd 	= p_s_user_cd::integer
				,udt_user_ip = p_s_user_ip
            where duty_cd = p_duty_cd::integer
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

            select count(*)
            into v_chk_cnt
            from ezjobs.ez_user
            where del_yn = 'N'
              and duty_cd = p_duty_cd::integer
            ;
            if v_chk_cnt > 0 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.14';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            update ezjobs.ez_duty
            set
                del_yn = 'Y'

              ,udt_date 	= current_timestamp
              ,udt_user_cd 	= p_s_user_cd::integer
				,udt_user_ip = p_s_user_ip
            where duty_cd = p_duty_cd::integer
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

    -- 네이버 인사연동 관련 수정(2020.6.22, 김수정)
    if p_flag ='DUTY_BATCH' then
        begin

            if p_duty_nm is null then
                begin
                        p_duty_nm = '9999';
                end;
            end if;

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_DUTY
            WHERE duty_nm = p_duty_nm;

            if v_chk_cnt = 0 then
                begin
                    SELECT ezjobs.NVL(MAX(duty_cd), 0) + 1
                    INTO v_max_cnt
                    FROM ezjobs.EZ_DUTY;

                    INSERT INTO ezjobs.EZ_DUTY(
                                                duty_cd
                                               ,duty_nm
                                               ,del_yn
                                               ,duty_id

                                               ,ins_date
                                               ,ins_user_cd
                                               ,ins_user_ip
                    )
                    values (
                               v_max_cnt
                           ,p_duty_nm
                           ,'N'
                           ,p_duty_id

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

            if v_chk_cnt > 0 then
                begin
                    UPDATE ezjobs.EZ_DUTY SET
                        duty_nm 	= p_duty_nm
                                             ,del_yn      = 'N'
                                             ,udt_date 	= current_timestamp
                                             ,udt_user_cd = p_s_user_cd::integer
						   ,udt_user_ip = p_s_user_ip
                    WHERE duty_nm 		= p_duty_nm;

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
