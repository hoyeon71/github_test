CREATE OR REPLACE FUNCTION EZJOBS.get_vr_group_rba(
	p_rba character varying
	,p_active_net_name character varying
	
) RETURN character varying AS

	v_rba 		character varying(4000);
	v_grp_rba 	character varying(4000);
	v_sql 		character varying(4000);

BEGIN
	
	-- 초기값 설정
    v_rba := p_rba;
   
   	-- 루트 rba를 찾을 때까지 반복
	LOOP
	    -- 동적 SQL 실행
	    v_sql := 'SELECT grp_rba INTO :v_grp_rba FROM EMUSER.' || p_active_net_name || ' WHERE rba = ''' || v_rba || '''';
	    
	    EXECUTE IMMEDIATE v_sql INTO v_grp_rba;
	    
	    -- grp_rba가 '000000'이면 루프 종료
	    IF v_grp_rba = '000000' THEN
	        EXIT; -- 루프를 종료
	    END IF;
	    
	    -- grp_rba를 v_rba로 업데이트
	    v_rba := v_grp_rba;
	
	END LOOP;
	
 	return v_rba;
	
END;