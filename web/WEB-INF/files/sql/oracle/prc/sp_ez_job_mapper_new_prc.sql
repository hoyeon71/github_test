CREATE OR REPLACE PROCEDURE EZJOBS4O.sp_ez_job_mapper_new_prc
(
    r_code             out varchar2,
    r_msg              out varchar2,

    p_doc_cd               varchar2,
    p_flag                 varchar2,
    p_data_center          varchar2,
    p_job                  varchar2,

    p_user_cd_1            varchar2,
    p_user_cd_2            varchar2,
    p_user_cd_3            varchar2,
    p_user_cd_4            varchar2,
    p_user_cd_5            varchar2,
    p_user_cd_6            varchar2,
    p_user_cd_7            varchar2,
    p_user_cd_8            varchar2,
    p_user_cd_9            varchar2,
    p_user_cd_10           varchar2,

    p_error_description    varchar2,

    p_user_cd              varchar2,
    p_mapper_cd            varchar2,

    p_sms_1                varchar2,
    p_sms_2                varchar2,
    p_sms_3                varchar2,
    p_sms_4                varchar2,
    p_sms_5                varchar2,
    p_sms_6                varchar2,
    p_sms_7                varchar2,
    p_sms_8                varchar2,
    p_sms_9                varchar2,
    p_sms_10               varchar2,

    p_mail_1               varchar2,
    p_mail_2               varchar2,
    p_mail_3               varchar2,
    p_mail_4               varchar2,
    p_mail_5               varchar2,
    p_mail_6               varchar2,
    p_mail_7               varchar2,
    p_mail_8               varchar2,
    p_mail_9               varchar2,
    p_mail_10              varchar2,

    p_grp_cd_1		  	   varchar2,
    p_grp_cd_2		       varchar2,
    p_grp_sms_1		   	   varchar2,
    p_grp_sms_2		       varchar2,
    p_grp_mail_1		   varchar2,
    p_grp_mail_2		   varchar2,

    p_late_sub             varchar2,
    p_late_time            varchar2,
    p_late_exec            varchar2,

    p_batchjobgrade        varchar2,

    p_udt_user             varchar2,
    p_del_user             varchar2,

    p_jobschedgb           varchar2,
    p_success_sms_yn       varchar2,

    p_s_user_cd            varchar2,
    p_s_user_ip            varchar2
)

    IS

    v_chk_cnt 			number;
    v_max_cnt 			number;

    v_ERROR 			EXCEPTION;

