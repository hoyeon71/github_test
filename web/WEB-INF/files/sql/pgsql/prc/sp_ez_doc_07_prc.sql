CREATE OR REPLACE FUNCTION ezjobs.sp_ez_doc_07_prc(OUT r_code character varying, OUT r_msg character varying, OUT r_doc_cd character varying, p_flag character varying, p_doc_cd character varying, p_title character varying, p_content character varying, p_order_id character varying, p_odate character varying, p_data_center character varying, p_table_name character varying, p_application character varying, p_group_name character varying, p_job_name character varying, p_before_status character varying, p_after_status character varying, p_post_approval_time character varying, p_post_approval_yn character varying, p_description character varying, p_main_doc_cd character varying, p_grp_approval_userlist character varying, p_grp_alarm_userlist character varying, p_s_user_cd character varying, p_s_user_ip character varying)
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

    rec_affected 	numeric;

BEGIN

    if p_flag ='ins' or p_flag = 'draft' or p_flag = 'post_draft' or p_flag = 'draft_admin' then
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
                       '07',
                       p_s_user_cd::integer,
                       (select t2.dept_nm from ezjobs.ez_user t1, ezjobs.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd::integer ),
                       (select t2.duty_nm from ezjobs.ez_user t1, ezjobs.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd::integer ),
                       '01',
                       current_timestamp,
                       1,
                       case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn end,
                       p_main_doc_cd,

                       current_timestamp,
                       p_s_user_cd::integer,
                       p_s_user_ip,
                       current_timestamp,
                       p_s_user_cd::integer,
                       p_s_user_ip
                   );


            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.03';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;


            if p_flag = 'draft' or p_flag = 'post_draft' then

                begin

                    -- 필수결재선 그룹 코드 GET
                    SELECT admin_line_grp_cd
                    INTO v_line_grp_cd
                    FROM ezjobs.EZ_ADMIN_APPROVAL_GROUP
                    WHERE use_yn = 'Y'
                      AND post_approval_yn = case when p_flag = 'post_draft' then 'Y' else 'N' end
                      AND doc_gubun = '07';

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

            insert into ezjobs.ez_doc_07  (
                doc_cd,
                title,
                content,
                order_id,
                odate,
                data_center,
                table_name,
                application,
                group_name,
                job_name,
                before_status,
                after_status,
                description
            )
            values (
                       v_max_doc_cd,
                       --(CASE WHEN p_flag = 'post_draft_i' THEN '[후결]' ELSE '' END) || '[' || p_job_name || ']' || '상태 변경',
                       (CASE WHEN p_flag = 'draft_admin' then '[관리자 즉시결재]' ELSE p_title END),
                       p_content,
                       p_order_id,
                       p_odate,
                       p_data_center,
                       p_table_name,
                       p_application,
                       p_group_name,
                       p_job_name,
                       p_before_status,
                       p_after_status,
                       p_description
                   );

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.06';
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
        r_code := '-1';
        if r_msg IS NULL then
            r_msg := 'ERROR.01';
        end if;
    --r_code := '-2';
    --r_msg := SQLERRM;

END;
$function$
;
