CREATE OR REPLACE FUNCTION ezjobs.sp_ez_doc_approval_set_prc(p_s_user_cd character varying, p_s_user_ip character varying, p_v_max_doc_cd character varying, p_v_line_grp_cd numeric, p_grp_approval_userlist character varying, p_grp_alarm_userlist character varying)
    RETURNS numeric
    LANGUAGE plpgsql
AS $function$

DECLARE

    v_user_line_seq 			numeric;
    v_user_line_cnt				numeric;
    v_final_line_seq			numeric;
    v_approval_type				character(2);

    rec_affected 				numeric;

BEGIN

    -- 위에서 구한 그룹코드의 결재선을 문서 결재선으로 SET
    INSERT INTO ezjobs.EZ_APPROVAL_DOC  (
                                          doc_cd
                                         ,seq
                                         ,user_cd
                                         ,dept_nm
                                         ,duty_nm
                                         ,approval_cd

                                         ,ins_date
                                         ,ins_user_cd
                                         ,ins_user_ip
                                         ,line_gb
                                         ,approval_gb
                                         ,approval_type
                                         ,group_line_grp_cd
    )

    SELECT  max_doc_cd,
            row_number() over() AS seq,
            user_cd,
            dept_nm,
            duty_nm,
            '01',
            ins_date,
            s_user_cd,
            s_user_ip,
            line_gb,
            approval_gb,
            approval_type,
            group_line_grp_cd
    FROM (

             -- 사용자 결재선 INSERT
             SELECT  max_doc_cd,
                     seq,
                     user_cd,
                     dept_nm,
                     duty_nm,
                     '01',
                     ins_date,
                     s_user_cd,
                     s_user_ip,
                     'U'::text as line_gb,
                     ''::text as approval_gb,
                     '01'::text as approval_type,
                     00 as group_line_grp_cd
             FROM  (
                       select p_v_max_doc_cd::text as max_doc_cd
                            ,approval_seq as seq
                            ,t0.approval_cd as user_cd
                            ,(select t2.dept_nm from ezjobs.EZ_user t1, ezjobs.EZ_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = t0.approval_cd ) AS dept_nm
                            ,(select t2.duty_nm from ezjobs.EZ_user t1, ezjobs.EZ_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = t0.approval_cd ) AS duty_nm
                            ,'01'
                            ,current_timestamp AS ins_date
                            ,p_s_user_cd::integer AS s_user_cd
                            ,p_s_user_ip::text AS s_user_ip
                       from ezjobs.ez_user_approval_line t0, ezjobs.EZ_USER t1
                       where t0.approval_cd = t1.user_cd
                         AND t1.del_yn = 'N'
                         AND line_grp_cd = (select line_grp_cd
                                            from ezjobs.ez_user_approval_group
                                            where use_yn = 'Y'
                                              and owner_user_cd = p_s_user_cd::integer)
                       ORDER BY approval_seq
                   ) tb1

             UNION ALL

             -- 관리자 결재선 INSERT
             SELECT  max_doc_cd,
                     seq,
                     user_cd,
                     dept_nm,
                     duty_nm,
                     '01',
                     ins_date,
                     s_user_cd,
                     s_user_ip,
                     line_gb::text,
                     approval_gb::text,
                     approval_type::text,
                     group_line_grp_cd
             FROM  (

                       SELECT p_v_max_doc_cd::text as max_doc_cd
                            ,t0.approval_seq AS seq
                            ,(CASE WHEN t0.approval_cd IS NULL THEN (CASE WHEN t0.group_line_grp_cd IS NULL THEN null ELSE t0.group_line_grp_cd END) ELSE t0.approval_cd END) AS user_cd
                            ,(CASE WHEN t0.approval_cd IS NULL THEN (CASE WHEN t0.group_line_grp_cd IS NULL THEN null ELSE 'GROUP' END) ELSE (select s2.dept_nm from ezjobs.EZ_user s1, ezjobs.EZ_dept s2 where s1.dept_cd = s2.dept_cd and s1.user_cd = t0.approval_cd ) END) AS dept_nm
                            ,(CASE WHEN t0.approval_cd IS NULL THEN (CASE WHEN t0.group_line_grp_cd IS NULL THEN null ELSE 'GROUP' END) ELSE (select s2.duty_nm from ezjobs.EZ_user s1, ezjobs.EZ_duty s2 where s1.duty_cd = s2.duty_cd and s1.user_cd = t0.approval_cd ) END) AS duty_nm
                            ,'01'
                            ,current_timestamp AS ins_date
                            ,p_s_user_cd::integer AS s_user_cd
                            ,p_s_user_ip::text AS s_user_ip
                            ,'F' AS line_gb
                            ,t0.approval_gb
                            ,t0.approval_type
                            ,t0.group_line_grp_cd
                       FROM ezjobs.EZ_ADMIN_APPROVAL_LINE t0
                       WHERE t0.admin_line_grp_cd = p_v_line_grp_cd
                       ORDER BY t0.approval_seq
                   ) tb1
         )a1;

    GET DIAGNOSTICS rec_affected := ROW_COUNT;
    if rec_affected < 1 then
        begin
            --r_code := '-1';
            --r_msg := 'ERROR.56';
            --RAISE EXCEPTION 'rec_affected 0';
            RAISE EXCEPTION '결재선을 확인해 주세요.';
        end;
    end if;

    -- user_cd 없는 seq : 개인결재선을 의미
    -- INSERT 된 결재선의 seq 조정에 필요
    SELECT seq
    INTO v_user_line_seq
    FROM ezjobs.EZ_APPROVAL_DOC
    WHERE doc_cd = p_v_max_doc_cd
      AND user_cd is null;

    -- 사용자 결재선 갯수
    -- INSERT 된 결재선 중 필수결재선의 seq 조정에 필요
    SELECT count(*)
    INTO v_user_line_cnt
    FROM ezjobs.EZ_APPROVAL_DOC
    WHERE doc_cd = p_v_max_doc_cd
      AND line_gb = 'U';

    -- 필수결재선 중 개인결재선 seq보다 작은 갯수
    -- 사용자 결재선 seq 조정에 필요
    SELECT count(*)
    INTO v_final_line_seq
    FROM ezjobs.EZ_APPROVAL_DOC
    WHERE doc_cd = p_v_max_doc_cd
      AND line_gb = 'F'
      and seq < v_user_line_seq;

    -- 필수결재선에 개인결재가 있는데, 사용자결재선이 비어 있을 경우 오류 발생
    if v_user_line_seq is not null and v_user_line_cnt = 0 then

        begin
            --r_code := '-1';
            --r_msg := 'ERROR.56';
            --RAISE EXCEPTION 'rec_affected 0';
            RAISE EXCEPTION '개인결재선을 등록해 주세요.';
        end;

    end if;

    -- 개인결재선 삭제
    DELETE FROM ezjobs.EZ_APPROVAL_DOC
    WHERE doc_cd = p_v_max_doc_cd
      AND user_cd is null;

    -- 필수결재선에 개인결재선 없을 경우
    if v_user_line_seq is null then
        begin

            -- INSERT 한 사용자결재선 모두 제거
            DELETE FROM ezjobs.EZ_APPROVAL_DOC
            WHERE doc_cd = p_v_max_doc_cd
              AND line_gb = 'U';

            -- 남은 필수결재선 seq 모두 조정
            UPDATE ezjobs.EZ_APPROVAL_DOC
            SET seq = seq - v_user_line_cnt
            WHERE doc_cd = p_v_max_doc_cd
              AND line_gb = 'F';
        end;
    end if;

    -- seq 값 충돌 대비하여 임의 값 ADD
    update ezjobs.EZ_APPROVAL_DOC set seq = seq + 10 where doc_cd = p_v_max_doc_cd;

    -- seq 조정
    -- 필수결재선 중 개인결재선의 seq보다 작은 결재선 seq 조정
    UPDATE ezjobs.EZ_APPROVAL_DOC
    SET seq = seq - v_user_line_cnt - 10
    WHERE doc_cd = p_v_max_doc_cd
      AND line_gb = 'F'
      AND seq < v_user_line_seq + 10;

    -- seq 조정
    -- 필수결재선 중 개인결재선의 seq보다 큰 결재선 seq 조정
    UPDATE ezjobs.EZ_APPROVAL_DOC
    SET seq = seq - 1 - 10
    WHERE doc_cd = p_v_max_doc_cd
      AND line_gb = 'F'
      AND seq > v_user_line_seq + 10;

    -- seq 조정
    -- 사용자 결재선 seq와 필수결재선 seq 조합해서 사용자 결재선 seq 조정
    UPDATE ezjobs.EZ_APPROVAL_DOC
    SET seq = seq + v_final_line_seq - 10
    WHERE doc_cd = p_v_max_doc_cd
      AND line_gb = 'U';

    -- seq 조정
    -- 그 외 seq 모두 조정
    UPDATE ezjobs.EZ_APPROVAL_DOC
    SET seq = seq - 10
    WHERE doc_cd = p_v_max_doc_cd
      AND seq > 10;

    -- 개인결재선의 결재 유형 조회 (결재/후결)
    select approval_type
    into v_approval_type
    from ezjobs.ez_admin_approval_line
    where approval_gb = '01'
      and admin_line_grp_cd = p_v_line_grp_cd;

    -- 개인결재선의 결재 유형 조정 (결재/후결)
    UPDATE ezjobs.EZ_APPROVAL_DOC
    SET approval_type = v_approval_type
    WHERE doc_cd = p_v_max_doc_cd
      AND line_gb = 'U';

    -- 결재권 설정 (결재)
    update ezjobs.ez_approval_doc tb1
    set grp_approval_userlist = tb2.group_cds
        from (
                 select group_cd, ARRAY_TO_STRING(ARRAY_AGG(user_cd),',') as group_cds
                 from (
                          select split_part(unnest(string_to_array(p_grp_approval_userList, ',')), '-', 1) as group_cd,
                                 split_part(unnest(string_to_array(p_grp_approval_userList, ',')), '-', 2) as user_cd ) as t
                 group by group_cd
                 order by group_cd) tb2
	where tb1.user_cd::text = tb2.group_cd::text
	and tb1.doc_cd = p_v_max_doc_cd
	and tb1.dept_nm = 'GROUP';

    -- 결재권 설정 (통보)
    update ezjobs.ez_approval_doc tb1
    set grp_alarm_userlist = tb2.group_cds
        from (
                 select group_cd, ARRAY_TO_STRING(ARRAY_AGG(user_cd),',') as group_cds
                 from (
                          select split_part(unnest(string_to_array(p_grp_alarm_userList, ',')), '-', 1) as group_cd,
                                 split_part(unnest(string_to_array(p_grp_alarm_userList, ',')), '-', 2) as user_cd ) as t
                 group by group_cd
                 order by group_cd) tb2
	where tb1.user_cd::text = tb2.group_cd::text
	and tb1.doc_cd = p_v_max_doc_cd
	and tb1.dept_nm = 'GROUP';


    return 1;

END;
$function$
;
