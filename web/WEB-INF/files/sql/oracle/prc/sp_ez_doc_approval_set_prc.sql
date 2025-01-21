CREATE OR REPLACE PROCEDURE ezjobs.SP_EZ_DOC_APPROVAL_SET_PRC
(
    p_s_user_cd 				varchar2,
    p_s_user_ip 				varchar2,
    p_v_max_doc_cd 				varchar2,
    p_v_line_grp_cd				NUMBER,
    p_grp_approval_userList 	varchar2,
    p_grp_alarm_userlist		varchar2
) is

    v_user_line_seq 		number;
    v_user_line_cnt			number;
    v_final_line_seq		number;
    v_approval_type			varchar2(2);

    v_ERROR EXCEPTION;

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
            rownum AS seq,
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
                     'U' as line_gb,
                     '' as approval_gb,
                     '01' as approval_type,
                     00 as group_line_grp_cd
             FROM  (
                       select p_v_max_doc_cd as max_doc_cd
                            ,approval_seq as seq
                            ,t0.approval_cd as user_cd
                            ,(select t2.dept_nm from ezjobs.EZ_user t1, ezjobs.EZ_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = t0.approval_cd ) AS dept_nm
                            ,(select t2.duty_nm from ezjobs.EZ_user t1, ezjobs.EZ_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = t0.approval_cd ) AS duty_nm
                            ,'01'
                            ,sysdate AS ins_date
                            ,p_s_user_cd AS s_user_cd
                            ,p_s_user_ip AS s_user_ip
                       from ezjobs.ez_user_approval_line t0, ezjobs.EZ_USER t1
                       where t0.approval_cd = t1.user_cd
                         AND t1.del_yn = 'N'
                         AND line_grp_cd = (select line_grp_cd
                                            from ezjobs.ez_user_approval_group
                                            where use_yn = 'Y'
                                              and owner_user_cd = p_s_user_cd)
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
                     line_gb,
                     approval_gb,
                     approval_type,
                     group_line_grp_cd
             FROM  (

                       SELECT p_v_max_doc_cd as max_doc_cd
                            ,t0.approval_seq AS seq
                            ,(CASE WHEN t0.approval_cd IS NULL THEN (CASE WHEN t0.group_line_grp_cd IS NULL THEN null ELSE t0.group_line_grp_cd END) ELSE t0.approval_cd END) AS user_cd
                            ,(CASE WHEN t0.approval_cd IS NULL THEN (CASE WHEN t0.group_line_grp_cd IS NULL THEN null ELSE 'GROUP' END) ELSE (select s2.dept_nm from ezjobs.EZ_user s1, ezjobs.EZ_dept s2 where s1.dept_cd = s2.dept_cd and s1.user_cd = t0.approval_cd ) END) AS dept_nm
                            ,(CASE WHEN t0.approval_cd IS NULL THEN (CASE WHEN t0.group_line_grp_cd IS NULL THEN null ELSE 'GROUP' END) ELSE (select s2.duty_nm from ezjobs.EZ_user s1, ezjobs.EZ_duty s2 where s1.duty_cd = s2.duty_cd and s1.user_cd = t0.approval_cd ) END) AS duty_nm
                            ,'01'
                            ,sysdate AS ins_date
                            ,p_s_user_cd AS s_user_cd
                            ,p_s_user_ip AS s_user_ip
                            ,'F' AS line_gb
                            ,t0.approval_gb
                            ,t0.approval_type
                            ,t0.group_line_grp_cd
                       FROM ezjobs.EZ_ADMIN_APPROVAL_LINE t0
                       WHERE t0.admin_line_grp_cd = p_v_line_grp_cd
                       ORDER BY t0.approval_seq
                   ) tb1
         )a1;

    if SQL%ROWCOUNT < 1 then
        BEGIN
            RAISE_APPLICATION_ERROR(-20001, '결재선을 확인해 주세요.');
        END;
    end if;

    -- user_cd 없는 seq : 개인결재선을 의미
    -- INSERT 된 결재선의 seq 조정에 필요
    SELECT MAX(seq)
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

        BEGIN
            RAISE_APPLICATION_ERROR(-20001, '개인결재선을 등록해 주세요.');
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
    select MAX(approval_type)
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
    UPDATE ezjobs.EZ_APPROVAL_DOC tb1
    SET grp_approval_userlist = ( SELECT group_cds
                                  FROM (
                                           SELECT group_cd, LISTAGG(user_cd, ',') WITHIN GROUP (ORDER BY user_cd) AS group_cds
                                           FROM (
                                                    SELECT SUBSTR(REGEXP_SUBSTR(p_grp_approval_userList, '[^,]+', 1, LEVEL), 1, INSTR(REGEXP_SUBSTR(p_grp_approval_userList, '[^,]+', 1, LEVEL), '-')-1) AS group_cd,
                                                           SUBSTR(REGEXP_SUBSTR(p_grp_approval_userList, '[^,]+', 1, LEVEL), INSTR(REGEXP_SUBSTR(p_grp_approval_userList, '[^,]+', 1, LEVEL), '-')+1) AS user_cd
                                                    FROM dual
                                                    CONNECT BY LEVEL <= REGEXP_COUNT(p_grp_approval_userList, ',') + 1
                                                )
                                           GROUP BY group_cd
                                           ORDER BY group_cd) tb2
                                  WHERE tb1.user_cd = tb2.group_cd )
    WHERE tb1.doc_cd = p_v_max_doc_cd
      AND tb1.dept_nm = 'GROUP';

    -- 결재권 설정 (통보)
    UPDATE ezjobs.EZ_APPROVAL_DOC tb1
    SET grp_alarm_userlist = ( SELECT group_cds
                               FROM (
                                        SELECT group_cd, LISTAGG(user_cd, ',') WITHIN GROUP (ORDER BY user_cd) AS group_cds
                                        FROM (
                                                 SELECT SUBSTR(REGEXP_SUBSTR(p_grp_alarm_userlist, '[^,]+', 1, LEVEL), 1, INSTR(REGEXP_SUBSTR(p_grp_alarm_userlist, '[^,]+', 1, LEVEL), '-')-1) AS group_cd,
                                                        SUBSTR(REGEXP_SUBSTR(p_grp_alarm_userlist, '[^,]+', 1, LEVEL), INSTR(REGEXP_SUBSTR(p_grp_alarm_userlist, '[^,]+', 1, LEVEL), '-')+1) AS user_cd
                                                 FROM dual
                                                 CONNECT BY LEVEL <= REGEXP_COUNT(p_grp_alarm_userlist, ',') + 1
                                             )
                                        GROUP BY group_cd
                                        ORDER BY group_cd) tb2
                               WHERE tb1.user_cd = tb2.group_cd )
    WHERE tb1.doc_cd = p_v_max_doc_cd
      AND tb1.dept_nm = 'GROUP';

    return;

END;