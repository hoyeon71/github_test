CREATE OR REPLACE FUNCTION ezjobs.sp_ez_doc_05_prc(OUT r_code character varying, OUT r_msg character varying, OUT r_doc_cd character varying, p_flag character varying, p_doc_cd character varying, p_jobgroup_id character varying, p_title character varying, p_content character varying, p_table_id character varying, p_job_id character varying, p_data_center character varying, p_table_name character varying, p_application character varying, p_group_name character varying, p_mem_name character varying, p_job_name character varying, p_hold_yn character varying, p_force_yn character varying, p_order_date character varying, p_from_time character varying, p_cmd_line2 character varying, p_t_set character varying, p_apply_check character varying, p_wait_for_odate_yn character varying, p_post_approval_time character varying, p_post_approval_yn character varying, p_s_user_cd character varying, p_s_user_ip character varying, p_doc_cds character varying, p_main_doc_cd character varying, p_grp_approval_userlist character varying, p_grp_alarm_userlist character varying, p_order_into_folder character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_user_line_cnt 	numeric;
    v_final_line_seq   	numeric;
    v_max_doc_cd    	character varying(16);

    v_line_grp_cd 		int4;
    v_user_cd 			int4;
    v_approval_gb 		character(2);
    idx 				integer;
    v_user_line_seq 	integer;
    v_approval_type 	character(2);

    rec_affected 		numeric;

BEGIN

    if p_flag ='doc_group_insert' then
        begin

            insert into ezjobs.ez_doc_group (
                doc_group_id,
                jobgroup_id,
                doc_group_name
            )
            values (
                       (SELECT 'DG' || COALESCE(MAX(REPLACE(doc_group_id, 'DG', '')::integer+1), 1) FROM ezjobs.ez_doc_group),
                       p_jobgroup_id,
                       '[' || p_jobgroup_id || ']' || '작업 ORDER'
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

    --draft: 승인	/	post_draft: 후결 승인
    if p_flag = 'draft' or p_flag = 'post_draft' or p_flag = 'draft_admin' then
        begin
            SELECT 'EZJ' || TO_CHAR(current_timestamp,'yyyymmdd') || LPAD(nextval('ezjobs.doc_master_seq')::text,5,'0')
            INTO v_max_doc_cd;

            r_doc_cd := v_max_doc_cd;

            insert into ezjobs.ez_doc_master (
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
                       p_s_user_cd::integer,
                       (select t2.dept_nm from ezjobs.ez_user t1, ezjobs.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd::integer ),
                       (select t2.duty_nm from ezjobs.ez_user t1, ezjobs.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd::integer ),
                       '01',
                       current_timestamp,
                       1,
                       case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn end,
                       current_timestamp,
                       p_s_user_cd::integer,
                       p_s_user_ip,
                       current_timestamp,
                       p_s_user_cd::integer,
                       p_s_user_ip,
                       p_jobgroup_id,
                       p_main_doc_cd
                   );


            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            if p_flag ='draft' or p_flag ='post_draft' then

                begin

                    -- 필수결재선 그룹 코드 GET
                    SELECT admin_line_grp_cd
                    INTO v_line_grp_cd
                    FROM ezjobs.EZ_ADMIN_APPROVAL_GROUP
                    WHERE use_yn = 'Y'
                      AND post_approval_yn = case when p_flag = 'post_draft' then 'Y' else 'N' end
                      AND doc_gubun = '05';

                    GET DIAGNOSTICS rec_affected := ROW_COUNT;
                    if rec_affected < 1 then
                        begin
                            r_code := '-1';
                            r_msg := 'ERROR.56';
                            RAISE EXCEPTION 'rec_affected 0';
                        end;
                    end if;

                    -- 결재선 셋팅 공통 함수 호출
                    -- 2023.06.27 강명준
                    rec_affected := (select ezjobs.SP_EZ_DOC_APPROVAL_SET_PRC(p_s_user_cd, p_s_user_ip, v_max_doc_cd, v_line_grp_cd, p_grp_approval_userList, p_grp_alarm_userlist));

                end;
            end if;




            if p_flag = 'draft_admin' then

                begin


                    insert into ezjobs.ez_approval_doc  (
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
                            ,p_s_user_cd::integer
                            ,(select t2.dept_nm from ezjobs.ez_user t1, ezjobs.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd::integer )
                            ,(select t2.duty_nm from ezjobs.ez_user t1, ezjobs.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd::integer )
                            ,'01'

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



            insert into ezjobs.ez_doc_05  (
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
                       --( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '')::integer+0) FROM ezjobs.ez_doc_group WHERE jobgroup_id = p_jobgroup_id ),
                       (CASE WHEN p_jobgroup_id IS NOT NULL THEN
                                 ( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '')::integer + 0) FROM ezjobs.ez_doc_group WHERE jobgroup_id = p_jobgroup_id ) ELSE '' END),
                       (CASE WHEN p_flag = 'draft_admin' then '[관리자 즉시결재]' ELSE p_title END),
                       p_content,
                       (case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end) ,
                       (case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end),
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
                       (select description from def_job where job_name = p_job_name),
                       p_order_into_folder

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

    --전북은행 그룹Order 프로시저 추가(23.01.06)
    if p_flag ='group_draft' or p_flag = 'group_post_draft' or p_flag = 'group_draft_admin' then
        begin

            SELECT 'EZJ' || TO_CHAR(current_timestamp,'yyyymmdd') || LPAD(nextval('ezjobs.doc_master_seq')::text,5,'0')
            INTO v_max_doc_cd;

            r_doc_cd := v_max_doc_cd;

            insert into ezjobs.ez_doc_master (
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
                doc_group_id
            )
            values (
                       v_max_doc_cd,
                       '05',
                       p_s_user_cd::integer,
                       (select t2.dept_nm from ezjobs.ez_user t1, ezjobs.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd::integer ),
                       (select t2.duty_nm from ezjobs.ez_user t1, ezjobs.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd::integer ),
                       '01',
                       now(),
                       1,
                       case when p_flag = 'group_draft_admin' then 'A' else p_post_approval_yn end,
                       now(),
                       p_s_user_cd::integer,
                       p_s_user_ip,
                       now(),
                       p_s_user_cd::integer,
                       p_s_user_ip,
                       --( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '')::integer+0)::text FROM ezjobs.ez_doc_group WHERE jobgroup_id = p_jobgroup_id )
                       (CASE WHEN p_jobgroup_id IS NOT NULL THEN
                                 ( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '')::integer +0) FROM ezjobs.ez_doc_group WHERE jobgroup_id = p_jobgroup_id ) ELSE '' END)
                   );

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            if p_flag ='group_draft' or p_flag = 'group_post_draft' then
                begin
                    -- 필수결재선 그룹 코드 GET
                    SELECT admin_line_grp_cd
                    INTO v_line_grp_cd
                    FROM ezjobs.EZ_ADMIN_APPROVAL_GROUP
                    WHERE use_yn = 'Y'
                      AND post_approval_yn = (case when p_flag = 'group_post_draft' then 'Y' else 'N' end)
                      AND doc_gubun = '05';

                    GET DIAGNOSTICS rec_affected := ROW_COUNT;
                    if rec_affected < 1 then
                        begin
                            r_code := '-1';
                            r_msg := 'ERROR.56';
                            RAISE EXCEPTION 'rec_affected 0';
                        end;
                    end if;

                    -- 결재선 셋팅 공통 함수 호출
                    -- 2023.06.27 강명준
                    rec_affected := (select ezjobs.SP_EZ_DOC_APPROVAL_SET_PRC(p_s_user_cd, p_s_user_ip, v_max_doc_cd, v_line_grp_cd, p_grp_approval_userList, p_grp_alarm_userlist));

                end;
            end if;

            if p_flag ='group_draft_admin' then
                begin
                    insert into ezjobs.ez_approval_doc  (
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
                            ,p_s_user_cd::integer
                            ,(select t2.dept_nm from ezjobs.ez_user t1, ezjobs.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd::integer )
                            ,(select t2.duty_nm from ezjobs.ez_user t1, ezjobs.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd::integer )
                            ,'01'

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

            insert into ezjobs.ez_doc_05  (
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
                       --( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '')::integer+0) FROM ezjobs.ez_doc_group WHERE jobgroup_id = p_jobgroup_id ),
                       (CASE WHEN p_jobgroup_id IS NOT NULL THEN
                                 ( SELECT 'DG' || MAX(REPLACE(doc_group_id, 'DG', '')::integer +0) FROM ezjobs.ez_doc_group WHERE jobgroup_id = p_jobgroup_id ) ELSE '' END),
                       (CASE WHEN p_flag = 'group_draft_admin' then '[관리자 즉시결재]' ELSE p_title END) ,
                       p_content,
                       (case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end)::integer ,
                       (case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end)::integer,
                       p_data_center,
                       p_table_name,
                       p_mem_name,
                       '[그룹 ORDER]' || ( SELECT jobgroup_name FROM ezjobs.EZ_JOBGROUP WHERE jobgroup_id = p_jobgroup_id ),
                       p_hold_yn,
                       p_force_yn,
                       p_order_date,
                       p_from_time,
                       p_cmd_line2,
                       p_t_set,
                       p_apply_check
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
