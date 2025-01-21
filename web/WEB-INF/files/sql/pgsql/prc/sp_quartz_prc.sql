CREATE OR REPLACE FUNCTION ezjobs4.sp_quartz_prc(OUT r_code character varying, OUT r_msg character varying, OUT r_cnt character varying, p_flag character varying, p_data_center_code character varying, p_active_net_name character varying, p_doc_cd character varying, p_fail_comment character varying, p_job_name character varying, p_odate character varying, p_result character varying, p_result_time character varying, p_result_hp character varying, p_org_cd character varying, p_org_nm character varying, p_org_nm_eng character varying, p_bos_emp_no character varying, p_emp_no character varying, p_emp_nm character varying, p_state_cd character varying, p_in_email character varying, p_duty_cd character varying, p_duty_nm character varying, p_sta_ymd character varying, p_end_ymd character varying, p_quartz_name character varying, p_trace_log_path character varying, p_status_cd character varying, p_status_log character varying, p_data_center character varying, p_s_user_cd character varying, p_s_user_ip character varying)
 RETURNS record
 LANGUAGE plpgsql
AS $function$

DECLARE

    v_max_cnt 		numeric;
    v_chk_cnt 		numeric;
    v_str character varying(4000);
    rec_affected 	numeric;

BEGIN

    if p_flag = 'EZ_AVG_DEL' then
        begin
            delete from ezjobs4.ez_avg_info
            where (order_id, job_name)
                      in(
                      select order_id, job_name
                      from (
                               select row_number() over() as rnum, order_id, job_name
                               from (
                                        select order_id, job_name,start_time
                                        from ezjobs4.EZ_AVG_INFO
                                        where job_name = p_job_name
                                        order by start_time desc
                                    )tb1
                           )tb2
                      where rnum > 10
                  );

        end;
    end if;

    if p_flag = 'EZ_HISTORY' then
        begin

            /*-- EZ_AVG_INFO 이력 관리

            v_str := 'DELETE FROM ezjobs4.EZ_AVG_INFO
			       WHERE data_center = ( SELECT data_center FROM COMM WHERE code = ''' || p_data_center_code || ''')
				 AND (order_id, job_name) IN ( SELECT order_id, job_name FROM ' || p_active_net_name ||  ')';

            EXECUTE v_str;


            v_str := 'INSERT INTO ezjobs4.EZ_AVG_INFO
			      SELECT (SELECT data_center FROM COMM WHERE code = ''' || p_data_center_code || ''') AS data_center,
				     order_id, job_name, order_table, application, group_name, odate, avg_runtime, start_time, end_time
				FROM ' || p_active_net_name;

            EXECUTE v_str;*/

            -- EZ_HISTORY_001 이력 관리
            v_str := 'DELETE FROM ezjobs4.EZ_HISTORY_' || p_data_center_code || ' WHERE (order_id, job_name) IN ( SELECT order_id, job_name FROM ' || p_active_net_name ||  ')';

            EXECUTE v_str;

            v_str := 'INSERT INTO ezjobs4.EZ_HISTORY_' || p_data_center_code || ' SELECT * FROM ' || p_active_net_name;

            EXECUTE v_str;

            -- 선행 이력 관리
            v_str := 'DELETE FROM ezjobs4.EZ_HISTORY_I_' || p_data_center_code || ' WHERE (order_id, condition) IN ( SELECT order_id, condition FROM ' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKI_P') ||  ')';

            EXECUTE v_str;

            v_str := 'INSERT INTO ezjobs4.EZ_HISTORY_I_' || p_data_center_code || ' SELECT * FROM ' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKI_P')  || '';

            EXECUTE v_str;

            -- 후행 이력 관리
            v_str := 'DELETE FROM ezjobs4.EZ_HISTORY_O_' || p_data_center_code || ' WHERE (order_id, condition) IN ( SELECT order_id, condition FROM ' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKO_P') ||  ')';

            EXECUTE v_str;

            v_str := 'INSERT INTO ezjobs4.EZ_HISTORY_O_' || p_data_center_code || ' SELECT * FROM ' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKO_P')  || '';

            EXECUTE v_str;

            -- 변수 이력 관리
            v_str := 'DELETE FROM ezjobs4.EZ_HISTORY_SETVAR_' || p_data_center_code || ' WHERE (order_id, name) IN ( SELECT order_id, name FROM ' || REPLACE(UPPER(p_active_net_name), 'JOB', 'SETVAR') ||  ')';

            EXECUTE v_str;

            v_str := 'INSERT INTO ezjobs4.EZ_HISTORY_SETVAR_' || p_data_center_code || ' SELECT * FROM ' || REPLACE(UPPER(p_active_net_name), 'JOB', 'SETVAR')  || '';

            EXECUTE v_str;



            -- 수시 작업 상태 관리
            /*
            v_str := 'UPDATE EZ_DOC_02 tb1
                SET status = tb2.status
                FROM ' || p_active_net_name || ' tb2
                WHERE 1=1
                AND tb1.job_name = tb2.job_name
                AND tb1.order_id = tb2.order_id';

            EXECUTE v_str;

            v_str := 'UPDATE EZ_DOC_05 tb1
                SET status = tb2.status
                FROM ' || p_active_net_name || ' tb2
                WHERE 1=1
                AND tb1.job_name = tb2.job_name
                AND tb1.order_id = tb2.order_id';

            EXECUTE v_str;
            */

            -- RUNINFO HISTORY 이력 관리
            -- 기존방식 사용X 2024.11.18 이상훈
