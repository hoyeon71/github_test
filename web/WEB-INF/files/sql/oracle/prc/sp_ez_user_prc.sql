CREATE OR REPLACE PROCEDURE ezjobs.SP_EZ_USER_PRC
(
    r_code 					out varchar2,
    r_msg 					out varchar2,

    p_flag  					varchar2,
    p_user_cd 					varchar2,
    p_user_id 					varchar2,
    p_user_nm 					varchar2,
    p_user_pw 					varchar2,
    p_user_gb 					varchar2,
    p_user_email 				varchar2,
    p_user_hp 					varchar2,
    p_dept_cd 					varchar2,
    p_duty_cd 					varchar2,
    p_no_auth 					varchar2,
    p_select_data_center_code 	varchar2,
    p_select_table_name 		varchar2,
    p_select_application 		varchar2,
    p_select_group_name			varchar2,
    p_del_yn 					varchar2,
    p_retire_yn 				varchar2,
    p_pw_fail_cnt 				varchar2,
    p_pw_date 					varchar2,
    p_before_pw 				varchar2,
    p_account_lock 				varchar2,
    p_user_tel 					varchar2,
    p_absence_start_date 		varchar2,
    p_absence_end_date 			varchar2,
    p_absence_reason 			varchar2,
    p_absence_user_cd 			varchar2,
    p_default_paging			varchar2,
    p_reset_yn 					varchar2,
    p_dept_id 					varchar2,
    p_dept_nm 					varchar2,
    p_duty_id 					varchar2,
    p_duty_nm 					varchar2,
    p_s_user_cd 				varchar2,
    p_s_user_ip 				varchar2,
    p_s_user_appr_gb			varchar2,
    p_folder_auth				varchar2,
    p_all_gb					varchar2,
    p_user_ip					varchar2,
    p_data_center 				varchar2
)
    IS
    v_chk_cnt 					number;
    v_max_cnt 					number;

    v_ERROR 					EXCEPTION;