BEGIN

    if p_flag = 'one_update_doc' then

        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs4o.EZ_JOB_MAPPER_DOC
            WHERE data_center = p_data_center
              AND job = p_job
              AND doc_cd = p_doc_cd;

            if v_chk_cnt = 0 then
                begin

                    INSERT INTO ezjobs4o.EZ_JOB_MAPPER_DOC  (
                                                             data_center
                                                            ,doc_cd
                                                            ,job

                                                            ,user_cd_1
                                                            ,user_cd_2
                                                            ,user_cd_3
                                                            ,user_cd_4
                                                            ,user_cd_5
                                                            ,user_cd_6
                                                            ,user_cd_7
                                                            ,user_cd_8
                                                            ,user_cd_9
                                                            ,user_cd_10

                                                            ,error_description

                                                            ,sms_1
                                                            ,sms_2
                                                            ,sms_3
                                                            ,sms_4
                                                            ,sms_5
                                                            ,sms_6
                                                            ,sms_7
                                                            ,sms_8
                                                            ,sms_9
                                                            ,sms_10

                                                            ,mail_1
                                                            ,mail_2
                                                            ,mail_3
                                                            ,mail_4
                                                            ,mail_5
                                                            ,mail_6
                                                            ,mail_7
                                                            ,mail_8
                                                            ,mail_9
                                                            ,mail_10

                                                            ,grp_cd_1
                                                            ,grp_cd_2
                                                            ,grp_sms_1
                                                            ,grp_sms_2
                                                            ,grp_mail_1
                                                            ,grp_mail_2

                                                            ,late_sub
                                                            ,late_time
                                                            ,late_exec

                                                            ,batchJobGrade
                                                            ,jobSchedGb

                                                            ,success_sms_yn

                                                            ,ins_date
                                                            ,ins_user_cd
                                                            ,ins_user_ip
                    )
                    VALUES (
                               p_data_center
                           ,p_doc_cd
                           ,p_job

                           ,(case when p_user_cd_1 = '' then null else cast(p_user_cd_1 as number) end)
                           ,(case when p_user_cd_2 = '' then null else cast(p_user_cd_2 as number) end)
                           ,(case when p_user_cd_3 = '' then null else cast(p_user_cd_3 as number) end)
                           ,(case when p_user_cd_4 = '' then null else cast(p_user_cd_4 as number) end)
                           ,(case when p_user_cd_5 = '' then null else cast(p_user_cd_5 as number) end)
                           ,(case when p_user_cd_6 = '' then null else cast(p_user_cd_6 as number) end)
                           ,(case when p_user_cd_7 = '' then null else cast(p_user_cd_7 as number) end)
                           ,(case when p_user_cd_8 = '' then null else cast(p_user_cd_8 as number) end)
                           ,(case when p_user_cd_9 = '' then null else cast(p_user_cd_9 as number) end)
                           ,(case when p_user_cd_10 = '' then null else cast(p_user_cd_10 as number) end)

                           ,p_error_description

                           ,p_sms_1
                           ,p_sms_2
                           ,p_sms_3
                           ,p_sms_4
                           ,p_sms_5
                           ,p_sms_6
                           ,p_sms_7
                           ,p_sms_8
                           ,p_sms_9
                           ,p_sms_10

                           ,p_mail_1
                           ,p_mail_2
                           ,p_mail_3
                           ,p_mail_4
                           ,p_mail_5
                           ,p_mail_6
                           ,p_mail_7
                           ,p_mail_8
                           ,p_mail_9
                           ,p_mail_10

                           ,(case when p_grp_cd_1 	= '' then null else cast(p_grp_cd_1 as number) end)
                           ,(case when p_grp_cd_2 	= '' then null else cast(p_grp_cd_2 as number) end)
                           ,p_grp_sms_1
                           ,p_grp_sms_2
                           ,p_grp_mail_1
                           ,p_grp_mail_2

                           ,p_late_sub
                           ,p_late_time
                           ,p_late_exec

                           ,p_batchJobGrade
                           ,p_jobSchedGb
                           ,p_success_sms_yn

                           ,current_timestamp
                           ,cast(p_s_user_cd as number)
                           ,p_s_user_ip
                           );

                    if SQL%ROWCOUNT < 1 then
                        begin
                            r_code 	:= '-1';
                            r_msg 	:= 'ERROR.01';
                            RAISE  	v_ERROR;
                        end;
                    end if;

                end;
            end if;

            if v_chk_cnt > 0 then
                begin

                    UPDATE ezjobs4o.EZ_JOB_MAPPER_DOC SET

                        user_cd_1 = (case when p_user_cd_1 = '' then null else cast(p_user_cd_1 as number) end)
                                                        ,user_cd_2 = (case when p_user_cd_2 = '' then null else cast(p_user_cd_2 as number) end)
                                                        ,user_cd_3 = (case when p_user_cd_3 = '' then null else cast(p_user_cd_3 as number) end)
                                                        ,user_cd_4 = (case when p_user_cd_4 = '' then null else cast(p_user_cd_4 as number) end)
                                                        ,user_cd_5 = (case when p_user_cd_5 = '' then null else cast(p_user_cd_5 as number) end)
                                                        ,user_cd_6 = (case when p_user_cd_6 = '' then null else cast(p_user_cd_6 as number) end)
                                                        ,user_cd_7 = (case when p_user_cd_7 = '' then null else cast(p_user_cd_7 as number) end)
                                                        ,user_cd_8 = (case when p_user_cd_8 = '' then null else cast(p_user_cd_8 as number) end)
                                                        ,user_cd_9 = (case when p_user_cd_9 = '' then null else cast(p_user_cd_9 as number) end)
                                                        ,user_cd_10 = (case when p_user_cd_10 = '' then null else cast(p_user_cd_10 as number) end)

                                                        ,error_description = p_error_description

                                                        ,sms_1 = p_sms_1
                                                        ,sms_2 = p_sms_2
                                                        ,sms_3 = p_sms_3
                                                        ,sms_4 = p_sms_4
                                                        ,sms_5 = p_sms_5
                                                        ,sms_6 = p_sms_6
                                                        ,sms_7 = p_sms_7
                                                        ,sms_8 = p_sms_8
                                                        ,sms_9 = p_sms_9
                                                        ,sms_10 = p_sms_10
                                                        ,mail_1 = p_mail_1
                                                        ,mail_2 = p_mail_2
                                                        ,mail_3 = p_mail_3
                                                        ,mail_4 = p_mail_4
                                                        ,mail_5 = p_mail_5
                                                        ,mail_6 = p_mail_6
                                                        ,mail_7 = p_mail_7
                                                        ,mail_8 = p_mail_8
                                                        ,mail_9 = p_mail_9
                                                        ,mail_10 = p_mail_10

                                                        ,grp_cd_1 = (case when p_grp_cd_1 = '' then null else cast(p_grp_cd_1 as number) end)
                                                        ,grp_cd_2 = (case when p_grp_cd_2 = '' then null else cast(p_grp_cd_2 as number) end)
                                                        ,grp_sms_1 = p_grp_sms_1
                                                        ,grp_sms_2 = p_grp_sms_2
                                                        ,grp_mail_1 = p_grp_mail_1
                                                        ,grp_mail_2 = p_grp_mail_2

                                                        ,late_sub = p_late_sub
                                                        ,late_time = p_late_time
                                                        ,late_exec = p_late_exec

                                                        ,batchJobGrade = p_batchJobGrade
                                                        ,jobSchedGb = p_jobSchedGb
                                                        ,success_sms_yn 	= p_success_sms_yn

                                                        ,udt_date 	    = current_timestamp
                                                        ,udt_user_cd 	= cast(p_s_user_cd as number)
                                                        ,udt_user_ip   	= p_s_user_ip

                    WHERE data_center = p_data_center
                      AND job = p_job
                      AND doc_cd = p_doc_cd;

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

    if p_flag = 'one_update' then
        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs4o.EZ_JOB_MAPPER
            WHERE data_center = p_data_center
              AND job = p_job;

            if v_chk_cnt = 0 then
                begin

                    -- 다른 C-M 작업 매퍼 정보는 삭제 후 신규 등록
                    DELETE FROM ezjobs4o.EZ_JOB_MAPPER WHERE job = p_job;

                    INSERT INTO ezjobs4o.EZ_JOB_MAPPER  (
                                                         data_center
                                                        ,job

                                                        ,user_cd_1
                                                        ,user_cd_2
                                                        ,user_cd_3
                                                        ,user_cd_4
                                                        ,user_cd_5
                                                        ,user_cd_6
                                                        ,user_cd_7
                                                        ,user_cd_8
                                                        ,user_cd_9
                                                        ,user_cd_10

                                                        ,error_description

                                                        ,sms_1
                                                        ,sms_2
                                                        ,sms_3
                                                        ,sms_4
                                                        ,sms_5
                                                        ,sms_6
                                                        ,sms_7
                                                        ,sms_8
                                                        ,sms_9
                                                        ,sms_10

                                                        ,mail_1
                                                        ,mail_2
                                                        ,mail_3
                                                        ,mail_4
                                                        ,mail_5
                                                        ,mail_6
                                                        ,mail_7
                                                        ,mail_8
                                                        ,mail_9
                                                        ,mail_10

                                                        ,grp_cd_1
                                                        ,grp_cd_2
                                                        ,grp_sms_1
                                                        ,grp_sms_2
                                                        ,grp_mail_1
                                                        ,grp_mail_2

                                                        ,late_sub
                                                        ,late_time
                                                        ,late_exec

                                                        ,batchJobGrade
                                                        ,jobSchedGb
                                                        ,success_sms_yn

                                                        ,ins_date
                                                        ,ins_user_cd
                                                        ,ins_user_ip
                    )       			VALUES (
                                                p_data_center
                                            ,p_job

                                            ,(case when p_user_cd_1 = '' then null else cast(p_user_cd_1 as number) end)
                                            ,(case when p_user_cd_2 = '' then null else cast(p_user_cd_2 as number) end)
                                            ,(case when p_user_cd_3 = '' then null else cast(p_user_cd_3 as number) end)
                                            ,(case when p_user_cd_4 = '' then null else cast(p_user_cd_4 as number) end)
                                            ,(case when p_user_cd_5 = '' then null else cast(p_user_cd_5 as number) end)
                                            ,(case when p_user_cd_6 = '' then null else cast(p_user_cd_6 as number) end)
                                            ,(case when p_user_cd_7 = '' then null else cast(p_user_cd_7 as number) end)
                                            ,(case when p_user_cd_8 = '' then null else cast(p_user_cd_8 as number) end)
                                            ,(case when p_user_cd_9 = '' then null else cast(p_user_cd_9 as number) end)
                                            ,(case when p_user_cd_10 = '' then null else cast(p_user_cd_10 as number) end)

                                            ,p_error_description

                                            ,p_sms_1
                                            ,p_sms_2
                                            ,p_sms_3
                                            ,p_sms_4
                                            ,p_sms_5
                                            ,p_sms_6
                                            ,p_sms_7
                                            ,p_sms_8
                                            ,p_sms_9
                                            ,p_sms_10

                                            ,p_mail_1
                                            ,p_mail_2
                                            ,p_mail_3
                                            ,p_mail_4
                                            ,p_mail_5
                                            ,p_mail_6
                                            ,p_mail_7
                                            ,p_mail_8
                                            ,p_mail_9
                                            ,p_mail_10

                                            ,(case when p_grp_cd_1 = '' then null else cast(p_grp_cd_1 as number) end)
                                            ,(case when p_grp_cd_2 = '' then null else cast(p_grp_cd_2 as number) end)
                                            ,p_grp_sms_1
                                            ,p_grp_sms_2
                                            ,p_grp_mail_1
                                            ,p_grp_mail_2

                                            ,p_late_sub
                                            ,p_late_time
                                            ,p_late_exec

                                            ,p_batchJobGrade
                                            ,p_jobSchedGb
                                            ,p_success_sms_yn

                                            ,current_timestamp
                                            ,cast(p_s_user_cd as number)
                                            ,p_s_user_ip
                                            );

                    if SQL%ROWCOUNT < 1 then
                        begin
                            r_code 	:= '-1';
                            r_msg 	:= 'ERROR.01';
                            RAISE 	v_ERROR;
                        end;
                    end if;

                end;
            end if;

            if v_chk_cnt > 0 then
                begin

                    UPDATE ezjobs4o.EZ_JOB_MAPPER SET
                        user_cd_1  = (case when p_user_cd_1 = '' then null else cast(p_user_cd_1 as number) end)
                                                    ,user_cd_2 = (case when p_user_cd_2 = '' then null else cast(p_user_cd_2 as number) end)
                                                    ,user_cd_3 = (case when p_user_cd_3 = '' then null else cast(p_user_cd_3 as number) end)
                                                    ,user_cd_4 = (case when p_user_cd_4 = '' then null else cast(p_user_cd_4 as number) end)
                                                    ,user_cd_5 = (case when p_user_cd_5 = '' then null else cast(p_user_cd_5 as number) end)
                                                    ,user_cd_6 = (case when p_user_cd_6 = '' then null else cast(p_user_cd_6 as number) end)
                                                    ,user_cd_7 = (case when p_user_cd_7 = '' then null else cast(p_user_cd_7 as number) end)
                                                    ,user_cd_8 = (case when p_user_cd_8 = '' then null else cast(p_user_cd_8 as number) end)
                                                    ,user_cd_9 = (case when p_user_cd_9 = '' then null else cast(p_user_cd_9 as number) end)
                                                    ,user_cd_10 = (case when p_user_cd_10 = '' then null else cast(p_user_cd_10 as number) end)

                                                    ,error_description 	= p_error_description

                                                    ,sms_1 = p_sms_1
                                                    ,sms_2 = p_sms_2
                                                    ,sms_3 = p_sms_3
                                                    ,sms_4 = p_sms_4
                                                    ,sms_5 = p_sms_5
                                                    ,sms_6 = p_sms_6
                                                    ,sms_7 = p_sms_7
                                                    ,sms_8 = p_sms_8
                                                    ,sms_9 = p_sms_9
                                                    ,sms_10 = p_sms_10

                                                    ,mail_1 = p_mail_1
                                                    ,mail_2 = p_mail_2
                                                    ,mail_3 = p_mail_3
                                                    ,mail_4 = p_mail_4
                                                    ,mail_5 = p_mail_5
                                                    ,mail_6 = p_mail_6
                                                    ,mail_7 = p_mail_7
                                                    ,mail_8 = p_mail_8
                                                    ,mail_9 = p_mail_9
                                                    ,mail_10 = p_mail_10

                                                    ,grp_cd_1 = (case when p_grp_cd_1 = '' then null else cast(p_grp_cd_1 as number) end)
                                                    ,grp_cd_2 = (case when p_grp_cd_2 = '' then null else cast(p_grp_cd_2 as number) end)
                                                    ,grp_sms_1 = p_grp_sms_1
                                                    ,grp_sms_2 = p_grp_sms_2
                                                    ,grp_mail_1 = p_grp_mail_1
                                                    ,grp_mail_2 = p_grp_mail_2

                                                    ,late_sub 	= p_late_sub
                                                    ,late_time 	= p_late_time
                                                    ,late_exec 	= p_late_exec

                                                    ,batchJobGrade 	= p_batchJobGrade
                                                    ,jobSchedGb = p_jobSchedGb
                                                    ,success_sms_yn 	= p_success_sms_yn

                                                    ,udt_date 	    = current_timestamp
                                                    ,udt_user_cd 	= cast(p_s_user_cd as number)
                                                    ,udt_user_ip   	= p_s_user_ip

                    WHERE data_center = p_data_center
                      AND job = p_job;

                    if SQL%ROWCOUNT < 1 then
                        begin
                            r_code 	:= '-1';
                            r_msg 	:= 'ERROR.01';
                            RAISE 	v_ERROR;
                        end;
                    end if;

                end;
            end if;
        end;
    end if;

    if p_flag = 'batch_update' then
        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs4o.EZ_JOB_MAPPER
            WHERE data_center = p_data_center
              AND job = p_job;

            if v_chk_cnt = 0 then
                INSERT INTO ezjobs4o.EZ_JOB_MAPPER (data_center, job, ins_date, ins_user_cd, ins_user_ip)
                VALUES (p_data_center, p_job, current_timestamp, p_s_user_cd, p_s_user_ip);

                if SQL%ROWCOUNT < 1 then
                    begin
                        r_code 	:= '-1';
                        r_msg 	:= 'ERROR.01';
                        RAISE 	v_ERROR;
                    end;
                end if;

                SELECT COUNT(*)
                INTO v_chk_cnt
                FROM ezjobs4o.EZ_JOB_MAPPER
                WHERE data_center = p_data_center
                  AND job = p_job;

            end if;

            if v_chk_cnt > 0 then
                begin
                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 1 ) != 'N' and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 1) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_1      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 1 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 1 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_1  			= p_sms_1,
                                mail_1			= p_mail_1
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 2 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 2 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 2 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_2      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 2 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 2 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_2  			= p_sms_2,
                                mail_2			= p_mail_2
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 3 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 3 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 3 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_3      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 3 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 3 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_3  			= p_sms_3,
                                mail_3			= p_mail_3
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 4 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 4 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 4 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_4      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 4 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 4 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_4  			= p_sms_4,
                                mail_4			= p_mail_4
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 5 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 5 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 5 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_5      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 5 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 5 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_5  			= p_sms_5,
                                mail_5			= p_mail_5
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 6 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 6 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 6 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_6      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 6 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 6 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_6  			= p_sms_6,
                                mail_6			= p_mail_6
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 7 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 7 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 7 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_7      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 7 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 7 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_7  			= p_sms_7,
                                mail_7			= p_mail_7
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 8 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 8 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 8 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_8      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 8 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 8 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_8  			= p_sms_8,
                                mail_8			= p_mail_8
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 9 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 9 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 9 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_9      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 9 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 9 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_9  			= p_sms_9,
                                mail_9			= p_mail_9
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 10 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 10 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 10 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_10      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 10 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 10 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                sms_10  		= p_sms_10,
                                mail_10			= p_mail_10
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 11 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 11 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 11 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  grp_cd_1      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 11 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 11 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                grp_sms_1  		= p_grp_sms_1,
                                grp_mail_1		= p_grp_mail_1
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 12 ) != 'N' and REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 12 ) is not null and REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 12 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  grp_cd_2      = REGEXP_SUBSTR(p_mapper_cd, '[^,]+', 1, 12 )
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_udt_user, '[^,]+', 1, 12 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET     udt_date 	    = current_timestamp,
                                udt_user_cd 	= p_s_user_cd,
                                udt_user_ip     = p_s_user_ip,
                                grp_sms_2  		= p_grp_sms_2,
                                grp_mail_2		= p_grp_mail_2
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;



                    -- 담당자 일괄 초기화 로직
                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 1 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_1      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_1  		= 'N',
                             mail_1			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 2 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_2      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_2  		= 'N',
                             mail_2			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 3 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_3      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_3  		= 'N',
                             mail_3			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 4 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_4      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_4  		= 'N',
                             mail_4			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 5 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_5      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_5  		= 'N',
                             mail_5			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 6 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_6      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_6  		= 'N',
                             mail_6			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 7 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_7      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_7  		= 'N',
                             mail_7			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 8 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_8      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_8  		= 'N',
                             mail_8			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 9 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_9      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_9  		= 'N',
                             mail_9			= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 10 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  user_cd_10      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             sms_10  		= 'N',
                             mail_10		= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 11 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  grp_cd_1      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             grp_sms_1 		= 'N',
                             grp_mail_1		= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;

                    if REGEXP_SUBSTR(p_del_user, '[^,]+', 1, 12 ) = 'Y' then
                        UPDATE  ezjobs4o.EZ_JOB_MAPPER
                        SET  grp_cd_2      = null,

                             udt_date 	    = current_timestamp,
                             udt_user_cd 	= p_s_user_cd,
                             udt_user_ip    = p_s_user_ip,
                             grp_sms_2 		= 'N',
                             grp_mail_2		= 'N'
                        WHERE  data_center = p_data_center
                          AND  job         = p_job;
                    end if;
                end;
            end if;
        end;
    end if;

    if p_flag = 'job_insert' then
        begin
            --해당 이름의 작업이 mapper에 있는지 확인, cnt > 0 이면 exception
            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs4o.EZ_JOB_MAPPER
            WHERE job = p_job;

            IF v_chk_cnt > 0 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := '이미 존재하는 작업입니다.';
                    RAISE v_ERROR;
                END;
            END IF;

            IF v_chk_cnt = 0 THEN
                INSERT INTO ezjobs4o.EZ_JOB_MAPPER (
                    data_center,
                    job,
                    jobschedgb,
                    late_sub,
                    late_time,
                    late_exec,
                    success_sms_yn,
                    ins_user_cd,
                    ins_user_ip,
                    ins_date
                ) VALUES (
                             p_data_center,
                             p_job,
                             1,
                             p_late_sub,
                             p_late_time,
                             p_late_exec,
                             p_success_sms_yn,
                             cast(p_s_user_cd as number),
                             p_s_user_ip,
                             current_timestamp
                         );

                if SQL%ROWCOUNT < 1 then
                    BEGIN
                        r_code := '-1';
                        r_msg := '작업 이관 실패.';
                        RAISE v_ERROR;
                    END;
                END IF;
            END IF;
        end;
    end if;

    if p_flag = 'mapper_del' then
        begin
            --작업이 삭제되면 매퍼도 삭제
            delete from ezjobs4o.EZ_JOB_MAPPER
            where 1=1
              and data_center = p_data_center
              and job = p_job;

            /*if SQL%ROWCOUNT < 1 then
                 begin
                     r_code 	:= '-1';
                     r_msg 	:= 'ERROR.01';
                     RAISE 	v_ERROR;
                 end;
             end if; */
        end;
    end if;

    if p_flag = 'excel_user_update' then
        begin
            --해당 이름의 작업이 mapper에 있는지 확인, cnt > 0 이면 exception
            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs4o.EZ_JOB_MAPPER
            WHERE job = p_job;

            IF v_chk_cnt = 0 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := '존재하지 않은 작업입니다.';
                    RAISE v_ERROR;
                END;
            END IF;

            IF v_chk_cnt > 0 THEN
                UPDATE ezjobs4o.EZ_JOB_MAPPER SET
                    user_cd_1 =   (case when p_user_cd_1 = '' then null else p_user_cd_1 end)
                                                ,user_cd_2 =   (case when p_user_cd_2 = '' then null else p_user_cd_2 end)
                                                ,user_cd_3 =   (case when p_user_cd_3 = '' then null else p_user_cd_3 end)
                                                ,user_cd_4 =   (case when p_user_cd_4 = '' then null else p_user_cd_4 end)
                                                ,user_cd_5 =   (case when p_user_cd_5 = '' then null else p_user_cd_5 end)
                                                ,user_cd_6 =   (case when p_user_cd_6 = '' then null else p_user_cd_6 end)
                                                ,user_cd_7 =   (case when p_user_cd_7 = '' then null else p_user_cd_7 end)
                                                ,user_cd_8 =   (case when p_user_cd_8 = '' then null else p_user_cd_8 end)
                                                ,user_cd_9 =   (case when p_user_cd_9 = '' then null else p_user_cd_9 end)
                                                ,user_cd_10 =   (case when p_user_cd_10 = '' then null else p_user_cd_10 end)

                                                ,sms_1 = p_sms_1
                                                ,sms_2 = p_sms_2
                                                ,sms_3 = p_sms_3
                                                ,sms_4 = p_sms_4
                                                ,sms_5 = p_sms_5
                                                ,sms_6 = p_sms_6
                                                ,sms_7 = p_sms_7
                                                ,sms_8 = p_sms_8
                                                ,sms_9 = p_sms_9
                                                ,sms_10 = p_sms_10


                                                ,mail_1 = p_mail_1
                                                ,mail_2 = p_mail_2
                                                ,mail_3 = p_mail_3
                                                ,mail_4 = p_mail_4
                                                ,mail_5 = p_mail_5
                                                ,mail_6 = p_mail_6
                                                ,mail_7 = p_mail_7
                                                ,mail_8 = p_mail_8
                                                ,mail_9 = p_mail_9
                                                ,mail_10 = p_mail_10

                                                ,grp_cd_1 = (case when p_grp_cd_1 = '' then null else cast(p_grp_cd_1 as number) end)
                                                ,grp_cd_2 = (case when p_grp_cd_2 = '' then null else cast(p_grp_cd_2 as number) end)
                                                ,grp_sms_1 = p_grp_sms_1
                                                ,grp_sms_2 = p_grp_sms_2
                                                ,grp_mail_1 = p_grp_mail_1
                                                ,grp_mail_2 = p_grp_mail_2

                                                ,udt_date 	    = current_timestamp
                                                ,udt_user_cd 	= p_s_user_cd
                                                ,udt_user_ip   	= p_s_user_ip

                WHERE 1=1
                  and data_center = p_data_center
                  and job = p_job;

                if SQL%ROWCOUNT < 1 then
                    BEGIN
                        r_code := '-1';
                        r_msg := '담당자 변경 실패.';
                        RAISE v_ERROR;
                    END;
                END IF;
            END IF;
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