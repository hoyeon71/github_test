CREATE OR REPLACE PROCEDURE EZJOBS.sp_ez_doc_03_prc
(
    r_code 	OUT varchar2
, r_msg 	OUT varchar2
, r_doc_cd 	OUT varchar2

, p_flag 					varchar2
, p_doc_cd 					varchar2
, p_doc_gb 					varchar2
, p_title 					varchar2
, p_content 				varchar2

, p_table_id 				varchar2
, p_job_id 					varchar2
, p_data_center 			varchar2
, p_table_name 				varchar2
, p_application 			varchar2
, p_group_name 				varchar2

, p_mem_name 				varchar2
, p_job_name 				varchar2
, p_task_type 				varchar2
, p_user_daily 				varchar2
, p_description 			varchar2

, p_owner 					varchar2
, p_author 					varchar2
, p_mem_lib 				varchar2
, p_command 				varchar2

, p_in_condition 			varchar2
, p_out_condition 			varchar2

, p_apply_date 				varchar2
, p_apply_check 			varchar2

, p_post_approval_time 		varchar2
, p_post_approval_yn 		varchar2

, p_node_id 				varchar2

, p_grp_approval_userlist 	varchar2
, p_grp_alarm_userlist 		varchar2
, p_main_doc_cd	     		varchar2

, p_s_user_cd 				varchar2
, p_s_user_ip 				varchar2

, p_deleted_yn 				varchar2
)

    IS

    v_user_line_cnt 	numeric;
    v_final_line_seq   	numeric;
    v_max_doc_cd    	varchar2(16);

    v_line_grp_cd 		number;
    v_user_cd 			number;
    v_approval_gb 		character(2);
    idx 				integer;
    v_user_line_seq 	integer;
    v_approval_type 	character(2);

    v_ERROR 			EXCEPTION;

BEGIN

    if p_flag ='ins' then
        begin

            SELECT 'EZJ' || TO_CHAR(sysdate,'yyyymmdd') || LPAD(doc_master_seq.nextval,5,'0')
            INTO v_max_doc_cd
            FROM DUAL;

            r_doc_cd := v_max_doc_cd;

            insert into EZJOBS.ez_doc_master  (
                                                 doc_cd
                                                ,doc_gb
                                                ,user_cd
                                                ,state_cd

                                                ,ins_date
                                                ,ins_user_cd
                                                ,ins_user_ip
            )
            values (
                       v_max_doc_cd
                   ,p_doc_gb
                   ,p_s_user_cd
                   ,'00'

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

            insert into EZJOBS.ez_doc_03  (
                                             doc_cd
                                            ,title
                                            ,content

                                            ,table_id
                                            ,job_id
                                            ,data_center
                                            ,table_name
                                            ,application
                                            ,group_name
                                            ,mem_name
                                            ,job_name
                                            ,task_type
                                            ,user_daily
                                            ,description
                                            ,owner
                                            ,author
                                            ,mem_lib
                                            ,command
                                            ,in_condition
                                            ,out_condition
                                            ,apply_date
                                            ,apply_check
                                            ,node_id
                                            ,deleted_yn

            )
            values (
                       v_max_doc_cd
                   ,p_title
                   ,p_content

                   ,(case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end)
                   ,(case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end)
                   ,p_data_center
                   ,p_table_name
                   ,p_application
                   ,p_group_name
                   ,p_mem_name
                   ,p_job_name
                   ,p_task_type
                   ,p_user_daily
                   ,p_description
                   ,p_owner
                   ,p_author
                   ,p_mem_lib
                   ,p_command
                   ,p_in_condition
                   ,p_out_condition
                   ,REPLACE(p_apply_date, '/', '')
                   ,p_apply_check
                   ,p_node_id
                   ,p_deleted_yn
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

    if p_flag ='udt' or p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin' then
        begin

            r_doc_cd := p_doc_cd;

            if p_flag ='udt' then
                begin
                    update EZJOBS.ez_doc_master
                    set
                        udt_date 	    = current_timestamp
                      ,udt_user_cd 	    = p_s_user_cd
                      ,udt_user_ip      = p_s_user_ip
                      ,post_approval_yn = p_post_approval_yn
                      ,main_doc_cd		= p_main_doc_cd
                    where doc_cd = p_doc_cd
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

            if p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin'  then
                begin

                    update EZJOBS.ez_doc_master
                    set
                        dept_nm = (select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd )
                      ,duty_nm = (select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd )
                      ,state_cd = '01'
                      ,draft_date = current_timestamp
                      ,cur_approval_seq = 1
                      ,post_approval_yn = case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn end
                      ,main_doc_cd		= p_main_doc_cd

                      ,udt_date 	= current_timestamp
                      ,udt_user_cd 	= p_s_user_cd
                      ,udt_user_ip = p_s_user_ip
                    where doc_cd = p_doc_cd
                    ;

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
                            SP_EZ_DOC_APPROVAL_SET_PRC(p_s_user_cd, p_s_user_ip, p_doc_cd, v_line_grp_cd, p_grp_approval_userList, p_grp_alarm_userlist);

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
                                        p_doc_cd
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

                end;
            end if;

            -- 일괄승인요청 시 udt 제외(23.10.30 김은희)
            if (p_main_doc_cd = '' or p_main_doc_cd IS null ) THEN
                begin
                    update EZJOBS.ez_doc_03
                    set
                        title 	              = (CASE WHEN p_flag = 'draft_admin' then '[관리자 즉시결재]' ELSE p_title END)
                      ,content 	              = p_content

                      ,table_id               = (case when p_table_id is not null and length(p_table_id)>0 then cast(p_table_id as numeric) else 0 end)
                      ,job_id                 = (case when p_job_id is not null and length(p_job_id)>0 then cast(p_job_id as numeric) else 0 end)
                      ,data_center            = p_data_center
                      ,table_name             = p_table_name
                      ,application            = p_application
                      ,group_name             = p_group_name
                      ,mem_name               = p_mem_name
                      ,job_name               = p_job_name
                      ,task_type              = p_task_type
                      ,user_daily             = p_user_daily
                      ,description            = p_description
                      ,owner                  = p_owner
                      ,author                 = p_author
                      ,mem_lib                = p_mem_lib
                      ,command                = p_command
                      ,in_condition           = p_in_condition
                      ,out_condition          = p_out_condition
                      ,apply_date             = REPLACE(p_apply_date, '/', '')
                      ,apply_check            = p_apply_check
                      ,node_id	            = p_node_id

                    where doc_cd = p_doc_cd
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
        end;
    end if;

    if p_flag ='del' then
        begin

            delete from EZJOBS.ez_approval_doc where doc_cd = p_doc_cd;


            delete from EZJOBS.ez_doc_03 where doc_cd = p_doc_cd;

            if SQL%ROWCOUNT < 1 then
                BEGIN
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                END;
            end if;

            delete from EZJOBS.ez_doc_master where doc_cd = p_doc_cd;

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