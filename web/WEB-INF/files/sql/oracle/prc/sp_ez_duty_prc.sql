CREATE OR REPLACE PROCEDURE ezjobs.SP_EZ_DUTY_PRC
(
    r_code out varchar2
,r_msg out varchar2

,p_flag varchar2
,p_duty_cd varchar2
,p_duty_nm varchar2
,p_duty_id varchar2

,p_s_user_cd varchar2
,p_s_user_ip varchar2
) is

    v_chk_cnt number;
    v_max_cnt number;

    v_ERROR EXCEPTION;

BEGIN

    if p_flag ='ins' then
        begin

            select nvl(max(duty_cd),0) + 1
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

                   ,sysdate
                   ,p_s_user_cd
                   ,p_s_user_ip
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

            update ezjobs.ez_duty
            set
                duty_nm = p_duty_nm

              ,udt_date 	= sysdate
              ,udt_user_cd 	= p_s_user_cd
              ,udt_user_ip = p_s_user_ip
            where duty_cd = p_duty_cd
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

            select count(*)
            into v_chk_cnt
            from ezjobs.ez_user
            where del_yn = 'N'
              and duty_cd = p_duty_cd
            ;
            if v_chk_cnt > 0 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.14';
                    RAISE v_ERROR;
                end;
            end if;

            update ezjobs.ez_duty
            set
                del_yn = 'Y'

              ,udt_date 	= sysdate
              ,udt_user_cd 	= p_s_user_cd
              ,udt_user_ip = p_s_user_ip
            where duty_cd = p_duty_cd
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

    if p_flag ='DUTY_BATCH' then
        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_DUTY
            WHERE duty_id = p_duty_id;

            if v_chk_cnt = 0 then
                begin
                    SELECT NVL(MAX(duty_cd), 0) + 1
                    INTO v_max_cnt
                    FROM ezjobs.EZ_DUTY;

                    INSERT INTO ezjobs.EZ_DUTY(
                                                 duty_cd
                                                ,duty_nm
                                                ,duty_id
                                                ,ins_date
                                                ,ins_user_cd
                                                ,ins_user_ip
                    )
                    values (
                               v_max_cnt
                           ,p_duty_nm
                           ,p_duty_id
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
                    UPDATE ezjobs.EZ_DUTY SET
                        duty_nm 	= p_duty_nm
                                              ,udt_date 	= sysdate
                                              ,del_yn      = 'N'
                                              ,udt_user_cd = p_s_user_cd
                                              ,udt_user_ip = p_s_user_ip
                    WHERE duty_id 		= p_duty_id;

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