CREATE OR REPLACE FUNCTION ezjobs.add_months(var_dte date, cnt integer)
    RETURNS SETOF date
    LANGUAGE plpgsql
AS $function$
declare
    qry text;
begin
        qry = format( 'select (''%s''::date + interval ''%s'')::date',var_dte,cnt||' month') ;
    RETURN QUERY
    EXECUTE qry;
end
$function$
;
