CREATE OR REPLACE FUNCTION ezjobs.sp_ez_work_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_work_cd character varying, p_work_date character varying, p_content character varying, p_s_user_cd character varying, p_s_user_ip character varying)
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

            select ezjobs.NVL(max(work_cd),0) + 1
            into v_max_cnt
            from ezjobs.EZ_WORK;

            insert into ezjobs.EZ_WORK  (
                                          work_cd
                                         ,work_date
                                         ,content
                                         ,user_cd
            )
            values (
                       v_max_cnt
                   ,p_work_date
                   ,p_content
                   ,cast(p_s_user_cd as integer)
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

            update ezjobs.EZ_WORK
            set
                work_date = p_work_date
              ,content = p_content
            where work_cd = work_cd;

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

            delete from ezjobs.EZ_WORK where work_cd = cast(p_work_cd as integer);

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
