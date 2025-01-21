CREATE OR REPLACE PROCEDURE ezjobs.SP_EZ_WORK_PRC
(
    r_code 			OUT varchar2,
    r_msg 			OUT varchar2,
    p_flag 				varchar2,
    p_work_cd 			varchar2,
    p_work_date 		varchar2,
    p_content 			varchar2,
    p_s_user_cd 		varchar2,
    p_s_user_ip 		varchar2
) is

    v_chk_cnt number;
    v_max_cnt number;

    v_ERROR EXCEPTION;

BEGIN

    if p_flag ='ins' then
        begin

            select NVL(max(work_cd),0) + 1
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

            update ezjobs.EZ_WORK
            set
                work_date = p_work_date
              ,content = p_content
            where work_cd = work_cd;

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

            delete from ezjobs.EZ_WORK where work_cd = cast(p_work_cd as integer);

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
        r_code := '-2';
        r_msg := '[' || SQLCODE || '] ' || SQLERRM;
        ROLLBACK;
END;
