CREATE OR REPLACE FUNCTION ezjobs.getuserdeptnm(p_user_cd character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

BEGIN
     RETURN (select tb2.dept_nm from ezjobs.ez_user tb1 left outer join ezjobs.ez_dept tb2 on cast(tb1.dept_cd as integer) = tb2.dept_cd where user_cd = cast(p_user_cd as integer));
END;
$function$
;
