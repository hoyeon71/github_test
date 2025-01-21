CREATE OR REPLACE PROCEDURE EZJOBS.sp_ez_doc_10_prc
(
    r_code 	OUT varchar2
, r_msg 	OUT varchar2
, r_doc_cd 	OUT varchar2

, p_flag 					varchar2
, p_doc_cd 					varchar2
, p_data_center 			varchar2
, p_job_name 				varchar2
, p_doc_gb					varchar2
, p_alarm_cd 				varchar2
, p_error_description		varchar2

, p_post_approval_yn		varchar2
, p_main_doc_cd				varchar2
, p_grp_approval_userlist 	varchar2
, p_grp_alarm_userlist 		varchar2

, p_s_user_cd 				varchar2
, p_s_user_ip 				varchar2
)

    IS

    v_max_doc_cd    	varchar2(16);
    v_line_grp_cd 		number;

    v_ERROR 			EXCEPTION;

BEGIN

    if p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin' then
        BEGIN

            SELECT 'EZJ' || TO_CHAR(sysdate,'yyyymmdd') || LPAD(doc_master_seq.nextval,5,'0')
            INTO v_max_doc_cd
            FROM DUAL;

            r_doc_cd := v_max_doc_cd;

            insert into EZJOBS.ez_doc_master (
                doc_cd,
                doc_gb,
                user_cd,
                dept_nm,
                duty_nm,
                state_cd,
                draft_date,
                cur_approval_seq,
                post_approval_yn,
                main_doc_cd,

                ins_date,
                ins_user_cd,
                ins_user_ip,
                udt_date,
                udt_user_cd,
                udt_user_ip
            )
            values (
                       v_max_doc_cd,
                       '10',
                       p_s_user_cd,
                       (select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd ),
                       (select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd ),
                       '01',
                       sysdate,
                       1,
                       case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn end,
                       p_main_doc_cd,

                       sysdate,
                       p_s_user_cd,
                       p_s_user_ip,
                       sysdate,
                       p_s_user_cd,
                       p_s_user_ip
                   );


            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

            if p_flag ='draft' or p_flag ='post_draft' then
                BEGIN

                    -- 필수결재선 그룹 코드 GET
                    SELECT admin_line_grp_cd
                    INTO v_line_grp_cd
                    FROM EZJOBS.EZ_ADMIN_APPROVAL_GROUP
                    WHERE use_yn = 'Y'
                      AND post_approval_yn = case when p_flag = 'post_draft' then 'Y' else 'N' end
                      AND doc_gubun = p_doc_gb;

                    if SQL%ROWCOUNT < 1 then
                        BEGIN
                            r_code := '-1';
                            r_msg := 'ERROR.56';
                            RAISE v_ERROR;
                        END;
                    end if;

                    -- 결재선 셋팅 공통 함수 호출
                    -- 2023.06.03 강명준
                    SP_EZ_DOC_APPROVAL_SET_PRC(p_s_user_cd, p_s_user_ip, v_max_doc_cd, v_line_grp_cd, p_grp_approval_userList, p_grp_alarm_userlist);

                end;
            end if;

            if p_flag ='draft_admin' then
                begin
                    insert into EZJOBS.ez_approval_doc  (
                                                           doc_cd
                                                          ,seq
                                                          ,user_cd
                                                          ,dept_nm
                                                          ,duty_nm
                                                          ,approval_cd

                                                          ,ins_date
                                                          ,ins_user_cd
                                                          ,ins_user_ip

                    )values (
                                v_max_doc_cd
                            ,1
                            ,p_s_user_cd
                            ,(select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd )
                            ,(select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd )
                            ,'01'

                            ,current_timestamp
                            ,p_s_user_cd
                            ,p_s_user_ip
                            )
                    ;

                    if SQL%ROWCOUNT < 1 then
                        BEGIN
                            r_code := '-1';
                            r_msg := 'ERROR.01';
                            RAISE v_ERROR;
                        END;
                    end if;
                end;
            end if;

            insert into EZJOBS.ez_doc_10 (
                doc_cd,
                alarm_cd,
                data_center,
                job_name,
                error_description ,
                main_doc_cd,
                user_cd
            )
            values (
                       v_max_doc_cd,
                       p_alarm_cd,
                       p_data_center,
                       p_job_name,
                       p_error_description,
                       p_main_doc_cd,
                       p_s_user_cd
                   );

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