BEGIN

    if p_flag ='ins' then
        begin

            -- 중복 아이디 등록 불가
            SELECT COUNT(*)
            INTO v_max_cnt
            FROM ezjobs.ez_user
            WHERE user_id = p_user_id;

            if v_max_cnt > 0 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.10';
                    RAISE v_ERROR;
                end;
            end if;

            select NVL(max(user_cd),0) + 1
            into v_max_cnt
            from ezjobs.ez_user
            ;

            insert into ezjobs.ez_user (
                                          user_cd
                                         ,user_id
                                         ,user_nm
                                         ,user_pw
                                         ,user_gb
                                         ,user_email
                                         ,user_hp
                                         ,dept_cd
                                         ,duty_cd
                                         ,user_tel
                                         ,user_appr_gb
                                         ,account_lock
                                         ,ins_date
                                         ,ins_user_cd
                                         ,ins_user_ip
                                         ,select_data_center_code
                                         ,select_table_name
                                         ,del_yn
                                         ,retire_yn
                                         ,reset_yn
                                         ,user_ip
            )
            values (
                       v_max_cnt
                   ,p_user_id
                   ,p_user_nm
                   ,p_user_pw
                   ,p_user_gb
                   ,p_user_email
                   ,p_user_hp
                   ,p_dept_cd
                   ,p_duty_cd
                   ,p_user_tel
                   ,p_s_user_appr_gb
                   ,p_account_lock
                   ,sysdate
                   ,p_s_user_cd
                   ,p_s_user_ip
                   ,p_select_data_center_code
                   ,p_select_table_name
                   ,p_del_yn
                   ,p_retire_yn
                   ,p_reset_yn
                   ,p_user_ip
                   )
            ;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 유저이력관리
            insert into ezjobs.ez_user_history
            SELECT
                user_cd
                 ,user_id
                 ,user_nm
                 ,'ins'
                 ,user_gb
                 ,dept_cd
                 ,duty_cd
                 ,del_yn
                 ,retire_yn
                 ,user_email
                 ,user_hp
                 ,user_tel
                 ,select_data_center_code
                 ,account_lock
                 ,ins_date
                 ,ins_user_cd
                 ,ins_user_ip
                 ,udt_date
                 ,udt_user_cd
                 ,udt_user_ip
                 ,select_table_name
                 ,select_application
                 ,select_group_name
                 ,user_appr_gb
                 ,sysdate
                 ,user_ip
            FROM ezjobs.ez_user
            WHERE user_cd = v_max_cnt;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag = 'udt' then	--유저관리화면에서 사용자정보 update
        begin

            update ezjobs.ez_user
            set
               user_nm 					= p_user_nm
              ,user_pw 					= p_user_pw
              ,user_gb 					= p_user_gb
              ,user_email 				= p_user_email
              ,user_hp 					= p_user_hp
              ,dept_cd 					= p_dept_cd
              ,duty_cd 					= p_duty_cd
              ,user_tel 				= p_user_tel
              ,absence_start_date 		= CASE WHEN COALESCE(p_absence_start_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_start_date, '/', ''), 'yyyymmdd') END
              ,absence_end_date 		= CASE WHEN COALESCE(p_absence_end_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_end_date, '/', ''), 'yyyymmdd') END
              ,absence_reason 			= p_absence_reason
              ,absence_user_cd 			= CASE WHEN p_absence_user_cd IS NULL THEN '' ELSE p_absence_user_cd END
              ,user_appr_gb 			= CASE WHEN p_s_user_appr_gb IS NULL THEN '' ELSE p_s_user_appr_gb END
              ,udt_date 				= sysdate
              ,udt_user_cd 				= p_s_user_cd
              ,udt_user_ip 				= p_s_user_ip
              ,select_data_center_code 	= p_select_data_center_code
              ,select_table_name		= p_select_table_name
              ,del_yn 					= p_del_yn
              ,retire_yn 				= p_retire_yn
              ,account_lock				= p_account_lock
              ,before_pw          		= p_before_pw
              ,default_paging     		= p_default_paging
              ,reset_yn           		= p_reset_yn
              ,user_ip     				= p_user_ip
            where user_cd = p_user_cd
            ;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 유저이력관리
            insert into ezjobs.ez_user_history
            SELECT
                user_cd
                 ,user_id
                 ,user_nm
                 ,'udt'
                 ,user_gb
                 ,dept_cd
                 ,duty_cd
                 ,del_yn
                 ,retire_yn
                 ,user_email
                 ,user_hp
                 ,user_tel
                 ,select_data_center_code
                 ,account_lock
                 ,ins_date
                 ,ins_user_cd
                 ,ins_user_ip
                 ,udt_date
                 ,udt_user_cd
                 ,udt_user_ip
                 ,select_table_name
                 ,select_application
                 ,select_group_name
                 ,user_appr_gb
                 ,sysdate
                 ,user_ip
            FROM ezjobs.ez_user
            WHERE user_cd = p_user_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag = 'user_udt' then		--개인정보화면에서 사용자정보 update (2020.06.02기준, 개인정보화면에서는 비밀번호 변경란이 없음)
        begin

            update ezjobs.ez_user
            set
                user_nm 					= p_user_nm
              ,user_email 				= p_user_email
              ,user_hp 					= p_user_hp
              ,dept_cd 					= p_dept_cd
              ,duty_cd 					= p_duty_cd
              ,user_tel 					= p_user_tel
              ,absence_start_date 		= CASE WHEN COALESCE(p_absence_start_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_start_date, '/', ''), 'yyyymmdd') END
              ,absence_end_date 			= CASE WHEN COALESCE(p_absence_end_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_end_date, '/', ''), 'yyyymmdd') END
              ,absence_reason 			= p_absence_reason
              ,absence_user_cd 			= CASE WHEN p_absence_user_cd IS NULL THEN '' ELSE p_absence_user_cd END
              ,udt_date 					= sysdate
              ,udt_user_cd 				= p_s_user_cd
              ,udt_user_ip 				= p_s_user_ip
              ,select_data_center_code	= p_select_data_center_code
              ,select_table_name			= CASE WHEN COALESCE(p_select_table_name,'') = '' THEN '' ELSE p_select_table_name END
              ,select_application 		= p_select_application
              ,select_group_name 			= p_select_group_name
              ,del_yn 					= p_del_yn
              ,retire_yn 					= p_retire_yn
              ,account_lock				= p_account_lock
              ,default_paging     		= p_default_paging
              ,reset_yn           		= p_reset_yn
            where user_cd = p_user_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 유저이력관리
            insert into ezjobs.ez_user_history
            SELECT
                user_cd
                 ,user_id
                 ,user_nm
                 ,'user_udt'
                 ,user_gb
                 ,dept_cd
                 ,duty_cd
                 ,del_yn
                 ,retire_yn
                 ,user_email
                 ,user_hp
                 ,user_tel
                 ,select_data_center_code
                 ,account_lock
                 ,ins_date
                 ,ins_user_cd
                 ,ins_user_ip
                 ,udt_date
                 ,udt_user_cd
                 ,udt_user_ip
                 ,select_table_name
                 ,select_application
                 ,select_group_name
                 ,user_appr_gb
                 ,sysdate
                 ,user_ip
            FROM ezjobs.ez_user
            WHERE user_cd = p_user_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag = 'pw_all_clear' or p_flag = 'pw_all_change' then
        begin

            update ezjobs.ez_user
            set user_pw = p_user_pw
            where user_id not in(
                select scode_nm from ezjobs.ez_scode
                where mcode_cd = (select mcode_cd from ezjobs.EZ_MCODE
                                  where del_yn = 'N'
                                    and mcode_cd = 'M64')
                  and del_yn = 'N');

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='del' then
        begin

            update ezjobs.ez_user
            set
                del_yn 			= 'Y'
              ,udt_date 		= sysdate
              ,udt_user_cd 	= p_s_user_cd
              ,udt_user_ip 	= p_s_user_ip
            where user_cd = p_user_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 유저이력관리
            insert into ezjobs.ez_user_history
            SELECT
                user_cd
                 ,user_id
                 ,user_nm
                 ,'del'
                 ,user_gb
                 ,dept_cd
                 ,duty_cd
                 ,del_yn
                 ,retire_yn
                 ,user_email
                 ,user_hp
                 ,user_tel
                 ,select_data_center_code
                 ,account_lock
                 ,ins_date
                 ,ins_user_cd
                 ,ins_user_ip
                 ,udt_date
                 ,udt_user_cd
                 ,udt_user_ip
                 ,select_table_name
                 ,select_application
                 ,select_group_name
                 ,user_appr_gb
                 ,sysdate
                 ,user_ip
            FROM ezjobs.ez_user
            WHERE user_cd = p_user_cd;

        end;
    end if;

    if p_flag ='del_user' then
        begin
            delete from ezjobs.ez_user
            where user_id = p_user_id
            ;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='udt_auth' then
        begin

            update ezjobs.ez_user
            set
                no_auth 		= p_no_auth
              ,udt_date 		= sysdate
              ,udt_user_cd 	= p_s_user_cd
              ,udt_user_ip 	= p_s_user_ip
            where user_cd = p_user_cd;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='pw_fail' then
        begin

            update ezjobs.ez_user set pw_fail_cnt = NVL(pw_fail_cnt, 0) + 1
            where user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='pw_ok' then
        begin

            update ezjobs.ez_user set pw_fail_cnt = 0, account_lock = ''
            where user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='account_lock' then
        begin

            update ezjobs.ez_user set account_lock = 'Y'
            where user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 유저이력관리
            insert into ezjobs.ez_user_history
            SELECT
                user_cd
                 ,user_id
                 ,user_nm
                 ,'account_lock'
                 ,user_gb
                 ,dept_cd
                 ,duty_cd
                 ,del_yn
                 ,retire_yn
                 ,user_email
                 ,user_hp
                 ,user_tel
                 ,select_data_center_code
                 ,account_lock
                 ,ins_date
                 ,ins_user_cd
                 ,ins_user_ip
                 ,udt_date
                 ,udt_user_cd
                 ,udt_user_ip
                 ,select_table_name
                 ,select_application
                 ,select_group_name
                 ,user_appr_gb
                 ,sysdate
                 ,user_ip
            FROM ezjobs.ez_user
            WHERE user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='account_lock_max' then
        begin

            update ezjobs.ez_user set account_lock = 'M'
            where user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='account_lock_init' then
        if p_account_lock = 'M' then
            begin

                update ezjobs.ez_user set account_lock = 'U'
                where user_id = p_user_id;

                if SQL%ROWCOUNT < 1 then
                    begin
                        r_code := '-1';
                        r_msg := 'ERROR.01';
                        RAISE v_ERROR;
                    end;
                end if;

            end;
        else
            begin

                update ezjobs.ez_user set account_lock = 'N'
                where user_id = p_user_id;

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

    if p_flag ='pw_change' then
        begin

            update ezjobs.ez_user set
                                        user_pw 		= p_user_pw,
                                        before_pw 		= p_before_pw,
                                        reset_yn  		= 'N',
                                        pw_date 		= sysdate,
                                        pw_fail_cnt 	= 0,
                                        account_lock 	= 'U'
            where user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

            -- 유저이력관리
            insert into ezjobs.ez_user_history
            SELECT
                user_cd
                 ,user_id
                 ,user_nm
                 ,'pw_change'
                 ,user_gb
                 ,dept_cd
                 ,duty_cd
                 ,del_yn
                 ,retire_yn
                 ,user_email
                 ,user_hp
                 ,user_tel
                 ,select_data_center_code
                 ,account_lock
                 ,ins_date
                 ,ins_user_cd
                 ,ins_user_ip
                 ,udt_date
                 ,udt_user_cd
                 ,udt_user_ip
                 ,select_table_name
                 ,select_application
                 ,select_group_name
                 ,user_appr_gb
                 ,sysdate
                 ,user_ip
            FROM ezjobs.ez_user
            WHERE user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='pw_init' then
        begin

            update ezjobs.ez_user set
                                        user_pw 		= p_user_pw,
                                        pw_date 		= sysdate,
                                        reset_yn  		= 'Y',
                                        account_lock 	= 'U',
                                        udt_date 		= sysdate,
                                        udt_user_cd 	= p_s_user_cd,
                                        udt_user_ip 	= p_s_user_ip
            where user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;
        end;
    end if;

    if p_flag ='pw_all_init' then
        begin

            update ezjobs.ez_user set
                                        user_pw 		= p_user_pw,
                                        pw_date 		= sysdate,
                                        reset_yn  		= 'Y',
                                        account_lock 	= 'U',
                                        udt_date 		= sysdate,
                                        udt_user_cd 	= p_s_user_cd,
                                        udt_user_ip 	= p_s_user_ip
            where user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;

        end;
    end if;

    if p_flag ='USER_BATCH' then
        begin

            /*
            if p_duty_nm is null then
                begin
                    p_duty_nm := '9999';
                end;
            end if;
            if p_dept_nm is null then
                begin
                    p_dept_nm := '9999';
                end;
            end if;
            */

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_USER
            WHERE user_id = p_user_id;

            if v_chk_cnt = 0 then
                begin
                    SELECT NVL(MAX(user_cd), 0) + 1
                    INTO v_max_cnt
                    FROM ezjobs.EZ_USER;

                    INSERT INTO ezjobs.EZ_USER
                    (
                        user_cd
                    ,user_id
                    ,user_nm
                    ,user_pw
                    ,user_gb
                    ,dept_cd
                    ,duty_cd
                    ,del_yn
                    ,retire_yn
                    ,user_email
                    ,user_hp
                    ,select_data_center_code
                    ,select_table_name
                    ,ins_date
                    ,ins_user_cd
                    ,ins_user_ip
                    )
                    VALUES (
                               v_max_cnt
                           ,p_user_id
                           ,p_user_nm
                           ,p_user_pw
                           ,p_user_gb
                           ,(select dept_cd from ezjobs.ez_dept ed where dept_nm = ed.dept_nm and dept_nm = CASE WHEN p_dept_nm is NULL THEN '9999' ELSE p_dept_nm END)
                           ,(select duty_cd from ezjobs.ez_duty ed where duty_nm = ed.duty_nm and duty_nm = CASE WHEN p_duty_nm is NULL THEN '9999' ELSE p_duty_nm END)
                           ,'N'
                           ,'N'
                           ,p_user_email
                           ,p_user_hp
                           ,p_select_data_center_code
                           ,p_select_table_name
                           ,sysdate
                           ,p_s_user_cd
                           ,p_s_user_ip
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

            if v_chk_cnt > 0 then
                begin
                    UPDATE ezjobs.EZ_USER SET
                        user_nm			= p_user_nm
                                              ,user_pw		= p_user_pw
                                              ,dept_cd		= (select dept_cd from ezjobs.ez_dept ed where dept_nm = ed.dept_nm and dept_nm = p_dept_nm)
                                              ,duty_cd		= (select duty_cd from ezjobs.ez_duty ed where duty_nm = ed.duty_nm and duty_nm = p_duty_nm)
                                              ,retire_yn		= 'N'
                                              ,user_email		= p_user_email
                                              ,user_hp		= p_user_hp
                                              ,ins_date		= sysdate
                                              ,udt_date		= sysdate
                                              ,udt_user_cd	= p_s_user_cd
                                              ,udt_user_ip	= p_s_user_ip
                    WHERE user_id = p_user_id;

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

    if p_flag = 'folder_auth' then
        begin
            select COUNT(*)
            into v_chk_cnt
            from ezjobs.EZ_USER_FOLDER
            where 1=1
              and user_cd = p_user_cd
              and folder_auth = p_folder_auth
              and data_center = p_data_center;

            if v_chk_cnt = 0 then
                begin
                    INSERT INTO ezjobs.EZ_USER_FOLDER (
                        user_cd,
                        folder_auth,
                        data_center
                    ) VALUES (
                                 p_user_cd,
                                 p_folder_auth,
                                 p_data_center
                             );

                    if SQL%ROWCOUNT < 1 then
                        begin
                            r_code := '-1';
                            r_msg := 'ERROR.01';
                            RAISE v_ERROR;
                        end;
                    end if;


                    INSERT INTO ezjobs.ez_user_folder_history ( -- 폴더 매핑 이력저장
                                                                 user_cd
                                                                ,folder_auth
                                                                ,data_center
                                                                ,status_gb
                                                                ,ins_date
                                                                ,ins_user_cd
                                                                ,ins_user_ip
                    ) VALUES (
                                 p_user_cd
                             ,p_folder_auth
                             ,p_data_center
                             ,'insert'
                             ,sysdate
                             ,p_s_user_cd
                             ,p_s_user_ip
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
        end;
    end if;

    if p_flag = 'user_folder_auth_delete' then
        begin
            delete from ezjobs.EZ_USER_FOLDER
            where user_cd = p_user_cd
              AND data_center  = p_data_center
              AND folder_auth = p_folder_auth;

            INSERT INTO ezjobs.ez_user_folder_history ( -- 폴더 매핑 이력저장
                                                         user_cd
                                                        ,folder_auth
                                                        ,data_center
                                                        ,status_gb
                                                        ,ins_date
                                                        ,ins_user_cd
                                                        ,ins_user_ip
            ) VALUES (
                         p_user_cd
                     ,p_folder_auth
                     ,p_data_center
                     ,'delete'
                     ,sysdate
                     ,p_s_user_cd
                     ,p_s_user_ip
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

    if p_flag = 'folder_auth_del' then
        begin
            delete from ezjobs.EZ_USER_FOLDER where user_cd = p_user_cd;
        end;
    end if;

    if p_flag ='user_excel_insert' then
        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.ez_user
            WHERE user_id = p_user_id;

            if v_chk_cnt = 0 then
                begin

                    select NVL(max(user_cd),0) + 1
                    into v_max_cnt
                    from ezjobs.ez_user
                    ;

                    insert into ezjobs.ez_user
                    (
                        user_cd
                    ,user_id
                    ,user_nm
                    ,user_pw
                    ,user_gb
                    ,user_email
                    ,user_hp
                    ,dept_cd
                    ,duty_cd
                    ,ins_date
                    ,ins_user_cd
                    ,ins_user_ip
                    ,reset_yn
                    )
                    values (
                               v_max_cnt
                           ,p_user_id
                           ,p_user_nm
                           ,p_user_pw
                           ,p_user_gb
                           ,p_user_email
                           ,p_user_hp
                           ,p_dept_cd
                           ,p_duty_cd
                           ,sysdate
                           ,p_s_user_cd
                           ,p_s_user_ip
                           ,p_reset_yn
                           );

                end;
            end if;


            if v_chk_cnt > 0 then
                begin

                    update ezjobs.ez_user
                    set
                        user_nm 		= p_user_nm
                      ,user_email 	= p_user_email
                      ,user_hp 		= p_user_hp
                      ,dept_cd 		= p_dept_cd
                      ,duty_cd 		= p_duty_cd
                      ,udt_date 		= sysdate
                      ,udt_user_cd 	= p_s_user_cd
                      ,udt_user_ip 	= p_s_user_ip
                    where user_id = p_user_id;

                end;
            end if;


            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;


            -- 유저이력관리
            insert into ezjobs.ez_user_history
            SELECT
                user_cd
                 ,user_id
                 ,user_nm
                 ,(CASE WHEN v_chk_cnt > 0 THEN 'udt' ELSE 'ins' END)
                 ,user_gb
                 ,dept_cd
                 ,duty_cd
                 ,del_yn
                 ,retire_yn
                 ,user_email
                 ,user_hp
                 ,user_tel
                 ,select_data_center_code
                 ,account_lock
                 ,ins_date
                 ,ins_user_cd
                 ,ins_user_ip
                 ,udt_date
                 ,udt_user_cd
                 ,udt_user_ip
                 ,select_table_name
                 ,select_application
                 ,select_group_name
                 ,user_appr_gb
                 ,sysdate
                 ,user_ip
            FROM ezjobs.ez_user
            WHERE user_id = p_user_id;

            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;


        end;
    end if;

    if p_flag = 'user_folder_auth_del' then
        begin
            delete from ezjobs.ez_user_folder where user_cd = p_user_cd and folder_auth = p_folder_auth;
        end;
    end if;

    r_code := '1';
    r_msg := 'DEBUG.01';
    return;

EXCEPTION
    WHEN v_ERROR THEN
        ROLLBACK;
    WHEN OTHERS THEN
        r_code := '-2';
        r_msg := '[' || SQLCODE || '] ' || SQLERRM;
        ROLLBACK;
END;