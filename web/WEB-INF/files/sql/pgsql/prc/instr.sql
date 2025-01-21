CREATE OR REPLACE FUNCTION ezjobs.instr(string character varying, string_to_search character varying)
    RETURNS integer
    LANGUAGE plpgsql
AS $function$

DECLARE
    pos integer NOT NULL DEFAULT 0;
    temp_str character varying;
    beg integer;
    length integer;
    ss_length integer;

BEGIN
    temp_str := substring(string FROM 1);
    pos := position(string_to_search IN temp_str);

    IF pos = 0 THEN
        RETURN 0;
    ELSE
        RETURN pos;
    END IF;
END;
$function$
;

CREATE OR REPLACE FUNCTION ezjobs.instr(string character varying, string_to_search character varying, beg_index integer)
    RETURNS integer
    LANGUAGE plpgsql
AS $function$

DECLARE
    pos integer NOT NULL DEFAULT 0;
    temp_str character varying;
    beg integer;
    length integer;
    ss_length integer;

BEGIN
    IF beg_index > 0 THEN
        temp_str := substring(string FROM beg_index);
        pos := position(string_to_search IN temp_str);

        IF pos = 0 THEN
            RETURN 0;
        ELSE
            RETURN pos + beg_index - 1;
        END IF;
    ELSE
        ss_length := char_length(string_to_search);
        length := char_length(string);
        beg := length + beg_index - ss_length + 2;

        WHILE beg > 0 LOOP
                temp_str := substring(string FROM beg FOR ss_length);
                pos := position(string_to_search IN temp_str);

                IF pos > 0 THEN
                    RETURN beg;
                END IF;

                beg := beg - 1;
            END LOOP;

        RETURN 0;
    END IF;
END;
$function$
;
