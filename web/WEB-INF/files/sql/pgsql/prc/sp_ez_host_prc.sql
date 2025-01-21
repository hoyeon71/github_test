-- DROP FUNCTION EZJOBS.sp_ez_host_prc(out varchar, out varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar, in varchar);

CREATE OR REPLACE FUNCTION EZJOBS.sp_ez_host_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_host_cd character varying, p_data_center character varying, p_agent character varying, p_agent_nm character varying, p_agent_id character varying, p_agent_pw character varying, p_file_path character varying, p_access_gubun character varying, p_access_port character varying, p_server_gubun character varying, p_server_lang character varying, p_grp_cd character varying, p_owner character varying, p_certify_gubun character varying, p_s_user_cd character varying, p_s_user_ip character varying)
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

BEGIN
 	
	if p_flag ='ins' then
		begin
			
			select count(*)
			into v_chk_cnt
			from EZJOBS.ez_host
			where data_center = p_data_center
			and agent = p_agent
			and agent_id = p_agent_id;
            
			if v_chk_cnt > 0 then
				begin
					r_code := '-1';   
					r_msg := 'ERROR.18';   
					RAISE EXCEPTION 'rec_affected 0';   
				end;
			end if;
			
			select count(*)
			into v_host_cnt
			from EZJOBS.ez_host
			where data_center = p_data_center
			and agent = p_agent;
			--C-M명 와 중복되는 agent 등록안하기 위해 주석 처리
			--and server_gubun = p_server_gubun;
            
			
			if v_host_cnt > 0 then
				begin   
					r_code := '-1';   
					r_msg := 'ERROR.46';   
					RAISE EXCEPTION 'rec_affected 0';   
				end;   
			end if; 
            
            select EZJOBS.NVL(max(host_cd),0) + 1
			into v_max_cnt
			from EZJOBS.ez_host;
			
			insert into EZJOBS.ez_host  (
                host_cd
				,data_center
				,agent
				,agent_nm
				,agent_id
				,agent_pw
                ,file_path
				,access_gubun
				,access_port
                ,server_gubun
				,server_lang
				,certify_gubun
				,ins_date
				,ins_user_cd
				,ins_user_ip
			)
			values (
                v_max_cnt
				,p_data_center
				,p_agent
				,p_agent_nm
				,p_agent_id
				,p_agent_pw
                ,p_file_path
				,p_access_gubun
				,p_access_port::integer
                ,p_server_gubun
				,p_server_lang
				,p_certify_gubun
				,current_timestamp
				,p_s_user_cd::integer
				,p_s_user_ip
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

	if p_flag ='udt' then
		begin
		
			update EZJOBS.ez_host
			set
				agent_nm        = p_agent_nm
				,agent_id       = p_agent_id
				,agent_pw       = p_agent_pw
                ,file_path      = p_file_path
				,access_gubun   = p_access_gubun
				,access_port    = p_access_port::integer
                ,server_gubun   = p_server_gubun
				,server_lang  	= p_server_lang
				,certify_gubun	= p_certify_gubun
				,udt_date 	    = current_timestamp
				,udt_user_cd 	= p_s_user_cd::integer
				,udt_user_ip    = p_s_user_ip
			where host_cd = p_host_cd::integer;
			
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
			
			--호스트 삭제(ez_host테이블)
			delete from EZJOBS.ez_host where host_cd = p_host_cd::integer;
			
			GET DIAGNOSTICS rec_affected := ROW_COUNT;
			if rec_affected < 1 then
				begin   
					r_code := '-1';   
					r_msg := 'ERROR.01';   
					RAISE EXCEPTION 'rec_affected 0';   
				end;   
			end if; 
		
			--호스트 삭제시 서버 계정 함께 삭제(ez_scode테이블 - mcode('M5'), host_cd 동일 조건)
			delete from EZJOBS.ez_scode where mcode_cd = 'M5' and host_cd = p_host_cd::integer;
			
			--호스트 삭제시 해당 호스트를 수행 서버로 사용중인 그룹 목록에서 함께 삭제(ez_grp_host테이블 - host_cd 동일 조건)
			delete from EZJOBS.ez_grp_host where host_cd = p_host_cd::integer;
		
		end;
	end if;

	if p_flag ='host_udt' then
		begin
		
			select count(*)
			into v_host_cnt
			from EZJOBS.EZ_GRP_HOST
			where GRP_CD = p_grp_cd::integer 
			AND HOST_CD = p_host_cd::integer
			;
			if v_host_cnt < 1 THEN 
				begin
					insert into EZJOBS.EZ_GRP_HOST  (
		                host_cd
						,grp_cd
						,ins_date
						,ins_user_cd
					)
					values (
						p_host_cd::integer
						,p_grp_cd::integer 
						,TO_CHAR(current_timestamp,'YYYYMMDDHH24MISS')
						,p_s_user_cd::integer
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
		end;
	end if;

	if p_flag ='host_del' then
		begin
		
			select count(*)
			into v_host_cnt
			from EZJOBS.EZ_GRP_HOST
			where GRP_CD = p_grp_cd::integer 
			AND HOST_CD = p_host_cd::integer
			;
			if v_host_cnt > 0 THEN 
				begin
					DELETE FROM EZJOBS.EZ_GRP_HOST  
					WHERE GRP_CD = p_grp_cd::integer 
					AND HOST_CD = p_host_cd::integer
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
		end;
	end if;

	if p_flag ='host_del_all' then
		begin
		
			select count(*)
			into v_host_cnt
			from EZJOBS.EZ_GRP_HOST
			where GRP_CD = p_grp_cd::integer 
			;
			if v_host_cnt > 0 THEN 
				begin
					DELETE FROM EZJOBS.EZ_GRP_HOST  
					WHERE GRP_CD = p_grp_cd::integer 
					;
					
--					GET DIAGNOSTICS rec_affected := ROW_COUNT;
--					if rec_affected < 1 then
--						begin   
--							r_code := '-1';   
--							r_msg := 'ERROR.01';   
--							RAISE EXCEPTION 'rec_affected 0';   
--						end;
--					end if; 
				end;
			end if;
		end;
	end if;

	-- 호스트이관
    if p_flag = 'host_takeOver' then
        begin
            --해당 호스트명이 있는지 확인, cnt > 0 이면 exception
			select count(*)
			into v_chk_cnt
			from EZJOBS.ez_host
			where data_center = p_data_center
			and agent = p_agent;
            
			if v_chk_cnt > 0 then
				begin
					r_code := '-1';   
					r_msg := 'ERROR.18';   
					RAISE EXCEPTION 'rec_affected 0';   
				end;
			end if;
		
			select EZJOBS.NVL(max(host_cd),0) + 1
			into v_max_cnt
			from EZJOBS.ez_host;

            IF v_chk_cnt = 0 THEN
                insert into EZJOBS.ez_host  (
                host_cd
				,data_center
				,agent
				,agent_nm
				,agent_id
				,agent_pw
                ,file_path
				,access_gubun
				,access_port
                ,server_gubun
				,server_lang
				,certify_gubun
				
				,ins_date
				,ins_user_cd
				,ins_user_ip
				)
				values (
                v_max_cnt
				,p_data_center
				,p_agent
				,p_agent_nm
				,p_agent_id
				,p_agent_pw
                ,p_file_path
				,p_access_gubun
				,p_access_port::integer
                ,p_server_gubun
				,p_server_lang
				,p_certify_gubun
				
				,current_timestamp
				,p_s_user_cd::integer
				,p_s_user_ip
				);

                GET DIAGNOSTICS rec_affected := ROW_COUNT;
                IF rec_affected < 1 THEN
                    BEGIN
                        r_code := '-1';
                        r_msg := '호스트 이관 실패.';
                        RAISE EXCEPTION 'rec_affected 0';
                    END;
                END IF;
            END IF;
        end;
    end if;
   
    if p_flag = 'owner_takeOver' then
    	begin
	    	select 'S' || EZJOBS.NVL(MAX(REPLACE(scode_cd, 'S', '')::integer + 1), 1)
			into v_scode
			from EZJOBS.ez_scode;
		
			select EZJOBS.NVL(MAX(order_no) + 1, 1)
			into v_order_no
			from EZJOBS.ez_scode
			where host_cd = p_host_cd::integer;
			
			INSERT INTO EZJOBS.EZ_SCODE(
				  MCODE_CD
				, SCODE_CD
				, SCODE_NM
				, SCODE_ENG_NM
				, SCODE_DESC
				, SCODE_USE_YN
				, ORDER_NO
				, INS_DATE
				, HOST_CD
			)
			VALUES(
				  'M5'
				,  v_scode
				, p_owner
				, p_owner
				, p_owner
				, 'Y'
				, v_order_no
				, now()
				, p_host_cd::integer 
			);
		
			GET DIAGNOSTICS rec_affected := ROW_COUNT;
            IF rec_affected < 1 THEN
                BEGIN
                    r_code := '-1';
                    r_msg := '계정 이관 실패.';
                    RAISE EXCEPTION 'rec_affected 0';
                END;
            END IF;
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
