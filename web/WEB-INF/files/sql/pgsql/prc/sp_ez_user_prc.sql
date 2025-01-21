CREATE OR REPLACE FUNCTION ezjobs.sp_ez_user_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_user_cd character varying, p_user_id character varying, p_user_nm character varying, p_user_pw character varying, p_user_gb character varying, p_user_email character varying, p_user_hp character varying, p_dept_cd character varying, p_duty_cd character varying, p_no_auth character varying, p_select_data_center_code character varying, p_select_table_name character varying, p_select_application character varying, p_select_group_name character varying, p_del_yn character varying, p_retire_yn character varying, p_pw_fail_cnt character varying, p_pw_date character varying, p_before_pw character varying, p_account_lock character varying, p_user_tel character varying, p_absence_start_date character varying, p_absence_end_date character varying, p_absence_reason character varying, p_absence_user_cd character varying, p_default_paging character varying, p_reset_yn character varying, p_dept_id character varying, p_dept_nm character varying, p_duty_id character varying, p_duty_nm character varying, p_s_user_cd character varying, p_s_user_ip character varying, p_s_user_appr_gb character varying, p_folder_auth character varying, p_all_gb character varying, p_user_ip character varying, p_data_center character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

DECLARE

    v_chk_cnt numeric;
    v_max_cnt numeric;

    rec_affected 	numeric;

    arr_user_cd character varying[];
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
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;

            select ezjobs.NVL(max(user_cd),0) + 1
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
                   ,p_dept_cd::integer
                   ,p_duty_cd::integer
                   ,p_user_tel
                   ,p_s_user_appr_gb
                   ,p_account_lock
                   ,current_timestamp
                   ,p_s_user_cd::integer
                   ,p_s_user_ip
                   ,p_select_data_center_code
                   ,p_select_table_name
                   ,p_del_yn
                   ,p_retire_yn
                   ,p_reset_yn
                   ,p_user_ip
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
					,current_timestamp
					,user_ip
				FROM ezjobs.ez_user
				WHERE user_cd = v_max_cnt
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

    if p_flag = 'udt' then	--유저관리화면에서 사용자정보 update
        begin

            update ezjobs.ez_user
            set
                user_nm 			= p_user_nm
              ,user_pw 			= p_user_pw
              ,user_gb 			= p_user_gb
              ,user_email 		= p_user_email
              ,user_hp 			= p_user_hp
              ,dept_cd 			= p_dept_cd::integer
              ,duty_cd 			= p_duty_cd::integer
              ,absence_start_date 	= CASE WHEN COALESCE(p_absence_start_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_start_date, '/', ''), 'yyyymmdd') END
              ,absence_end_date 	= CASE WHEN COALESCE(p_absence_end_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_end_date, '/', ''), 'yyyymmdd') END
              ,absence_reason 		= p_absence_reason
              ,absence_user_cd 		= CASE WHEN p_absence_user_cd IS NULL THEN '' ELSE p_absence_user_cd END
              ,user_tel 			= p_user_tel
              ,user_appr_gb 		= CASE WHEN p_s_user_appr_gb = '' THEN NULL ELSE p_s_user_appr_gb END

              ,udt_date 			= current_timestamp
              ,udt_user_cd 		= p_s_user_cd::integer
              ,udt_user_ip 		= p_s_user_ip
			  ,select_data_center_code 	= p_select_data_center_code
              ,select_table_name	= p_select_table_name
              ,del_yn 			= p_del_yn
              ,retire_yn 			= p_retire_yn
              ,account_lock		= p_account_lock
              ,before_pw          = p_before_pw
              ,default_paging     = p_default_paging
              ,reset_yn           = p_reset_yn
              ,user_ip     		= p_user_ip

            where user_cd = p_user_cd::integer
            ;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
                end;
            end if;
           
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
					,current_timestamp
					,user_ip
				FROM ezjobs.ez_user
				WHERE user_cd = p_user_cd::integer;
		
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

    if p_flag = 'user_udt' then		--개인정보화면에서 사용자정보 update (2020.06.02기준, 개인정보화면에서는 비밀번호 변경란이 없음)
        begin

            update ezjobs.ez_user
            set
                user_nm 					= p_user_nm
              ,user_email 				= p_user_email
              ,user_hp 					= p_user_hp
              ,dept_cd 					= p_dept_cd::integer
              ,duty_cd 					= p_duty_cd::integer
              ,user_tel 					= p_user_tel
              ,absence_start_date 		= CASE WHEN COALESCE(p_absence_start_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_start_date, '/', ''), 'yyyymmdd') END	--�븮����Ⱓ ���������� �����ǵ��� ����(2020.05.29, �����)
              ,absence_end_date 			= CASE WHEN COALESCE(p_absence_end_date,'') = '' THEN NULL ELSE TO_DATE(REPLACE(p_absence_end_date, '/', ''), 'yyyymmdd') END	--�븮����Ⱓ ���������� �����ǵ��� ����(2020.05.29, �����)
              ,absence_reason 			= p_absence_reason
              ,absence_user_cd 			= CASE WHEN p_absence_user_cd = '' THEN 0 ELSE p_absence_user_cd::integer END
              ,udt_date 					= current_timestamp
              ,udt_user_cd 				= p_s_user_cd::integer
              ,udt_user_ip 				= p_s_user_ip
              ,select_data_center_code	= p_select_data_center_code
              ,select_table_name			= CASE WHEN COALESCE(p_select_table_name,'') = '' THEN NULL ELSE p_select_table_name END
              ,select_application 		= p_select_application
              ,select_group_name 			= p_select_group_name
              ,del_yn 					= p_del_yn
              ,retire_yn 					= p_retire_yn
              ,account_lock				= p_account_lock
              ,default_paging     		= p_default_paging
              ,reset_yn           		= p_reset_yn

            where user_cd = p_user_cd::integer
            ;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
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
					,current_timestamp
					,user_ip
				FROM ezjobs.ez_user
				WHERE user_cd = p_user_cd::integer;
		
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

    if p_flag = 'pw_all_clear' or p_flag = 'pw_all_change' then
        begin

            update ezjobs.ez_user
            set
                user_pw = p_user_pw

            where user_id not in(
                select scode_nm from ezjobs.ez_scode
                where mcode_cd = (select mcode_cd from ezjobs.EZ_MCODE
                                  where del_yn = 'N'
                                    and mcode_cd = 'M64')
                  and del_yn = 'N')
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

    if p_flag ='del' then
        begin

            update ezjobs.ez_user
            set
                del_yn = 'Y'

              ,udt_date 	= current_timestamp
              ,udt_user_cd 	= p_s_user_cd::integer
              ,udt_user_ip = p_s_user_ip
            where user_cd = p_user_cd::integer
            ;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
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
					,current_timestamp
					,user_ip
				FROM ezjobs.ez_user
				WHERE user_cd = p_user_cd::integer;
			
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
   
   if p_flag ='del_user' then
        begin
            delete from ezjobs.ez_user
            where user_id = p_user_id
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

    if p_flag ='udt_auth' then
        begin

            update ezjobs.ez_user
            set
                no_auth = p_no_auth

              ,udt_date 	= current_timestamp
              ,udt_user_cd 	= p_s_user_cd::integer
              ,udt_user_ip = p_s_user_ip
            where user_cd = p_user_cd::integer
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

    if p_flag ='pw_fail' then
        begin

            update ezjobs.ez_user set pw_fail_cnt = ezjobs.NVL(pw_fail_cnt, 0) + 1
            where user_id = p_user_id;

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

    if p_flag ='pw_ok' then
        begin

            update ezjobs.ez_user set pw_fail_cnt = 0, account_lock = ''
            where user_id = p_user_id
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

    if p_flag ='account_lock' then
        begin

            update ezjobs.ez_user set account_lock = 'Y'
            where user_id = p_user_id
            ;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
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
					,current_timestamp
					,user_ip
				FROM ezjobs.ez_user
				WHERE user_id = p_user_id;
			
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

    if p_flag ='account_lock_max' then
        begin

            update ezjobs.ez_user set account_lock = 'M'
            where user_id = p_user_id
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

    if p_flag ='account_lock_init' then
        if p_account_lock = 'M' then
            begin

                update ezjobs.ez_user set pw_fail_cnt = 0, account_lock = 'U'
                where user_id = p_user_id
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
        else
            begin

                update ezjobs.ez_user set pw_fail_cnt = 0, account_lock = 'N'
                where user_id = p_user_id
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
    end if;

    if p_flag ='pw_change' then
        begin

            update ezjobs.ez_user set
                                            user_pw = p_user_pw,
                                            before_pw = p_before_pw,
                                            reset_yn  = 'N',
                                            pw_date = current_timestamp,
                                            pw_fail_cnt = 0,
                                            account_lock = 'U'
            where user_id = p_user_id;

            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
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
					,current_timestamp
					,user_ip
				FROM ezjobs.ez_user
				WHERE user_id = p_user_id;
			
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

    if p_flag ='pw_init' then
        begin

            update ezjobs.ez_user set
                                            user_pw = p_user_pw,
                                            pw_date = current_timestamp,
                                            reset_yn  = 'Y',
                                            account_lock = 'U',
                                            udt_date 	= current_timestamp,
                                            udt_user_cd 	= p_s_user_cd::integer,
                                            udt_user_ip = p_s_user_ip
            where user_id = p_user_id;

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

    if p_flag ='pw_all_init' then
        begin

            update ezjobs.ez_user set
                                            user_pw = p_user_pw,
                                            pw_date = current_timestamp,
                                            reset_yn  = 'Y',
                                            account_lock = 'U',
                                            udt_date 	= current_timestamp,
                                            udt_user_cd 	= p_s_user_cd::integer,
                                            udt_user_ip = p_s_user_ip
            where user_id = p_user_id;

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

    if p_flag ='USER_BATCH_DELETE' then
        begin

            DELETE FROM ezjobs.EZ_USER_BATCH;

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

    if p_flag ='USER_BATCH_INSERT' then
        begin

            insert into ezjobs.EZ_USER_BATCH (
                                                    user_id
                                                   ,user_nm
                                                   ,dept_id
                                                   ,dept_nm
                                                   ,duty_id
                                                   ,duty_nm
                --,user_email
                --,user_hp
                                                   ,user_tel
                                                   ,ins_date
            )
            values (
                       p_user_id
                   ,p_user_nm
                   ,p_dept_id
                   ,p_dept_nm
                   ,p_duty_id
                   ,p_duty_nm
                       --,p_user_email
                       --,p_user_hp
                   ,p_user_tel
                   ,current_timestamp
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

    if p_flag ='USER_INSERT' then
        begin

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.ez_user
            WHERE user_id = p_user_id;

            if v_chk_cnt = 0 then
                begin

                    select ezjobs.NVL(max(user_cd),0) + 1
                    into v_max_cnt
                    from ezjobs.ez_user
                    ;

                    insert into ezjobs.ez_user (
                                                      user_cd
                                                     ,user_id
                                                     ,user_nm
                                                     ,user_pw
                                                     ,user_gb
                        --,user_email
                        --,user_hp
                                                     ,dept_cd
                                                     ,duty_cd
                        --,user_tel
                                                     ,ins_date
                                                     ,ins_user_cd
                                                     ,ins_user_ip
                                                     ,del_yn
                    )
                    values (
                               v_max_cnt
                           ,p_user_id
                           ,p_user_nm
                           ,p_user_pw
                           ,'01'
                               --,p_user_email
                               --,p_user_hp
                           ,(select DEPT_CD from ezjobs.EZ_DEPT where DEPT_ID = p_dept_id and del_yn = 'N')
                           ,(select DUTY_CD from ezjobs.EZ_DUTY where DUTY_ID = p_duty_id and del_yn = 'N')
                               --,p_user_tel

                           ,current_timestamp
                           ,p_s_user_cd::integer
                           ,p_s_user_ip
                           ,'Y'
                           )
                    ;

                end;
            end if;


            if v_chk_cnt > 0 then
                begin

                    update ezjobs.ez_user
                    set
                        user_nm = p_user_nm
                      --,user_email = p_user_email
                      --,user_hp = p_user_hp
                      ,dept_cd = (select DEPT_CD from ezjobs.EZ_DEPT where DEPT_ID = p_dept_id and del_yn = 'N')
                      ,duty_cd = (select DUTY_CD from ezjobs.EZ_DUTY where DUTY_ID = p_duty_id and del_yn = 'N')
                      -- ,user_tel = p_user_tel
                      ,udt_date 	= current_timestamp
                      ,udt_user_cd 	= p_s_user_cd::integer
                      ,udt_user_ip = p_s_user_ip

                    where user_id = p_user_id
                    ;


                end;
            end if;

            update ezjobs.ez_user set
                                            account_lock = 'Y',
                                            del_yn = 'Y'
            where user_id not in (select user_id from ezjobs.ez_user_batch)
              and user_id not in (select scode_nm from ezjobs.ez_scode where mcode_cd = 'M66');

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

    -- ���̹� �λ翬�� ���� �߰�(2020.6.22, �����)
    if p_flag ='USER_BATCH' then
        begin

            if p_duty_nm is null then
                begin
                    p_duty_nm = '9999';
                end;
            end if;
            if p_dept_nm is null then
                begin
                    p_dept_nm = '9999';
                end;
            end if;

            SELECT COUNT(*)
            INTO v_chk_cnt
            FROM ezjobs.EZ_USER
            WHERE user_id = p_user_id;

            if v_chk_cnt = 0 then
                begin
                    SELECT ezjobs.NVL(MAX(user_cd), 0) + 1
                    INTO v_max_cnt
                    FROM ezjobs.EZ_USER;

                    INSERT INTO ezjobs.EZ_USER (
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
                           ,(select dept_cd from ezjobs.ez_dept ed where dept_nm = ed.dept_nm and dept_nm = p_dept_nm)
                           ,(select duty_cd from ezjobs.ez_duty ed where duty_nm = ed.duty_nm and duty_nm = p_duty_nm)
                               --,p_dept_cd::integer
                               --,p_duty_cd::integer
                           ,'N'
                           ,'N'
                           ,p_user_email
                           ,p_user_hp
                           ,p_select_data_center_code
                           ,p_select_table_name

                           ,current_timestamp
                           ,p_s_user_cd::integer
                           ,p_s_user_ip
                           );

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

            if v_chk_cnt > 0 then
                begin
                    UPDATE ezjobs.EZ_USER SET
                        user_nm			= p_user_nm
                                                  ,user_pw			= p_user_pw
                                                  ,dept_cd		= (select dept_cd::integer from ezjobs.ez_dept ed where dept_nm = ed.dept_nm and dept_nm = p_dept_nm)
                                                  ,duty_cd		= (select duty_cd::integer from ezjobs.ez_duty ed where duty_nm = ed.duty_nm and duty_nm = p_duty_nm)
                                                  ,retire_yn		= 'N'
                                                  ,user_email		= p_user_email
                                                  ,user_hp		= p_user_hp

                                                  ,ins_date		= current_timestamp
                                                  ,udt_date		= current_timestamp
                                                  ,udt_user_cd	= p_s_user_cd::integer
                                                  ,udt_user_ip	= p_s_user_ip
                    WHERE user_id = p_user_id;

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
        end;
    end if;

    if p_flag = 'folder_auth' then
        begin
           select COUNT(*)
	        into v_chk_cnt
	        from ezjobs.EZ_USER_FOLDER
	        where 1=1
	        and user_cd = p_user_cd::integer
	        and folder_auth = p_folder_auth
	      	and data_center = p_data_center;
	       
	       	if v_chk_cnt = 0 then
	       		begin
		            INSERT INTO ezjobs.EZ_USER_FOLDER (
		                user_cd,
		                folder_auth,
		                data_center
		            ) VALUES (
                         p_user_cd::integer,
                         p_folder_auth,
                         p_data_center
                    );
		
		            GET DIAGNOSTICS rec_affected := ROW_COUNT;
		            if rec_affected < 1 then
		                begin
		                    r_code := '-1';
		                    r_msg := 'ERROR.01';
		                    RAISE EXCEPTION 'rec_affected 0';
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
		           		p_user_cd::integer
		           		,p_folder_auth
		           		,p_data_center
		           		,'insert'
		           		,current_timestamp
		           		,p_s_user_cd::integer
		           		,p_s_user_ip
		           );
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
        end;
    end if;
    
    if p_flag = 'user_folder_auth_delete' then
        begin
            delete from ezjobs.EZ_USER_FOLDER
           	where user_cd = p_user_cd::integer 
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
           		p_user_cd::integer
           		,p_folder_auth
           		,p_data_center
           		,'delete'
           		,current_timestamp
           		,p_s_user_cd::integer
           		,p_s_user_ip
           );
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

    if p_flag = 'folder_auth_del' then
        begin
            delete from ezjobs.EZ_USER_FOLDER where user_cd = p_user_cd::integer;
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

                    select ezjobs.NVL(max(user_cd),0) + 1
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
                           ,p_dept_cd::integer
                           ,p_duty_cd::integer
                           ,current_timestamp
                           ,p_s_user_cd::integer
                           ,p_s_user_ip
                           ,p_reset_yn
                           )
                    ;

                end;
            end if;


            if v_chk_cnt > 0 then
                begin

                    update ezjobs.ez_user
                    set
                        user_nm = p_user_nm
                      ,user_email = p_user_email
                      ,user_hp = p_user_hp
                      ,dept_cd = p_dept_cd::integer
                      ,duty_cd = p_duty_cd::integer
                      ,udt_date 	= current_timestamp
                      ,udt_user_cd 	= p_s_user_cd::integer
                      ,udt_user_ip = p_s_user_ip

                    where user_id = p_user_id
                    ;

                end;
            end if;


            GET DIAGNOSTICS rec_affected := ROW_COUNT;
            if rec_affected < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE EXCEPTION 'rec_affected 0';
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
					,current_timestamp
					,user_ip
				FROM ezjobs.ez_user
				WHERE user_id = p_user_id;
			
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

    if p_flag = 'user_folder_auth_del' then
        begin
            delete from ezjobs.ez_user_folder where user_cd = p_user_cd::integer and folder_auth = p_folder_auth;
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
$function$
;
