CREATE OR REPLACE PROCEDURE EZJOBS.sp_ez_doc_05_prc
(
    r_code 					OUT varchar2,
    r_msg 					OUT varchar2,
    r_doc_cd 				OUT varchar2,

    p_flag 					varchar2,
    p_doc_cd 				varchar2,
    p_jobgroup_id 			varchar2,
    p_title 				varchar2,
    p_content 				varchar2,
    p_table_id 				varchar2,
    p_job_id 				varchar2,
    p_data_center 			varchar2,
    p_table_name 			varchar2,
    p_application 			varchar2,
    p_group_name 			varchar2,
    p_mem_name 				varchar2,
    p_job_name 				varchar2,
    p_hold_yn 				varchar2,
    p_force_yn 				varchar2,
    p_order_date 			varchar2,
    p_from_time 			varchar2,
    p_cmd_line2 			varchar2,
    p_t_set 				varchar2,
    p_apply_check 			varchar2,
    p_wait_for_odate_yn 	varchar2,
    p_post_approval_time 	varchar2,
    p_post_approval_yn 		varchar2,
    p_s_user_cd 			varchar2,
    p_s_user_ip 			varchar2,
    p_doc_cds 				varchar2,
    p_main_doc_cd 			varchar2,
    p_grp_approval_userlist varchar2,
    p_grp_alarm_userlist 	varchar2,
    p_order_into_folder 	varchar2
)

    IS

    v_user_line_cnt 		number;
    v_final_line_seq   		number;
    v_max_doc_cd    		varchar2(16);

    v_line_grp_cd 			number;
    v_user_cd 				number;
    v_approval_gb 			varchar2(2);
    idx 					number;
    v_user_line_seq 		number;
    v_approval_type 		varchar2(2);

    v_ERROR 				EXCEPTION;

BEGIN

    if p_flag ='doc_group_insert' then
        begin

            insert into EZJOBS.ez_doc_group (
                doc_group_id,
                jobgroup_id,
                doc_group_name
            )
            values (
                       (SELECT 'DG' || NVL(MAX(REPLACE(doc_group_id, 'DG', '')+1), 1) FROM EZJOBS.ez_doc_group),
                       p_jobgroup_id,
                       '[' || p_jobgroup_id || ']' || '작업 ORDER'
                   );

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

        end;
    end if;

    --draft: 승인	/	post_draft: 후결 승인
    if p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin' then
        begin

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
                ins_date,
                ins_user_cd,
                ins_user_ip,
                udt_date,
                udt_user_cd,
                udt_user_ip,
                jobgroup_id,
                main_doc_cd
            )
            values (
                       v_max_doc_cd,
                       '05',
                       p_s_user_cd,
                       (select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd ),
                       (select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd ),
                       '01',
                       sysdate,
                       1,
                       case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn end,
                       sysdate,
                       p_s_user_cd,
                       p_s_user_ip,
                       sysdate,
                       p_s_user_cd,
                       p_s_user_ip,
                       p_jobgroup_id,
                       p_main_doc_cd
                   );


            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

            if p_flag ='draft' or p_flag ='post_draft' then

                begin

                    -- 필수결재선 그룹 코드 GET
                    SELECT admin_line_grp_cd
                    INTO v_line_grp_cd
                    FROM EZJOBS.EZ_ADMIN_APPROVAL_GROUP
                    WHERE use_yn = 'Y'
                      AND post_approval_yn = case when p_flag = 'post_draft' then 'Y' else 'N' end
                      AND doc_gubun = '05';

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

                            ,sysdate
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

            insert into EZJOBS.ez_doc_05  (
                doc_cd,
                doc_group_id,
                title,
                content,
                table_id,
                job_id,
                data_center,
                table_name,
                application,
                group_name,
                mem_name,
                job_name,
                hold_yn,
                force_yn,
                wait_for_odate_yn,
                order_date,
                from_time,
                cmd_line2,
                t_set,
                apply_check,
                description,
                order_into_folder
            )
            values (
                       v_max_doc_cd,
                       (CASE WHEN p_jobgroup_id IS NOT NULL THEN
                                 ( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '') +0) FROM EZJOBS.ez_doc_group WHERE jobgroup_id = p_jobgroup_id ) ELSE '' END),
                       (CASE WHEN p_flag = 'draft_admin' then '[관리자 즉시결재]' ELSE p_title END),
                       p_content,
                       (case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as number) else 0 end),
                       (case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as number) else 0 end),
                       p_data_center,
                       p_table_name,
                       P_application,
                       p_group_name,
                       p_mem_name,
                       p_job_name,
                       p_hold_yn,
                       p_force_yn,
                       p_wait_for_odate_yn,
                       p_order_date,
                       p_from_time,
                       p_cmd_line2,
                       p_t_set,
                       p_apply_check,
                       (select description from emuser.def_job where job_name = p_job_name),
                       p_order_into_folder
                   );

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

        end;
    end if;
    --전북은행 그룹Order 프로시저 추가(23.01.06)
    if p_flag ='group_draft' or p_flag = 'group_post_draft' or p_flag = 'group_draft_admin' then
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
                ins_date,
                ins_user_cd,
                ins_user_ip,
                doc_group_id
            )
            values (
                       v_max_doc_cd,
                       '05',
                       p_s_user_cd ,
                       (select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd  ),
                       (select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd  ),
                       '01',
                       sysdate,
                       1,
                       case when p_flag = 'group_draft_admin' then 'A' else p_post_approval_yn end,
                       sysdate,
                       p_s_user_cd ,
                       p_s_user_ip,
                       ( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '') +0)  FROM EZJOBS.ez_doc_group WHERE jobgroup_id = p_jobgroup_id )
                   );
            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;


            if p_flag ='group_draft' or p_flag = 'group_post_draft' then
                begin
                    -- 필수결재선 그룹 코드 GET
                    SELECT admin_line_grp_cd
                    INTO v_line_grp_cd
                    FROM EZJOBS.EZ_ADMIN_APPROVAL_GROUP
                    WHERE use_yn = 'Y'
                      AND post_approval_yn = case when p_flag = 'post_draft' then 'Y' else 'N' end
                      AND doc_gubun = '01';

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

            if p_flag ='group_draft_admin' then
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
                            ,(select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd  )
                            ,(select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd  )
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

            insert into EZJOBS.ez_doc_05  (
                doc_cd,
                doc_group_id,
                title,
                content,
                table_id,
                job_id,
                data_center,
                table_name,
                mem_name,
                job_name,
                hold_yn,
                force_yn,
                order_date,
                from_time,
                cmd_line2,
                t_set,
                apply_check
            )
            values (
                       v_max_doc_cd,
                       (CASE WHEN p_jobgroup_id IS NOT NULL THEN
                                 ( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '') +0) FROM EZJOBS.ez_doc_group WHERE jobgroup_id = p_jobgroup_id ) ELSE '' END),
                       (CASE WHEN p_flag = 'group_draft_admin' then '[관리자 즉시결재]' ELSE p_title END) ,
                       p_content,
                       (case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end)  ,
                       (case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end) ,
                       p_data_center,
                       p_table_name,
                       p_mem_name,
                       '[그룹 ORDER]' || ( SELECT jobgroup_name FROM EZJOBS.EZ_JOBGROUP WHERE jobgroup_id = p_jobgroup_id ),
                       p_hold_yn,
                       p_force_yn,
                       p_order_date,
                       p_from_time,
                       p_cmd_line2,
                       p_t_set,
                       p_apply_check
                   );
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