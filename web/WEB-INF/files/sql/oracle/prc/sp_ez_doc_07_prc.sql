CREATE OR REPLACE PROCEDURE EZJOBS.sp_ez_doc_07_prc
(
    r_code 	  			 OUT varchar2,
    r_msg     			 OUT varchar2,
    r_doc_cd  			 OUT varchar2,

    p_flag 					 varchar2,
    p_doc_cd 				 varchar2,
    p_title 				 varchar2,
    p_content 				 varchar2,
    p_order_id 				 varchar2,
    p_odate 				 varchar2,
    p_data_center 			 varchar2,
    p_table_name 			 varchar2,
    p_application 			 varchar2,
    p_group_name 			 varchar2,
    p_job_name 				 varchar2,
    p_before_status 		 varchar2,
    p_after_status 			 varchar2,
    p_apply_date	 		 varchar2,

    p_post_approval_time 	 varchar2,
    p_post_approval_yn 		 varchar2,
    p_description            varchar2,

    p_main_doc_cd	     	 varchar2,

    p_grp_approval_userlist  varchar2,
    p_grp_alarm_userlist     varchar2,

    p_s_user_cd 			 varchar2,
    p_s_user_ip 			 varchar2
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

    if p_flag ='ins' or p_flag ='draft' or p_flag ='post_draft' or p_flag ='draft_admin'  then
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
                       p_s_user_cd,
                       (select t2.dept_nm from EZJOBS.ez_user t1, EZJOBS.ez_dept t2 where t1.dept_cd = t2.dept_cd and t1.user_cd = p_s_user_cd ),
                       (select t2.duty_nm from EZJOBS.ez_user t1, EZJOBS.ez_duty t2 where t1.duty_cd = t2.duty_cd and t1.user_cd = p_s_user_cd ),
                       '01',
                       current_timestamp,
                       1,
                       case when p_flag = 'draft_admin' then 'A' else p_post_approval_yn end,
                       p_main_doc_cd,

                       current_timestamp,
                       p_s_user_cd,
                       p_s_user_ip,
                       current_timestamp,
                       p_s_user_cd,
                       p_s_user_ip
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
                      AND doc_gubun = '07';

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

            insert into EZJOBS.ez_doc_07  (
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
                description,
                apply_date
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
                       p_description,
                       p_apply_date
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