-- DROP FUNCTION ezjobs4.sp_ez_doc_setvar_prc(out varchar, out varchar, in varchar, in varchar, in varchar, in varchar, in varchar);

CREATE OR REPLACE FUNCTION ezjobs4.sp_ez_doc_setvar_prc(OUT r_code character varying, OUT r_msg character varying, p_flag character varying, p_doc_cd character varying, p_seq character varying, p_var_name character varying, p_var_value character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$
DECLARE
	v_chk_cnt 		numeric;
	rec_affected 	numeric;
   
BEGIN
    if p_flag ='ins' then
        INSERT INTO ezjobs4.ez_doc_setvar(
            doc_cd,
            seq,
            var_name,
            var_value
        ) VALUES (
            p_doc_cd,
            p_seq::integer,
            p_var_name,
            p_var_value
        );

        GET DIAGNOSTICS rec_affected := ROW_COUNT;
	        IF rec_affected < 1 THEN
	            r_code := '-1';
	            r_msg := 'ERROR.01';
	            RAISE EXCEPTION 'rec_affected 0';
	        END IF;
    END if;
   
	if p_flag ='udt_kubernetes' then
		begin
			SELECT COUNT(*)
				INTO v_chk_cnt
			FROM ezjobs4.ez_doc_setvar
			WHERE doc_cd = p_doc_cd
				AND var_name = p_var_name;
			
			if v_chk_cnt > 0 then
				begin
					update ezjobs4.ez_doc_setvar 
					set var_value = p_var_value
					where doc_cd = p_doc_cd
					and var_name = p_var_name
					;
				end;
			else
				begin
					INSERT INTO ezjobs4.ez_doc_setvar(
				        doc_cd,
				        seq,
				        var_name,
				        var_value
				    ) VALUES (
				        p_doc_cd,
				        p_seq::integer,
				        p_var_name,
				        p_var_value
				    );
				end;
			end if;
		end;
	
		GET DIAGNOSTICS rec_affected := ROW_COUNT;
	        IF rec_affected < 1 THEN
	          	r_code := '-1';
				r_msg := 'ERROR.01';
		
			RAISE EXCEPTION 'rec_affected 0';
	    END IF;
     end if;

	if p_flag ='database_del' then
        
    	delete from ezjobs4.ez_doc_setvar where doc_cd = p_doc_cd;
    
    END if;
    
    if p_flag ='mft_del' then
        
    	delete from ezjobs4.ez_doc_setvar where doc_cd = p_doc_cd;
    
    END if;
	
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
