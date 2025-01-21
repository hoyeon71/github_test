CREATE OR REPLACE FUNCTION ezjobs.getmaxcd(p_1 character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

BEGIN
 	return to_char(now(),'yyyymmdd') || lpad((nvl(replace(p_1,to_char(now(),'yyyymmdd'),''),'0')::numeric+1)::character varying,6,'0');
	
END;
$function$
;
