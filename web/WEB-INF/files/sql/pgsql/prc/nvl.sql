CREATE OR REPLACE FUNCTION ezjobs.nvl(p_1 numeric, p_2 numeric)
    RETURNS numeric
    LANGUAGE plpgsql
AS $function$

BEGIN
    return (case when p_1 is null then p_2 else p_1 end);

END;
$function$
;




CREATE OR REPLACE FUNCTION ezjobs.nvl(p_1 character varying, p_2 character varying)
    RETURNS character varying
    LANGUAGE plpgsql
AS $function$

BEGIN
    return (case when p_1 is null then p_2 when p_1='' then p_2 else p_1 end);

END;
$function$
;




CREATE OR REPLACE FUNCTION ezjobs.nvl(p_1 character varying, p_2 numeric)
    RETURNS numeric
    LANGUAGE plpgsql
AS $function$

BEGIN
    return (case when length(p_1)>0 then p_1::numeric else p_2 end);

END;
$function$
;