--            v_str := 'DELETE FROM ezjobs4.EZ_RUNINFO_HISTORY WHERE (order_id, job_name) IN (SELECT order_id, job_name FROM ' || p_active_net_name || ')
--					     AND data_center = (SELECT DATA_CENTER FROM COMM WHERE code = ''' || p_data_center_code || ''')';

--            EXECUTE v_str;

--            v_str := 'INSERT INTO ezjobs4.EZ_RUNINFO_HISTORY
--					    SELECT tb1.ORDER_ID, tb1.DATA_CENTER, tb1.SCHED_TABLE, tb1.APPLICATION, tb1.GROUP_NAME, tb1.JOB_MEM_NAME AS JOB_NAME,
--					         tb1.OWNER, tb1.NODE_GROUP, tb1.NODE_ID, tb1.START_TIME, tb1.END_TIME, SUBSTR(tb1.ORDER_DATE, 3, 6) AS ODATE, tb1.RERUN_COUNTER,
--					         CASE WHEN tb1.ENDED_STATUS = ''16'' THEN ''Ended OK''
--					              WHEN tb1.ENDED_STATUS = ''32'' THEN ''Ended Not OK'' END AS STATUS,
--									 tb2.description, ''N'', '''', ''''
--   					FROM RUNINFO_HISTORY tb1, ' || p_active_net_name || ' tb2
--						WHERE 1 = 1
--						AND tb1.order_id = tb2.order_id 
--						AND tb1.job_mem_name = tb2.job_name
--						AND tb1.data_center = (SELECT DATA_CENTER FROM COMM WHERE code = ''' || p_data_center_code || ''')';
			
           -- RUNINFO HISTORY 이력 관리 2024.11.18 이상훈
			v_str := 'INSERT INTO ezjobs4.EZ_RUNINFO_HISTORY
					  SELECT tb1.ORDER_ID, tb1.DATA_CENTER, tb1.SCHED_TABLE, tb1.APPLICATION, tb1.GROUP_NAME, tb1.JOB_MEM_NAME AS JOB_NAME,
					         tb1.OWNER, tb1.NODE_GROUP, tb1.NODE_ID, tb1.START_TIME, tb1.END_TIME, SUBSTR(tb1.ORDER_DATE, 3, 6) AS ODATE, tb1.RERUN_COUNTER,
					         CASE WHEN tb1.ENDED_STATUS = ''16'' THEN ''Ended OK''
					              WHEN tb1.ENDED_STATUS = ''32'' THEN ''Ended Not OK'' END AS STATUS,
					         tb2.description, ''N'', '''', ''''
					  FROM RUNINFO_HISTORY tb1
					  INNER JOIN ' || p_active_net_name || ' tb2 ON tb1.order_id = tb2.order_id AND tb1.job_mem_name = tb2.job_name
					  WHERE tb1.data_center = (SELECT DATA_CENTER FROM COMM WHERE code = ''' || p_data_center_code || ''')
					  AND NOT EXISTS (
					       SELECT 1
					       FROM ezjobs4.EZ_RUNINFO_HISTORY h
					       WHERE h.order_id = tb1.order_id
					       AND h.job_name = tb1.JOB_MEM_NAME
					   )';

            EXECUTE v_str;

            -- 미사용 일수 업데이트
            --v_str := 'update ezjobs4.ez_job_mapper set cc_count = ezjobs4.nvl(cc_count, 0) + 1';
            --EXECUTE v_str;

            --v_str := 'update ezjobs4.ez_job_mapper A set cc_count = 0 from ' || p_active_net_name || ' B where a.job = b.job_name';
            --EXECUTE v_str;

            v_str := 'update ezjobs4.ez_job_mapper A set cc_count = to_char(current_timestamp, ''YYYYMMDD'') from ' || p_active_net_name || ' B where a.job = b.job_name';
            EXECUTE v_str;
           
           	-- 오류관리 테이블의 AJOB 정보 보정
			v_str := ' UPDATE ezjobs4.EZ_ALARM tb1
					   SET order_table = tb2.order_table, odate = tb2.odate, description = tb2.description, cyclic = tb2.cyclic
					   FROM ezjobs4.EZ_HISTORY_' || p_data_center_code || ' tb2
					   WHERE tb1.order_id = tb2.order_id AND tb1.job_name = tb2.job_name
					   AND tb1.odate IS NULL or tb1.odate = '''' ';
			EXECUTE v_str;

            /*
            if SQL%ROWCOUNT < 1 then
                begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE v_ERROR;
                end;
            end if;
            */

        end;
    end if;

    if p_flag = 'EZ_ALARM' then
        begin
            EXECUTE 'INSERT INTO ezjobs4.EZ_ALARM ( alarm_cd, data_center, host_time, job_name, application, group_name, memname, order_id, node_id, run_counter, message, user_cd, order_table, odate, description, cyclic )
				SELECT tb1.serial, tb1.data_center, tb1.host_time, tb1.job_name, tb1.application, tb1.group_name, tb1.memname,  tb1.order_id,  tb1.node_id, tb1.run_counter, tb1.message
					, tb2.user_cd_1 as user_cd, tb4.order_table, tb4.odate, tb4.description, tb4.cyclic
				  FROM ALARM tb1
				  LEFT OUTER JOIN ezjobs4.EZ_JOB_MAPPER tb2 
				  ON tb1.job_name = tb2.job  AND tb1.data_center = SUBSTR(tb2.data_center, 5)
				  LEFT OUTER JOIN ' || p_active_net_name || ' tb4
				  ON tb1.order_id = tb4.order_id 
				 WHERE tb1.serial > ( SELECT COALESCE(MAX(alarm_cd), 1) FROM ezjobs4.EZ_ALARM ) 
				   AND tb1.message in (''Ended not OK'', ''LATE_SUB'', ''LATE_TIME'', ''LATE_EXEC'', ''Ended OK'')
				   AND tb1.data_center = '''||p_data_center||'''';
            /*
            EXECUTE 'INSERT INTO EZ_ALARM ( alarm_cd, data_center, host_time, job_name, application, group_name, message, run_counter, user_cd, order_id, update_user_cd, order_table )
                SELECT tb1.serial, tb1.data_center, tb1.host_time, tb1.job_name, tb1.application, tb1.group_name, tb1.message, tb1.run_counter,
                       (case when tb3.user_cd IS NULL then tb2.user_cd_1 else tb3.user_cd end) as user_cd_1, tb1.order_id,
                       (select user_cd from ez_approval_doc where seq = 1 and doc_cd = tb3.doc_cd) as update_user_cd, tb4.order_table
                  FROM ALARM tb1
                  LEFT OUTER JOIN EZ_JOB_MAPPER tb2
                  ON tb1.job_name = tb2.job  AND tb1.data_center = tb2.data_center
                  LEFT OUTER JOIN EZ_SUSI_MAPPER tb3
                  ON tb1.order_id = tb3.order_id
                  LEFT OUTER JOIN ' || p_active_net_name || ' tb4
                  ON tb1.order_id = tb4.order_id
                 WHERE tb1.serial > ( SELECT COALESCE(MAX(alarm_cd), 1) FROM EZ_ALARM )
                   AND tb1.message in (''Ended not OK'', ''LATE_SUB'', ''LATE_TIME'', ''LATE_EXEC'', ''Ended OK'')
                   AND to_char(host_time, ''yyyymmddhh24mi'') > ''2019100220'';';
            */
        end;
    end if;

    if p_flag = 'forecast_del' then
        begin
            delete from ezjobs4.EZ_CMR_RPLN WHERE data_center = p_data_center;
        end;
    end if;

    if p_flag = 'forecast' then
        begin
            INSERT INTO ezjobs4.EZ_CMR_RPLN (data_center, job_name, odate )
            VALUES (p_data_center_code, p_job_name, p_odate );
        end;
    end if;

    --doc02에 apply_cd 없어서 주석처리
    /*
    if p_flag = 'SUSI_API_CALL_OK' then
        begin
              UPDATE ezjobs4.EZ_DOC_02 SET apply_cd = '02', apply_date = current_timestamp
                WHERE doc_cd = p_doc_cd and job_name = p_job_name;
        end;
    end if;

    if p_flag = 'SUSI_API_CALL_FAIL' then
        begin
              UPDATE ezjobs4.EZ_DOC_02 SET apply_cd = '04', apply_date = current_timestamp, fail_comment = p_fail_comment
                WHERE doc_cd = p_doc_cd and job_name = p_job_name;
        end;
    end if;
    */

    if p_flag = 'API_CALL_END' then
        begin
            UPDATE ezjobs4.EZ_DOC_MASTER SET apply_cd = '02', apply_date = current_timestamp
            WHERE doc_cd = p_doc_cd;
        end;
    end if;

    if p_flag = 'AUTOCALL_RESULT' then
        begin
            UPDATE ezjobs4.EZ_SEND_LOG SET return_code = p_result, return_date = current_timestamp
            WHERE send_gubun = ( select scode_cd from ezjobs4.ez_scode where mcode_cd = 'M51' AND scode_eng_nm = 'A')
              AND TO_CHAR(send_date, 'YYYYMMDDHH24MISS') = p_result_time
              AND send_info = p_result_hp;
        end;
    end if;

    if p_flag = 'DEPT_RELAY_DELETE' then
        begin
            delete from ezjobs4.ez_dept_relay;
        end;

    end if;

    if p_flag = 'DEPT_RELAY_INSERT' then
        begin
            insert into ezjobs4.ez_dept_relay (DEPT_NM, INS_DATE)
            select dept_nm, current_timestamp from ezjobs4.ez_user_relay group by dept_nm order by dept_nm;

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

    if p_flag = 'DUTY_RELAY_DELETE' then
        begin
            delete from ezjobs4.ez_duty_relay;
        end;
    end if;

    if p_flag = 'DUTY_RELAY_INSERT' then
        begin
            insert into ezjobs4.ez_duty_relay (DUTY_NM, INS_DATE)
            select duty_nm, current_timestamp from ezjobs4.ez_user_relay group by duty_nm order by duty_nm;

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

    if p_flag = 'USER_RELAY_DELETE' then
        begin
            delete from ezjobs4.ez_user_relay;
        end;

    end if;

    if p_flag = 'USER_RELAY_INSERT' then
        begin
            insert into ezjobs4.ez_user_relay (USER_ID, USER_NM, DUTY_NM, DEPT_NM, USER_EMAIL, USER_HP, INS_DATE)
            values (p_emp_no, p_emp_nm, p_duty_nm, p_org_nm, p_in_email, p_result_hp, current_timestamp);

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

    if p_flag = 'EZ_QUARTZ_LOG' then
        begin

            SELECT ezjobs4.NVL(MAX(quartz_cd), 0) + 1
            INTO v_max_cnt
            FROM ezjobs4.ez_quartz_log;

            insert into ezjobs4.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date)
            values ( v_max_cnt, p_quartz_name, p_trace_log_path, p_status_cd, p_status_log, current_timestamp);

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

    if p_flag = 'API_CALL_STANDBY' then
        begin

            UPDATE ezjobs4.EZ_DOC_MASTER SET apply_cd = '05'
            WHERE doc_cd = p_doc_cd;

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

    if p_flag = 'API_CALL_OK' then
        begin

            UPDATE ezjobs4.EZ_DOC_MASTER SET apply_cd = '02', fail_comment = p_fail_comment, apply_date = now()
            WHERE doc_cd = p_doc_cd;

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

    if p_flag = 'API_CALL_FAIL' then
        begin

            UPDATE ezjobs4.EZ_DOC_MASTER SET apply_cd = '04', fail_comment = p_fail_comment, apply_date = now()
            WHERE doc_cd = p_doc_cd;

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

    if p_flag = 'EZ_AVG_TIME' then
        begin
	        
	        INSERT INTO ezjobs4.ez_avg_time_all (JOB_NAME, DATA_CENTER, START_TIME, END_TIME, ORDER_ID, ORDER_DATE, RERUN_COUNTER, INS_DATE)
            SELECT
                S.JOB_MEM_NAME,
                S.DATA_CENTER,
                S.START_TIME,
                S.END_TIME,
                S.ORDER_ID,
                S.ORDER_DATE,
                S.RERUN_COUNTER,
                CURRENT_TIMESTAMP
            FROM RUNINFO_HISTORY as S
            where 1=1
            AND DATE_TRUNC('day', S.start_time) = DATE_TRUNC('day', CURRENT_DATE - INTERVAL '1' DAY)
            and NOT EXISTS (
                    SELECT 1
                    FROM ezjobs4.ez_avg_time_all AS T
                    WHERE S.DATA_CENTER = T.DATA_CENTER AND S.JOB_MEM_NAME = T.JOB_NAME and S.order_id = T.order_id
                );
	        
	    	
	        
            /*WITH S AS (
                SELECT
                    S1.JOB_MEM_NAME AS JOB_NAME,
                    S1.DATA_CENTER,
                    MAX(S1.START_TIME) AS START_TIME,
                    MAX(S1.END_TIME) AS END_TIME
                FROM RUNINFO_HISTORY S1
                WHERE
                        S1.data_center = p_data_center
                  AND DATE_TRUNC('day', S1.start_time) = DATE_TRUNC('day', CURRENT_DATE - INTERVAL '1' DAY)
                GROUP BY S1.JOB_MEM_NAME, S1.data_center
            )

            -- UPDATE 작업
            UPDATE ezjobs4.EZ_AVG_TIME AS T
            SET
                AVG_RUN_TIME = ROUND((T.AVG_RUN_TIME + CEIL(EXTRACT(EPOCH FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) / 2))),
			    AVG_START_TIME = ROUND((T.AVG_START_TIME + CEIL(EXTRACT(EPOCH FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) / 2))),
			    AVG_END_TIME = ROUND((T.AVG_END_TIME + CEIL(EXTRACT(EPOCH FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) / 2))),
			    UDT_DATE = CURRENT_TIMESTAMP
			FROM S
			WHERE S.DATA_CENTER = T.DATA_CENTER AND S.JOB_NAME = T.JOB_NAME;*/

            WITH S AS (
                SELECT
                    S1.JOB_NAME,
                    S1.DATA_CENTER,
                    MAX(S1.START_TIME) AS START_TIME,
                    MAX(S1.END_TIME) AS END_TIME
                FROM ezjobs4.ez_avg_time_all S1
                WHERE
                        S1.data_center = p_data_center
                  AND DATE_TRUNC('day', S1.start_time) = DATE_TRUNC('day', CURRENT_DATE - INTERVAL '1' DAY)
                GROUP BY S1.JOB_NAME, S1.data_center
            )
            -- INSERT 작업
            INSERT INTO ezjobs4.EZ_AVG_TIME (JOB_NAME, DATA_CENTER, AVG_RUN_TIME, AVG_START_TIME, AVG_END_TIME, INS_DATE)
            SELECT
                S.JOB_NAME,
                S.DATA_CENTER,
                ROUND(CEIL(EXTRACT(EPOCH FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))))),
                ROUND(CEIL(EXTRACT(EPOCH FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))))),
                ROUND(CEIL(EXTRACT(EPOCH FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))))),
                CURRENT_TIMESTAMP
            FROM S
            WHERE NOT EXISTS (
                    SELECT 1
                    FROM ezjobs4.EZ_AVG_TIME AS T
                    WHERE S.DATA_CENTER = T.DATA_CENTER AND S.JOB_NAME = T.JOB_NAME
                );
        end;
    end if;
    if p_flag = 'EZ_RESOURCE1' then
        begin
            INSERT INTO ezjobs4.EZ_RESOURCE ( DATA_CENTER ,QRESNAME, QRTOTAL, QRUSED, INS_DATE)
            SELECT p_data_center, qresname, qrtotal, qrused, current_timestamp FROM dblink('host=postctm18 dbname=ctrlmdb port=15432 user=ctmuser password=ctmpass', 'select a.qresname , a.qrtotal, sum(b.jobused) as qrused  from public.cmr_qrtab a left outer join public.cmr_qruse b on a.qresname = b.qresname group by  a.qresname , a.qrtotal') AS t(qresname text, qrtotal integer, qrused integer);
        end;
    end if;
/*
	if p_flag = 'EZ_RESOURCE1' then	 
		begin		 
     		 INSERT INTO ezjobs4.EZ_RESOURCE ( DATA_CENTER ,QRESNAME, QRTOTAL, QRUSED, INS_DATE) 
			  SELECT p_data_center, qresname, qrtotal, qrused, current_timestamp FROM dblink('host=postctm18 dbname=ctrlmdb port=15433', 'select a.qresname , a.qrtotal, sum(b.jobused) as qrused  from public.cmr_qrtab a, public.cmr_qruse b where a.qresname = b.qresname(+) group by  a.qresname , a.qrtotal') AS t(qresname text, qrtotal text, qrused text);
		end; 
	end if; 

	if p_flag = 'EZ_RESOURCE2' then	 
		begin		 
     		 INSERT INTO ezjobs4.EZ_RESOURCE (DATA_CENTER, QRESNAME, QRTOTAL, QRUSED, INS_DATE)
			  SELECT p_data_center, a.QRESNAME , a.QRTOTAL, sum(b.JOBUSED) AS QRUSED, SYSDATE  FROM CTMINFO.CMR_QRTAB a, CTMINFO.CMR_QRUSE b
				WHERE a.QRESNAME = b.QRESNAME(+) 
				GROUP BY  a.QRESNAME , a.QRTOTAL;
		end; 
	end if;
*/

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
