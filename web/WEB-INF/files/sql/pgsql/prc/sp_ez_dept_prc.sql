CREATE OR REPLACE FUNCTION ezjobs.sp_ez_dept_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_dept_cd character varying, p_dept_nm character varying, p_dept_id character varying, p_s_user_cd character varying, p_s_user_ip character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_chk_cnt 			numeric;
    v_max_cnt 			numeric;

    rec_affected 	numeric;

BEGIN

    if p_flag ='ins' then
        begin

            SELECT ezjobs.NVL(MAX(dept_cd), 0) + 1
            INTO v_max_cnt
            FROM ezjobs.EZ_DEPT;

            INSERT INTO ezjobs.EZ_DEPT  (
                                          dept_cd
                                         ,dept_nm
                                         ,ins_date
                                         ,ins_user_cd
                                         ,ins_user_ip
            )
            VALUES (
                       v_max_cnt
                   ,p_dept_nm
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

    if p_flag ='udt' then
        begin

            UPDATE ezjobs.EZ_DEPT SET
                                       dept_nm 		= p_dept_nm,
                                       udt_date 		= current_timestamp,
                                       udt_user_cd 	= p_s_user_cd::integer,
				udt_user_ip 	= p_s_user_ip
            WHERE dept_cd = p_dept_cd::integer;

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

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_USER
            WHERE del_yn = 'N'
              AND dept_cd = p_dept_cd::integer;

            --GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if v_chk_cnt > 0 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.14';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            UPDATE ezjobs.EZ_DEPT SET
                                       del_yn 		= 'Y',
                                       udt_date 	= current_timestamp,
                                       udt_user_cd 	= p_s_user_cd::integer,
				udt_user_ip 	= p_s_user_ip
            WHERE dept_cd = p_dept_cd::integer;

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
    if p_flag ='DEPT_BATCH' then
        begin
            if p_dept_nm is null then
                begin
                        p_dept_nm = '9999';
                end;
            end if;

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_DEPT
            WHERE dept_nm = p_dept_nm;

            if v_chk_cnt = 0 then
                begin
                    SELECT ezjobs.NVL(MAX(dept_cd), 0) + 1
                    INTO v_max_cnt
                    FROM ezjobs.EZ_DEPT;

                    INSERT INTO ezjobs.EZ_DEPT (
                                                 dept_cd
                                                ,dept_nm
                                                ,del_yn
                                                ,dept_id
                                                ,ins_date
                                                ,ins_user_cd
                                                ,ins_user_ip
                    )
                    VALUES (
                               v_max_cnt
                               --,p_dept_nm
                           ,case when p_dept_nm is null then '9999' else p_dept_nm end
                           ,'N'
                           ,p_dept_id
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
                    UPDATE ezjobs.EZ_DEPT SET
                                               dept_nm 		= p_dept_nm,
                                               del_yn      	= 'N',
                                               udt_date 		= current_timestamp,
                                               udt_user_cd 	= p_s_user_cd::integer,
						udt_user_ip 	= p_s_user_ip
                    WHERE dept_nm		= p_dept_nm;

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
