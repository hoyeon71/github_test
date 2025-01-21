CREATE OR REPLACE PROCEDURE ezjobs.SP_EZ_DEPT_PRC
(
    r_code out 			varchar2,
    r_msg out 			varchar2,

    p_flag 				varchar2,
    p_dept_cd 			varchar2,
    p_dept_nm 			varchar2,
    p_dept_id 			varchar2,
    p_s_user_cd 		varchar2,
    p_s_user_ip 		varchar2
) IS

    v_chk_cnt 			number;
    v_max_cnt 			number;

    v_ERROR 			EXCEPTION;

BEGIN

    if p_flag ='ins' then
        begin

            SELECT NVL(MAX(dept_cd), 0) + 1
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
                   ,sysdate
                   ,p_s_user_cd
                   ,p_s_user_ip
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

            UPDATE ezjobs.EZ_DEPT SET
                                        dept_nm 		= p_dept_nm,
                                        udt_date 		= sysdate,
                                        udt_user_cd 	= p_s_user_cd,
                                        udt_user_ip 	= p_s_user_ip
            WHERE dept_cd = p_dept_cd;

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

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_USER
            WHERE del_yn = 'N'
              AND dept_cd = p_dept_cd;

            if v_chk_cnt > 0 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.14';
                    RAISE v_ERROR;
                end;
            end if;

            UPDATE ezjobs.EZ_DEPT SET
                                        del_yn 		= 'Y',
                                        udt_date 	= sysdate,
                                        udt_user_cd 	= p_s_user_cd,
                                        udt_user_ip 	= p_s_user_ip
            WHERE dept_cd = p_dept_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;


    if p_flag ='DEPT_BATCH' then
        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_DEPT
            WHERE dept_id = p_dept_id;

            if v_chk_cnt = 0 then
                begin
                    SELECT NVL(MAX(dept_cd), 0) + 1
                    INTO v_max_cnt
                    FROM ezjobs.EZ_DEPT;

                    INSERT INTO ezjobs.EZ_DEPT (
                                                  dept_cd
                                                 ,dept_nm
                                                 ,dept_id
                                                 ,ins_date
                                                 ,ins_user_cd
                                                 ,ins_user_ip
                    )
                    VALUES (
                               v_max_cnt
                           ,p_dept_nm
                           ,p_dept_id
                           ,sysdate
                           ,p_s_user_cd
                           ,p_s_user_ip
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

            if v_chk_cnt > 0 then
                begin
                    UPDATE ezjobs.EZ_DEPT SET
                                                dept_nm 		= p_dept_nm,
                                                del_yn      	= 'N',
                                                udt_date 		= sysdate,
                                                udt_user_cd 	= p_s_user_cd,
                                                udt_user_ip 	= p_s_user_ip
                    WHERE dept_id 		= p_dept_id;

                    if SQL%ROWCOUNT < 1 then
                        begin
                            r_code := '-1';
                            r_msg := 'ERROR.01';
                            RAISE v_ERROR;
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
    WHEN v_ERROR THEN
        ROLLBACK;
    WHEN OTHERS THEN
        r_code := '-1';
        r_msg := 'ERROR.01';
        ROLLBACK;


END;