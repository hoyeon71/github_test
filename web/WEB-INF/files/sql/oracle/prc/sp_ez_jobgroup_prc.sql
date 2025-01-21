CREATE OR REPLACE PROCEDURE ezjobs.sp_ez_jobgroup_prc
(
    r_code OUT 		varchar2,
    r_msg  OUT 		varchar2,

    p_flag 			varchar2,
    p_table_id 		varchar2,
    p_job_id 		varchar2,
    p_data_center 	varchar2,
    p_job_name 		varchar2,
    p_user_cd 		varchar2,
    p_jobgroup_id 	varchar2,
    p_jobgroup_name	varchar2,
    p_content 		varchar2,
    p_table_name 	varchar2,
    p_application	varchar2,
    p_group_name	varchar2

)

    IS

    v_chk_cnt 		number;
    v_table_id 		number;
    v_job_id 		number;

    v_ERROR 		EXCEPTION;

BEGIN

    if p_flag ='detail_insert' then
        begin

            INSERT INTO ezjobs.EZ_JOBGROUP_JOB (
                jobgroup_id,
                table_id,
                job_id,
                data_center,
                job_name,
                table_name,
                application,
                group_name,
                ins_date
            )
            VALUES (
                       p_jobgroup_id,
                       p_table_id,
                       p_job_id,
                       p_data_center,
                       p_job_name,
                       p_table_name,
                       p_application,
                       p_group_name,
                       SYSDATE
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

    if p_flag ='detail_delete' then
        begin

            DELETE FROM ezjobs.EZ_JOBGROUP_JOB
            WHERE jobgroup_id   = p_jobgroup_id
              AND job_name       = p_job_name
              AND table_name       = p_table_name
              AND application      = p_application
              AND group_name       = p_group_name
              AND data_center   = p_data_center;

            --실행 결과 영향 받은 행의 수
            --GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='group_insert' then
        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_JOBGROUP
            WHERE jobgroup_name = p_jobgroup_name;


            if v_chk_cnt > 0 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.24';
                    RAISE v_ERROR;
                end;
            end if;

            INSERT INTO ezjobs.EZ_JOBGROUP (
                jobgroup_id,
                jobgroup_name,
                ins_user_cd,
                ins_date,
                content,
                udt_user_cd,
                udt_date
            )
            VALUES (
                       (SELECT 'G' || NVL(MAX(REPLACE(jobgroup_id, 'G', '')+1), 1) FROM ezjobs.EZ_JOBGROUP),
                       p_jobgroup_name,
                       p_user_cd,
                       SYSDATE,
                       p_content,
                       p_user_cd,
                       SYSDATE
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

    if p_flag ='group_update' then
        begin

            UPDATE ezjobs.EZ_JOBGROUP SET
                                            jobgroup_name  = p_jobgroup_name,
                                            udt_user_cd    = p_user_cd,
                                            udt_date       = SYSDATE,
                                            content        = p_content
            WHERE jobgroup_id   = p_jobgroup_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='group_delete' then
        begin

            DELETE FROM ezjobs.EZ_JOBGROUP_JOB
            WHERE jobgroup_id   = p_jobgroup_id;

            DELETE FROM ezjobs.EZ_JOBGROUP
            WHERE jobgroup_id   = p_jobgroup_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='update_job_id' then
        begin

            SELECT MAX(tb1.table_id)
            INTO v_table_id
            FROM emuser.DEF_JOB tb1, emuser.DEF_TABLES tb2
            WHERE tb1.table_id = tb2.table_id
              AND tb2.data_center = p_data_center
              AND tb1.job_name = p_job_name;

            SELECT MAX(tb1.job_id)
            INTO v_job_id
            FROM emuser.DEF_JOB tb1, emuser.DEF_TABLES tb2
            WHERE tb1.table_id = tb2.table_id
              AND tb2.data_center = p_data_center
              AND tb1.job_name = p_job_name;

            UPDATE ezjobs.EZ_JOBGROUP_JOB
            SET table_id = v_table_id, job_id = v_job_id
            WHERE data_center = p_data_center
              AND job_name = p_job_name;

        end;
    end if;

    if p_flag ='delete_job_id' then
        begin

            DELETE FROM ezjobs.EZ_JOBGROUP_JOB
            WHERE data_center = p_data_center
              AND job_name = p_job_name;
            --		         WHERE table_id = (case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end)
--		           AND job_id =(case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end);

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