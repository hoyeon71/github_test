CREATE OR REPLACE PROCEDURE EZJOBS4O.sp_ez_doc_setvar_prc
(
    r_code out varchar2
	,r_msg out varchar2
	
	,p_flag varchar2
	,p_doc_cd varchar2
	,p_seq varchar2
	,p_var_name varchar2
	,p_var_value varchar2
) is

	v_chk_cnt 	numeric;
    v_ERROR 	EXCEPTION;

BEGIN
    if p_flag ='ins' then
        INSERT INTO ezjobs4o.ez_doc_setvar(
            doc_cd,
            seq,
            var_name,
            var_value
        ) VALUES (
            p_doc_cd,
            cast(p_seq as number),
            p_var_name,
            p_var_value
        );

      	if SQL%ROWCOUNT < 1 then
				begin
					r_code := '-1';
					r_msg := 'ERROR.01';
					RAISE v_ERROR;
				end;
		end if;
    END if;
   
   if p_flag ='udt_kubernetes' then
		begin
			SELECT COUNT(*)
				INTO v_chk_cnt
			FROM ezjobs4o.ez_doc_setvar
			WHERE doc_cd = p_doc_cd
				AND var_name = p_var_name;
			
			if v_chk_cnt > 0 then
				begin
					update ezjobs4o.ez_doc_setvar 
					set var_value = p_var_value
					where doc_cd = p_doc_cd
					and var_name = p_var_name
					;
				end;
			else
				begin
					INSERT INTO ezjobs4o.ez_doc_setvar(
				        doc_cd,
				        seq,
				        var_name,
				        var_value
				    ) VALUES (
				        p_doc_cd,
				        cast(p_seq as number),
				        p_var_name,
				        p_var_value
				    );
				end;
			end if;
		end;
	
		if SQL%ROWCOUNT < 1 then
			begin
				r_code := '-1';
				r_msg := 'ERROR.01';
				RAISE v_ERROR;
			end;
		end if;
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