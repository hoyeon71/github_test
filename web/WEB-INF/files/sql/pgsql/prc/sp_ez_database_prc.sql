CREATE OR REPLACE FUNCTION ezjobs.sp_ez_database_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_database_cd character varying, p_profile_name character varying, p_data_center character varying, p_type character varying, p_port character varying, p_host character varying, p_user_nm character varying, p_password character varying, p_database_name character varying, p_database_version character varying, p_sid character varying, p_target_agent character varying, p_s_user_cd character varying, p_s_user_ip character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

DECLARE
	
	v_chk_cnt  numeric;
	v_host_cnt numeric;
	v_max_cnt  numeric;
	v_order_no numeric;
	v_scode    character varying(16);
--	v_scode   int4;
	
	rec_affected 	numeric;

begin
	
	-- DB이관
    if p_flag = 'database_takeOver' then
        begin
			select ezjobs4.NVL(max(database_cd), 0) + 1
			into v_max_cnt
			from ezjobs4.ez_database;

                insert into ezjobs4.ez_database (
                database_cd
                ,profile_name
                ,data_center
				,"type" 
				,port
				,host
				,user_nm
				,database_name
                ,database_version
				,sid
				,target_agent
				,ins_date
                ,ins_user_cd 
				,ins_user_ip
				)
				values (
                v_max_cnt
                ,p_profile_name
				,p_data_center
				,p_type
				,p_port::integer
				,p_host
				,p_user_nm
                ,p_database_name
                ,p_database_version
				,p_sid
				,p_target_agent
                ,current_timestamp
				,p_s_user_cd::integer
				,p_s_user_ip
				
				);
--
                GET DIAGNOSTICS rec_affected := ROW_COUNT;
                IF rec_affected < 1 THEN
                    BEGIN
                        r_code := '-1';
                        r_msg := 'DB 이관 실패.';
                        RAISE EXCEPTION 'rec_affected 0';
                    END;
                END IF;
        end;
    end if;
   
   if p_flag ='udt' then
		begin
		
			update ezjobs4.ez_database 
			set
				profile_name   		= p_profile_name
				,data_center      	= p_data_center
				,database_version   = p_database_version
				,database_name   	= p_database_name
				,sid      		 	= p_sid
				,port    			= p_port::integer
				,host 				= p_host
                ,user_nm   			= p_user_nm
                ,"password" 		= p_password
				,"type"  			= p_type
				,udt_date 	    	= current_timestamp
				,udt_user_cd 		= p_s_user_cd::integer
				,udt_user_ip    	= p_s_user_ip
			where database_cd = p_database_cd::integer;
			
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
			
			delete from ezjobs4.ez_database where database_cd = p_database_cd::integer;
			
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
