CREATE OR REPLACE PROCEDURE EZJOBS.sp_ez_doc_approval_prc(

    r_code OUT varchar2
,  r_msg OUT varchar2
,  r_state_cd OUT varchar2
,  r_apply_cd OUT varchar2

, p_doc_cd varchar2
, p_doc_gb varchar2
, p_approval_cd varchar2
, p_approval_seq varchar2
, p_approval_comment varchar2
, p_flag varchar2
, p_seq varchar2
, p_user_cd varchar2
, p_apply_check varchar2
, p_main_doc_cd varchar2
, p_s_user_cd varchar2
, p_s_user_ip varchar2
)


    IS

    v_chk_cnt 			numeric;
    v_max_cnt 			numeric;
    v_max_inorder_cnt 	numeric;
    v_max_doc_cd    	varchar2(16);
    v_main_doc_cd_cnt	numeric;

    rec_affected 		numeric;
    v_ERROR				EXCEPTION;

    v_title 			character(2000);

BEGIN

    r_code := '1';
    r_msg := 'DEBUG.01';

    if p_approval_cd = '02' then
        begin
            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM EZJOBS.EZ_DOC_MASTER
            WHERE doc_cd = p_doc_cd
              AND apply_cd = '03';

            if v_chk_cnt = 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.73';
                    RAISE v_ERROR;
                end;
            end if;
        end;
    end if;

    if p_flag = 'user_update' then
        BEGIN

            UPDATE EZJOBS.EZ_APPROVAL_DOC SET
                                                user_cd = p_user_cd,
                                                dept_nm = (SELECT dept_nm FROM EZJOBS.EZ_DEPT WHERE dept_cd = ( SELECT dept_cd FROM EZJOBS.EZ_USER WHERE user_cd = p_user_cd )),
                                                duty_nm = (SELECT duty_nm FROM EZJOBS.EZ_DUTY WHERE duty_cd = ( SELECT duty_cd FROM EZJOBS.EZ_USER WHERE user_cd = p_user_cd ))
            WHERE doc_cd = p_doc_cd
              AND seq = p_seq;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    elsif p_flag = 'cancel_update' then
        BEGIN

            UPDATE EZJOBS.EZ_DOC_MASTER SET
                                              cancel_comment = p_approval_comment,
                                              apply_cd = '03'
            WHERE doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    elsif p_flag = 'batch_update' then
        BEGIN

            UPDATE EZJOBS.EZ_DOC_MASTER
            SET main_doc_cd = ( SELECT MAX(doc_cd)
                                FROM EZJOBS.EZ_DOC_MASTER
                                WHERE main_doc_cd = p_main_doc_cd )
            WHERE main_doc_cd = p_main_doc_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    elsif p_flag = 'order_id_update_02' then
        BEGIN

            UPDATE EZJOBS.EZ_DOC_02 SET
                order_id = p_seq
            WHERE doc_cd = p_doc_cd
              AND job_name = p_approval_comment;


            UPDATE EZJOBS.EZ_DOC_MASTER SET
                                              apply_cd = '02',
                                              apply_date = current_timestamp
            WHERE doc_cd = p_doc_cd;


            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    elsif p_flag = 'order_id_update_05' then
        BEGIN

            r_apply_cd := '02';
            r_code := '1';

            UPDATE EZJOBS.EZ_DOC_05 SET order_id = p_seq
            WHERE doc_cd = p_doc_cd
              AND job_name = p_approval_comment;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 오더 후 polling 결과에 오더 아이디가 없을 경우 반영실패로 간주
            if p_seq = '' or p_seq is null THEN
                UPDATE EZJOBS.EZ_DOC_MASTER
                SET apply_cd = '04', apply_date = current_timestamp
                WHERE doc_cd = p_doc_cd;
            else
                UPDATE EZJOBS.EZ_DOC_MASTER
                SET apply_cd = '02', apply_date = current_timestamp
                WHERE doc_cd = p_doc_cd;
            end if;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    elsif p_flag = 'def_cancel' then
        BEGIN
            r_msg := 'DEBUG.18';

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM EZJOBS.EZ_DOC_MASTER
            WHERE doc_cd = p_doc_cd
              AND (state_cd = '01'
                or state_cd = '02'
                or state_cd = '04');

            if v_chk_cnt < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.49';
                    RAISE v_ERROR;
                end;
            end if;

            if p_doc_gb = '05' or p_doc_gb = '07' or p_doc_gb = '08' or p_doc_gb = '09' or p_doc_gb = '10' then
                UPDATE EZJOBS.ez_doc_master
                SET del_yn = 'Y'
                where doc_cd = p_doc_cd;
            else
                UPDATE EZJOBS.EZ_DOC_MASTER SET state_cd = '00', apply_cd = '', draft_date = '', post_approval_yn = '', main_doc_cd = ''  WHERE doc_cd = p_doc_cd;
            end if;

            DELETE FROM EZJOBS.ez_approval_doc where doc_cd = p_doc_cd;

            if p_doc_gb = '01' then

                update EZJOBS.ez_doc_01
                set title = ''
                where doc_cd = p_doc_cd;

            elsif p_doc_gb = '02' THEN

                update EZJOBS.ez_doc_02
                set title = ''
                where doc_cd = p_doc_cd;

            elsif p_doc_gb = '03' THEN

                update EZJOBS.ez_doc_03
                set title = ''
                where doc_cd = p_doc_cd;

            elsif p_doc_gb = '04' then

                update EZJOBS.ez_doc_04
                set title = ''
                where doc_cd = p_doc_cd;

            elsif p_doc_gb = '09' THEN

                DELETE FROM EZJOBS.ez_doc_09 where doc_cd = p_doc_cd;

            elsif p_doc_gb = '10' then
                DELETE FROM EZJOBS.ez_doc_10 where doc_cd = p_doc_cd;
                DELETE FROM EZJOBS.EZ_DOC_MASTER where doc_cd = p_doc_cd;
            end if;
        END;

    elsif p_flag = 'approval_start' then
        BEGIN

            UPDATE EZJOBS.EZ_DOC_MASTER SET jobgroup_id = NVL(jobgroup_id, '') || 'A'
            WHERE doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    elsif p_flag = 'approval_end' then
        BEGIN

            UPDATE EZJOBS.EZ_DOC_MASTER SET jobgroup_id = REGEXP_REPLACE(jobgroup_id, 'A$', '')
            WHERE doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    elsif p_flag = 'insert_post_approval' OR p_flag = 'post_draft' then
        begin

            UPDATE EZJOBS.EZ_DOC_MASTER set
                                              -- 결재와 실행 분리를 위해 주석처리 원복
                                              apply_cd	= '01',
                                              apply_date	= current_timestamp
            WHERE doc_cd = p_doc_cd;

            r_code := '1';
            -- 결재와 실행 분리를 위해 주석처리 원복
            --r_state_cd := '02';

            --r_apply_cd := '02';

        END;

    elsif p_flag = 'doc08_admin' then
        BEGIN

            UPDATE EZJOBS.EZ_DOC_MASTER SET
                apply_cd			= p_apply_check
                                            ,apply_date			= null
                                            ,admin_approval_yn 	= 'Y'
                                            ,state_cd 			= '02'
            WHERE doc_cd = p_doc_cd;

        END;

    elsif p_flag ='del' then
        begin
            r_msg := 'DEBUG.19';

            UPDATE EZJOBS.ez_doc_master
            SET del_yn = 'Y'
            where doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;
        end;

        -- 반영시점에 실행 후 진행
    elsif p_flag = 'exec' then
        begin
            r_apply_cd := '02';
            UPDATE EZJOBS.EZ_DOC_MASTER SET
                apply_cd	= '02'
                                            , apply_date	= current_timestamp
            WHERE doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;
        end;

    elsif p_flag = 'exec_cancel' then
        begin
            UPDATE EZJOBS.EZ_DOC_MASTER SET
                apply_cd	= '03'
                                            , apply_date	= current_timestamp
            WHERE doc_cd = p_doc_cd;
        end;

        -- 그룹 문서에서 재반영에 모두 성공이 메인 doc_cd의 apply_cd값을 반영완료로 update
    elsif p_flag = 'retry_ok' then
        begin
            UPDATE EZJOBS.EZ_DOC_MASTER SET
                apply_cd		= '02'
            WHERE doc_cd = p_doc_cd;
        end;

        -- 그룹 오더 반영 실패 시 해당 플래그 처리 (2023.07.10 강명준)
    elsif p_flag = 'group_order_exec_fail' then
        begin
            r_apply_cd := '02';
            UPDATE EZJOBS.EZ_DOC_MASTER SET
                apply_cd		= '04'
                                            , apply_date	= current_timestamp
                                            , fail_comment	= p_approval_comment
            WHERE doc_cd = p_doc_cd;
        end;

    elsif p_flag = 'group_approval_end' then
        BEGIN

            -- 중복결재 방지 플래그 원복
            /*
            UPDATE EZJOBS_SIC.EZ_DOC_MASTER SET jobgroup_id = replace(NVL(jobgroup_id, ''),'A','')
              WHERE doc_cd = p_doc_cd;
             */
            -- 위처럼 중복체크를 위한 문자열 'A'를  모두 지워 버리면 중복체크 연속 2회 걸릴 경우 통과 되므로 마지막 A 문자열만 제거할 수 있게 개선 (2023.12.04 강명준)
            UPDATE EZJOBS.EZ_DOC_MASTER SET jobgroup_id = REGEXP_REPLACE(jobgroup_id, 'A$', '')
            WHERE doc_cd = p_doc_cd;

            -- 반영 상태 업데이트
            -- 그룹 안의 문서가 한개라도 반영성공이면 메인 요청서 반영성공 처리
            -- 그룹 안의 문서가 모두 반영실패면 메인 요청서 반영실패 처리
            UPDATE EZJOBS.EZ_DOC_MASTER
            SET apply_cd 		= (CASE WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = p_doc_cd and apply_cd IS NULL) > 0 THEN ''
                                        WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = p_doc_cd and apply_cd IS NOT NULL AND apply_cd = '02') > 0 THEN '02'
                                        WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = p_doc_cd and apply_cd IS NOT NULL AND apply_cd = '02') = 0 THEN '04'
                                        ELSE '' END),
                apply_date	= (CASE WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = p_doc_cd and apply_cd IS NOT NULL) > 0 THEN current_timestamp ELSE NULL END)
            WHERE doc_cd = p_doc_cd;

            -- apply_cd 가 존재하면
            SELECT apply_cd
            INTO r_apply_cd
            FROM EZJOBS.EZ_DOC_MASTER
            WHERE doc_cd = p_doc_cd;

            -- 메인 요청서 안의 작업들이 반영실패일 경우 요청서가 롤백된다.
            -- 롤백 되면 cur_approval_seq 업데이트도 롤백이 되는데, 메인 요청서는 결재 처리가 되기 때문에 다음 결재 시 문제 생김
            -- 메인 요청서의 cur_approval_seq 로 그 안의 요청서를 동기화 시켜 주는 작업 진행 (2023.10.16 강명준)
            UPDATE EZJOBS.EZ_DOC_MASTER SET cur_approval_seq = (SELECT cur_approval_seq FROM EZJOBS.EZ_DOC_MASTER WHERE doc_cd = p_doc_cd)
            WHERE main_doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        END;

    else
        BEGIN

            -- 중복 결재 방지
            SELECT COUNT(*) INTO v_max_cnt
            FROM EZJOBS.EZ_APPROVAL_DOC
            WHERE doc_cd = p_doc_cd
              AND seq = p_approval_seq
              AND approval_date IS NOT NULL;

            if v_max_cnt > 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.49';
                    RAISE v_ERROR;
                end;
            end if;

            UPDATE EZJOBS.EZ_APPROVAL_DOC SET
                approval_cd 		= p_approval_cd
                                              ,approval_date 	= current_timestamp
                                              ,approval_comment = p_approval_comment
                                              ,udt_date 		= current_timestamp
                                              ,udt_user_cd 		= p_s_user_cd
                                              ,udt_user_ip 		= p_s_user_ip
            WHERE doc_cd 	= p_doc_cd
              AND seq 		= p_approval_seq;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 결재 처리
            if p_approval_cd ='02' then
                begin
                    r_msg := 'DEBUG.16';

                    -- MAX 결재 카운트
                    SELECT MAX(seq)
                    INTO v_max_cnt
                    FROM EZJOBS.EZ_APPROVAL_DOC
                    WHERE doc_cd = p_doc_cd;

                    -- MAX 순차 결재 카운트
                    SELECT MAX(seq)
                    INTO v_max_inorder_cnt
                    FROM EZJOBS.EZ_APPROVAL_DOC
                    WHERE doc_cd = p_doc_cd
                      AND (approval_type = '01' OR APPROVAL_TYPE is null );

                    -- 일괄요청서 카운트
                    SELECT count(*)
                    INTO v_main_doc_cd_cnt
                    FROM EZJOBS.EZ_DOC_MASTER
                    WHERE main_doc_cd = p_doc_cd;

                    -- 관리자결재
                    if (p_flag = 'draft_admin'OR p_flag = 'verify') then

                        r_state_cd := '02';
                        -- 결재와 실행 분리를 위해 주석처리 원복
                        --r_apply_cd := '02';
                        UPDATE EZJOBS.EZ_DOC_MASTER SET
                                                          apply_cd			    = '01',
                                                          apply_date			= null,
                                                          admin_approval_yn 	= 'Y',
                                                          fail_comment 		    = ''
                        WHERE doc_cd = p_doc_cd;

                        -- 예약상태변경일 경우 반영상태 원복
                        if p_doc_gb = '08' then
                            begin
                                UPDATE EZJOBS.EZ_DOC_MASTER SET
                                                                  apply_cd		= '01',
                                                                  apply_date		= null
                                WHERE doc_cd = p_doc_cd;

                                if SQL%ROWCOUNT < 1 then
                                    begin
                                        r_code := '-1';
                                        r_msg := 'ERROR.01';
                                        RAISE v_ERROR;
                                    end;
                                end if;
                            end;
                        end if;

                        -- 일괄문서일 경우 문서 내 단 건에도 반영대기 적용
                        if v_main_doc_cd_cnt > 0 then
                            begin
                                UPDATE EZJOBS.EZ_DOC_MASTER SET
                                                                  apply_cd		= '01',
                                                                  apply_date	= null
                                WHERE main_doc_cd = p_doc_cd;

                                if SQL%ROWCOUNT < 1 then
                                    begin
                                        r_code := '-1';
                                        r_msg := 'ERROR.01';
                                        RAISE v_ERROR;
                                    end;
                                end if;
                            end;
                        end if;

                    end if;

                    -- 최종 결재가 아닐 경우
                    if p_approval_seq < v_max_cnt THEN

                        begin
                            r_state_cd := '01';
                            UPDATE EZJOBS.EZ_DOC_MASTER SET
                                cur_approval_seq 	= p_approval_seq + 1
                                                            ,udt_date 			= current_timestamp
                                                            ,udt_user_cd 		= p_s_user_cd
                                                            ,udt_user_ip 		= p_s_user_ip
                            WHERE doc_cd = p_doc_cd;

                            if SQL%ROWCOUNT < 1 then
                                begin
                                    r_code := '-1';
                                    r_msg := 'ERROR.01';
                                    RAISE v_ERROR;
                                end;
                            end if;

                            -- 후결그룹의 C-M ORDER 시점 (마지막 순차결재일 때)
                            if p_approval_seq = v_max_inorder_cnt then
                                begin
                                    -- 반영 및 통보 하기 위한 리턴값
                                    --r_apply_cd := '02';

                                    UPDATE EZJOBS.EZ_DOC_MASTER set
                                        cur_approval_seq 	= p_approval_seq + 1
                                                                    --,apply_cd			= '02'
                                                                    ,apply_cd			= '01'
                                                                    ,apply_date			= null
                                                                    ,udt_user_cd 		= p_s_user_cd
                                                                    ,udt_user_ip 		= p_s_user_ip
                                                                    ,fail_comment 		= ''
                                    WHERE doc_cd = p_doc_cd;

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
                        -- 최종결재
                    else
                        begin

                            UPDATE EZJOBS.EZ_DOC_MASTER SET
                                state_cd 		= '02'
                                                            ,udt_date 		= current_timestamp
                                                            ,udt_user_cd 	= p_s_user_cd
                                                            ,udt_user_ip 	= p_s_user_ip

                            WHERE doc_cd = p_doc_cd;

                            if SQL%ROWCOUNT < 1 then
                                begin
                                    r_code := '-1';
                                    r_msg := 'ERROR.01';
                                    RAISE v_ERROR;
                                end;
                            end if;

                            --순차그룹의 최종결재일때만 C-M ORDER 및 적용일자 업데이트
                            if v_max_inorder_cnt = v_max_cnt THEN

                                -- 결재와 실행 분리를 위해 주석처리 원복
                                -- r_apply_cd := '02';

                                UPDATE EZJOBS.EZ_DOC_MASTER set
                                                                --apply_cd		= '02'
                                                                --반영대기 상태로 udt
                                    apply_cd		= '01'
                                                                ,apply_date		= null
                                                                ,udt_user_cd 	= p_s_user_cd
                                                                ,udt_user_ip 	= p_s_user_ip
                                                                ,fail_comment 	= ''
                                WHERE doc_cd = p_doc_cd;

                                if SQL%ROWCOUNT < 1 then
                                    begin
                                        r_code := '-1';
                                        r_msg := 'ERROR.01';
                                        RAISE v_ERROR;
                                    end;
                                end if;
                            end if;

                            -- 예약상태변경일 경우 반영상태 원복
                            if p_doc_gb = '08' then
                                begin

                                    UPDATE EZJOBS.EZ_DOC_MASTER SET
                                        apply_cd		= '01'
                                                                    ,apply_date		= null
                                    WHERE doc_cd = p_doc_cd;

                                    if SQL%ROWCOUNT < 1 then
                                        begin
                                            r_code := '-1';
                                            r_msg := 'ERROR.01';
                                            RAISE v_ERROR;
                                        end;
                                    end if;

                                end;
                            end if;

                            -- 일괄문서일 경우 문서 내 단 건에도 반영대기 적용
                            if v_main_doc_cd_cnt > 0 then
                                begin

                                    UPDATE EZJOBS.EZ_DOC_MASTER SET
                                        apply_cd		= '01'
                                                                    ,apply_date		= null
                                    WHERE main_doc_cd = p_doc_cd;

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

                end;

                -- 결재 외의 상태 (반려 등)
            else
                begin
                    r_state_cd := '04';
                    r_msg := 'DEBUG.20';

                    UPDATE EZJOBS.EZ_DOC_MASTER SET
                        state_cd 		= p_approval_cd
                                                    ,udt_date 		= current_timestamp
                                                    ,udt_user_cd 	= p_s_user_cd
                                                    ,udt_user_ip 	= p_s_user_ip
                    WHERE doc_cd = p_doc_cd;

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

    return;

EXCEPTION
    WHEN v_ERROR THEN
        ROLLBACK;
    WHEN OTHERS THEN
        r_code := '-2';
        r_msg := '[' || SQLCODE || '] ' || SQLERRM;
        ROLLBACK;

END;