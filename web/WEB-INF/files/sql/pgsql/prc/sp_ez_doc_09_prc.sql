CREATE OR REPLACE FUNCTION ezjobs.sp_ez_doc_09_prc(OUT r_code character varying, OUT r_msg character varying, OUT r_doc_cd character varying, p_flag character varying, p_doc_cd character varying, p_title character varying, p_data_center character varying, p_job_name character varying, p_doc_gb character varying, p_post_approval_yn character varying, p_grp_approval_userlist character varying, p_grp_alarm_userlist character varying, p_s_user_cd character varying, p_s_user_ip character varying)
    RETURNS record
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_max_doc_cd    	character varying(16);
    v_line_grp_cd 		int4;

    rec_affected 	numeric;

BEGIN

    if p_flag = 'draft' or p_flag = 'post_draft' or p_flag = 'draft_admin' then
        BEGIN

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
                udt_user_ip
            )
            values (
                       v_max_doc_cd,
                       '09',
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
                       p_s_user_ip
                   );


            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
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
                      AND post_approval_yn = (case when p_flag = 'post_draft_i' or p_flag ='post_draft_u' or p_flag = 'post_draft' then 'Y' else 'N' end)
                      AND doc_gubun = p_doc_gb;

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


            -- doc_09 일괄요청서 껍데기의 정보 관리 위해 생성
            insert into ezjobs.ez_doc_09 (
                doc_cd,
                job_name,
                data_center,
                doc_gb,
                title
            )
            values (
                       v_max_doc_cd,
                       p_job_name,
                       p_data_center,
                       p_doc_gb,
                       (CASE WHEN p_flag = 'draft_admin'  then '[관리자 즉시결재]' ELSE p_title END)
                   );

        end;

    end if;

    if p_flag ='udt' then
        begin

            UPDATE ezjobs.ez_doc_09 SET job_name = p_job_name
            WHERE doc_cd = p_doc_cd;

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

            delete from ezjobs.ez_approval_doc where doc_cd = p_doc_cd;


            delete from ezjobs.ez_doc_09 where doc_cd = p_doc_cd;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.56';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            delete from ezjobs.ez_doc_master where doc_cd = p_doc_cd;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.56';
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
