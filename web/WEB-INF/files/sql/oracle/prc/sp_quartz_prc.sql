CREATE OR REPLACE PROCEDURE EZJOBS.sp_quartz_prc
(
    r_code OUT 			varchar2,
    r_msg  OUT 			varchar2,
    r_cnt  OUT 			varchar2,

    p_flag 				varchar2,
    p_data_center_code 	varchar2,
    p_active_net_name 	varchar2,
    p_doc_cd 			varchar2, 
    p_fail_comment 		varchar2,
    
    p_job_name 			varchar2,
    p_odate 			varchar2,
    p_result 			varchar2,
    p_result_time 		varchar2,
    p_result_hp 		varchar2,
    
    p_org_cd 			varchar2,
    p_org_nm 			varchar2,
    p_org_nm_eng 		varchar2,
    p_bos_emp_no 		varchar2,
    p_emp_no 			varchar2,
    
    p_emp_nm 			varchar2,
    p_state_cd 			varchar2,
    p_in_email 			varchar2,
    p_duty_cd 			varchar2,
    p_duty_nm 			varchar2,
    
    p_sta_ymd 			varchar2,
    p_end_ymd 			varchar2,
    p_quartz_name 		varchar2,
    p_trace_log_path 	varchar2,
    p_status_cd 		varchar2,
    
    p_status_log 		varchar2,
    p_data_center	 	varchar2,
    p_s_user_cd 		varchar2,
    p_s_user_ip 		varchar2
)

    IS

    v_max_cnt 			number;
    v_str 				varchar2(4000);
	v_main_doc_cd		varchar2(4000);
    v_ERROR 			EXCEPTION;

BEGIN


    if p_flag = 'EZ_AVG_DEL' then
begin
delete from EZJOBS.ez_avg_info
where (order_id, job_name)
          in(
          select order_id, job_name
          from (
                   select row_number() over(ORDER BY start_time) as rnum, order_id, job_name
                   from (
                            select order_id, job_name,start_time
                            from EZJOBS.EZ_AVG_INFO
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

            -- EZ_AVG_INFO 이력 관리

            v_str := 'DELETE FROM EZJOBS.EZ_AVG_INFO 
			       WHERE data_center = ( SELECT data_center FROM EMUSER.COMM WHERE code = '''|| p_data_center_code ||''')
				 AND (order_id, job_name) IN ( SELECT order_id, job_name FROM EMUSER.'|| p_active_net_name ||')';

EXECUTE IMMEDIATE v_str;

v_str := 'INSERT INTO EZJOBS.EZ_AVG_INFO 
			      SELECT (SELECT data_center FROM EMUSER.COMM WHERE code = ''' || p_data_center_code || ''') AS data_center,
				     order_id, job_name, order_table, application, group_name, odate, avg_runtime, start_time, end_time
				FROM EMUSER.' || p_active_net_name||'';

EXECUTE IMMEDIATE v_str;

-- EZ_HISTORY_001 이력 관리
-- 삭제 사유 : 최종 상태를 적재하기 위해 삭제 후 신규 INSERT
v_str := 'DELETE FROM EZJOBS.EZ_HISTORY_' || p_data_center_code || ' WHERE (order_id, job_name) IN ( SELECT order_id, job_name FROM EMUSER.' || p_active_net_name ||  ')';

EXECUTE IMMEDIATE v_str;

v_str := 'INSERT INTO EZJOBS.EZ_HISTORY_' || p_data_center_code || ' SELECT * FROM EMUSER.' || p_active_net_name||'';

EXECUTE IMMEDIATE v_str;


-- 선행 이력 관리
v_str := 'DELETE FROM EZJOBS.EZ_HISTORY_I_' || p_data_center_code || ' WHERE (order_id, condition) IN ( SELECT order_id, condition FROM EMUSER.' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKI_P') ||  ')';

EXECUTE IMMEDIATE v_str;

v_str := 'INSERT INTO EZJOBS.EZ_HISTORY_I_' || p_data_center_code || ' SELECT * FROM EMUSER.' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKI_P') || '';

EXECUTE IMMEDIATE v_str;

-- 후행 이력 관리
v_str := 'DELETE FROM EZJOBS.EZ_HISTORY_O_' || p_data_center_code || ' WHERE (order_id, condition) IN ( SELECT order_id, condition FROM EMUSER.' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKO_P') ||  ')';

EXECUTE IMMEDIATE v_str;

v_str := 'INSERT INTO EZJOBS.EZ_HISTORY_O_' || p_data_center_code || ' SELECT * FROM EMUSER.' || REPLACE(UPPER(p_active_net_name), 'JOB', 'LNKO_P') || '';

EXECUTE IMMEDIATE v_str;

-- 변수 이력 관리
v_str := 'DELETE FROM EZJOBS.EZ_HISTORY_SETVAR_' || p_data_center_code || ' WHERE (order_id, name) IN ( SELECT order_id, name FROM EMUSER.' || REPLACE(UPPER(p_active_net_name), 'JOB', 'SETVAR') ||  ')';

EXECUTE IMMEDIATE v_str;

v_str := 'INSERT INTO EZJOBS.EZ_HISTORY_SETVAR_' || p_data_center_code || ' SELECT * FROM EMUSER.' || REPLACE(UPPER(p_active_net_name), 'JOB', 'SETVAR') || '';

EXECUTE IMMEDIATE v_str;


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
--            v_str := 'DELETE FROM EZJOBS.EZ_RUNINFO_HISTORY WHERE (order_id, job_name) IN (SELECT order_id, job_name FROM EMUSER.' || p_active_net_name || ')
--					     AND data_center = (SELECT DATA_CENTER FROM EMUSER.COMM WHERE code = ''' || p_data_center_code || ''')';
--
--            EXECUTE IMMEDIATE v_str;

--            v_str := 'INSERT INTO EZJOBS.EZ_RUNINFO_HISTORY
--					  SELECT tb1.ORDER_ID, tb1.DATA_CENTER, tb1.SCHED_TABLE, tb1.APPLICATION, tb1.GROUP_NAME, tb1.JOB_MEM_NAME AS JOB_NAME,
--					         tb1.OWNER, tb1.NODE_GROUP, tb1.NODE_ID, tb1.START_TIME, tb1.END_TIME, SUBSTR(tb1.ORDER_DATE, 3, 6) AS ODATE, tb1.RERUN_COUNTER,
--					         CASE WHEN tb1.ENDED_STATUS = ''16'' THEN ''Ended OK''
--					              WHEN tb1.ENDED_STATUS = ''32'' THEN ''Ended Not OK'' END AS STATUS,
--									 tb2.description, ''N'', '''', ''''
--   							    FROM EMUSER.RUNINFO_HISTORY tb1, EMUSER.' || p_active_net_name || ' tb2
--							   WHERE 1 = 1
--								 AND tb1.order_id = tb2.order_id 
--								 AND tb1.job_mem_name = tb2.job_name
--								 AND tb1.data_center = (SELECT DATA_CENTER FROM EMUSER.COMM WHERE code = ''' || p_data_center_code || ''')';

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

EXECUTE IMMEDIATE v_str;

-- 미사용 일수 업데이트
--v_str := 'update EZJOBS.ez_job_mapper set cc_count = EZJOBS.nvl(cc_count, 0) + 1';
--EXECUTE v_str;

--v_str := 'update EZJOBS.ez_job_mapper A set cc_count = 0 from ' || p_active_net_name || ' B where a.job = b.job_name';
--EXECUTE v_str;

v_str := ' UPDATE EZJOBS.ez_job_mapper A SET cc_count = to_char(sysdate, ''YYYYMMDD'') WHERE A.job in (SELECT B.job_name FROM EMUSER.' || p_active_net_name || ' B GROUP BY b.job_name)';
EXECUTE IMMEDIATE v_str;

-- 오류관리 테이블의 AJOB 정보 보정
v_str := ' UPDATE EZJOBS.EZ_ALARM tb1
					   SET (tb1.order_table, tb1.odate, tb1.description, tb1.cyclic) = (SELECT tb2.order_table, tb2.odate, tb2.description, tb2.cyclic
     							  													      FROM EZJOBS.EZ_HISTORY_' || p_data_center_code || ' tb2
     																		   			 WHERE tb1.order_id = tb2.order_id AND tb1.job_name = tb2.job_name)
					   WHERE tb1.odate IS NULL or tb1.odate = '''' ';
EXECUTE IMMEDIATE v_str;

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
          
	        
			v_str := 'INSERT INTO EZJOBS.EZ_ALARM ( alarm_cd, data_center, host_time, job_name, application, group_name, memname, order_id, node_id, run_counter, message, user_cd, order_table, odate, description, cyclic ) 
				SELECT tb1.serial, tb1.data_center, tb1.host_time, tb1.job_name, tb1.application, tb1.group_name, tb1.memname,  tb1.order_id,  tb1.node_id, tb1.run_counter, tb1.message
					, tb2.user_cd_1 as user_cd, tb4.order_table, tb4.odate, tb4.description, tb4.cyclic
				  FROM EMUSER.ALARM tb1
				  LEFT OUTER JOIN EZJOBS.EZ_JOB_MAPPER tb2 
				  ON tb1.job_name = tb2.job  AND tb1.data_center = SUBSTR(tb2.data_center, 5)
				  LEFT OUTER JOIN EMUSER.'||p_active_net_name||' tb4
				  ON tb1.order_id = tb4.order_id 
				 WHERE tb1.serial > ( SELECT COALESCE(MAX(alarm_cd), 1) FROM EZJOBS.EZ_ALARM ) 
				   AND tb1.message in (''Ended not OK'', ''LATE_SUB'', ''LATE_TIME'', ''LATE_EXEC'', ''Ended OK'')
				   and tb1.data_center = '''||p_data_center||'''';

EXECUTE IMMEDIATE v_str;

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
delete from EZJOBS.EZ_CMR_RPLN WHERE data_center = p_data_center;
end;
end if;

    if p_flag = 'forecast' then
begin
INSERT INTO EZJOBS.EZ_CMR_RPLN (data_center, job_name, odate )
VALUES (p_data_center_code, p_job_name, p_odate );
end;
end if;
--doc02에 apply_cd 없어서 주석처리
   /* if p_flag = 'SUSI_API_CALL_OK' then
        begin
 	        UPDATE EZJOBS.EZ_DOC_02 SET apply_cd = '02', apply_date = current_timestamp
            WHERE doc_cd = p_doc_cd and job_name = p_job_name;
        end;
    end if;

    if p_flag = 'SUSI_API_CALL_FAIL' then
        begin
            UPDATE EZJOBS.EZ_DOC_02 SET apply_cd = '04', apply_date = current_timestamp, fail_comment = p_fail_comment
            WHERE doc_cd = p_doc_cd and job_name = p_job_name;
        end;
    end if;*/

    if p_flag = 'API_CALL_END' then
begin
UPDATE EZJOBS.EZ_DOC_MASTER SET apply_cd = '02', apply_date = current_timestamp
WHERE doc_cd = p_doc_cd;
end;
end if;

    if p_flag = 'AUTOCALL_RESULT' then
begin
UPDATE EZJOBS.EZ_SEND_LOG SET return_code = p_result, return_date = current_timestamp
WHERE send_gubun = ( select scode_cd from EZJOBS.ez_scode where mcode_cd = 'M51' AND scode_eng_nm = 'A')
  AND TO_CHAR(send_date, 'YYYYMMDDHH24MISS') = p_result_time
  AND send_info = p_result_hp;
end;
end if;

    if p_flag = 'DEPT_RELAY_DELETE' then
begin
delete from EZJOBS.ez_dept_relay;
end;

end if;
   
   	if p_flag = 'DEPT_RELAY_INSERT' then
begin
insert into EZJOBS.ez_dept_relay (DEPT_NM, INS_DATE)
select dept_nm, sysdate from EZJOBS.ez_user_relay group by dept_nm order by dept_nm;

if SQL%ROWCOUNT < 1 then
begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE  v_ERROR;
end;
end if;
end;
end if;

    if p_flag = 'DUTY_RELAY_DELETE' then
begin
delete from EZJOBS.ez_duty_relay;
end;
end if;
	    
    if p_flag = 'DUTY_RELAY_INSERT' then
BEGIN
insert into EZJOBS.ez_duty_relay (DUTY_NM, INS_DATE)
select duty_nm, sysdate from EZJOBS.ez_user_relay group by duty_nm order by duty_nm;

if SQL%ROWCOUNT < 1 then
begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE  v_ERROR;
end;
end if;
end;
end if;

    if p_flag = 'USER_RELAY_DELETE' then
begin
delete from EZJOBS.ez_user_relay;
end;

end if;

   	if p_flag = 'USER_RELAY_INSERT' then
begin
insert into EZJOBS.ez_user_relay (USER_ID, USER_NM, DUTY_NM, DEPT_NM, USER_EMAIL, USER_HP, INS_DATE)
values (p_emp_no, p_emp_nm, p_duty_nm, p_org_nm, p_in_email, p_result_hp, sysdate);

if SQL%ROWCOUNT < 1 then
begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE  v_ERROR;
end;
end if;
end;
end if;

    if p_flag = 'EZ_QUARTZ_LOG' then
begin

SELECT NVL(MAX(quartz_cd), 0) + 1
INTO v_max_cnt
FROM EZJOBS.ez_quartz_log;

insert into EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date)
values ( v_max_cnt, p_quartz_name, p_trace_log_path, p_status_cd, p_status_log, sysdate);

if SQL%ROWCOUNT < 1 then
begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE  v_ERROR;
end;
end if;
end;
end if;

    if p_flag = 'API_CALL_STANDBY' then
begin

UPDATE EZJOBS.EZ_DOC_MASTER SET apply_cd = '05'
WHERE doc_cd = p_doc_cd;


if SQL%ROWCOUNT < 1 then
begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE  v_ERROR;
end;
end if;
end;
end if;

    if p_flag = 'API_CALL_OK' then
begin

UPDATE EZJOBS.EZ_DOC_MASTER SET apply_cd = '02', apply_date = sysdate
WHERE doc_cd = p_doc_cd;

SELECT main_doc_cd
INTO v_main_doc_cd
FROM EZJOBS.ez_doc_master
WHERE doc_cd = p_doc_cd;

IF v_main_doc_cd IS NOT null THEN
BEGIN
		        	--일괄요청서 반영상태 udt
UPDATE EZJOBS.EZ_DOC_MASTER
SET apply_cd 		= (CASE WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = v_main_doc_cd and apply_cd IS NULL) > 0 THEN ''
                            WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = v_main_doc_cd and apply_cd IS NOT NULL AND apply_cd = '02') > 0 THEN '02'
                            WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = v_main_doc_cd and apply_cd IS NOT NULL AND apply_cd = '02') = 0 THEN '04'
                            ELSE '' END),
    apply_date	= (CASE WHEN (SELECT count(*) FROM EZJOBS.ez_doc_master WHERE main_doc_cd = v_main_doc_cd and apply_cd IS NOT NULL) > 0 THEN current_timestamp ELSE NULL END)
WHERE doc_cd = v_main_doc_cd;
END;
END IF;

UPDATE EZJOBS.EZ_DOC_MASTER SET apply_cd = '02', apply_date = sysdate
WHERE doc_cd = p_doc_cd;

if SQL%ROWCOUNT < 1 then
begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE  v_ERROR;
end;
end if;
end;
end if;

    if p_flag = 'API_CALL_FAIL' then
begin

UPDATE EZJOBS.EZ_DOC_MASTER SET apply_cd = '04', fail_comment = p_fail_comment, apply_date = sysdate
WHERE doc_cd = p_doc_cd;

if SQL%ROWCOUNT < 1 then
begin
                    r_code := '-1';
                    r_msg := 'ERROR.01';
                    RAISE  v_ERROR;
end;
end if;

end;
end if;
   
   --EZ_AVG_TIME 테이블이 존재하지 않아 주석처리
   if p_flag = 'EZ_AVG_TIME' then
BEGIN

INSERT INTO EZJOBS.ez_avg_time_all (JOB_NAME, DATA_CENTER, START_TIME, END_TIME, ORDER_ID, ORDER_DATE, RERUN_COUNTER, INS_DATE)
SELECT
    S.JOB_MEM_NAME AS JOB_NAME,
    S.DATA_CENTER AS DATA_CENTER,
    S.START_TIME AS START_TIME,
    S.END_TIME AS END_TIME,
    S.ORDER_ID AS ORDER_ID,
    S.ORDER_DATE AS ORDER_DATE,
    S.RERUN_COUNTER AS RERUN_COUNTER,
    SYSDATE AS INS_DATE
FROM emuser.RUNINFO_HISTORY S
WHERE to_char(S.start_time, 'YYYY-MM-DD') = to_char(sysdate + INTERVAL '-1' DAY, 'YYYY-MM-DD')
  AND NOT EXISTS (
        SELECT 1
        FROM EZJOBS.ez_avg_time_all T
        WHERE T.DATA_CENTER = S.DATA_CENTER
          AND T.JOB_NAME = S.JOB_MEM_NAME
          AND T.ORDER_ID = S.ORDER_ID
    );


MERGE INTO EZJOBS.EZ_AVG_TIME T USING (select S1.JOB_NAME, S1.DATA_CENTER, max(S1.START_TIME) START_TIME , max(S1.END_TIME) END_TIME
                                         from EZJOBS.ez_avg_time_all S1
                                         where S1.data_center = p_data_center
                                           AND to_char(s1.start_time, 'YYYY-MM-DD') = to_char(sysdate + INTERVAL '-1' DAY, 'YYYY-MM-DD')
                                         group by S1.JOB_NAME, S1.data_center) S
    ON ( S.DATA_CENTER = T.DATA_CENTER AND S.JOB_NAME = T.JOB_NAME )
    WHEN MATCHED THEN
        UPDATE SET  T.AVG_RUN_TIME = round((T.AVG_RUN_TIME+CEIL( EXTRACT(HOUR FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *3600+EXTRACT(MINUTE FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *60+EXTRACT(SECOND FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS')))))/2) ,
            T.AVG_START_TIME = round((T.AVG_START_TIME+CEIL( EXTRACT(HOUR FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *3600+EXTRACT(MINUTE FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *60+EXTRACT(SECOND FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS')))))/2),
            T.AVG_END_TIME  = round((T.AVG_END_TIME+CEIL( EXTRACT(HOUR FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *3600+EXTRACT(MINUTE FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *60+EXTRACT(SECOND FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS')))))/2),
            T.UDT_DATE = sysdate
    WHEN NOT MATCHED THEN
        INSERT (T.JOB_NAME,
                T.DATA_CENTER,
                T.AVG_RUN_TIME,
                T.AVG_START_TIME,
                T.AVG_END_TIME,
                T.INS_DATE)
            VALUES (S.JOB_NAME,
                    S.DATA_CENTER,
                    round(CEIL( EXTRACT(HOUR FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *3600+EXTRACT(MINUTE FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *60+EXTRACT(SECOND FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS') - TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))))),
                    round(CEIL( EXTRACT(HOUR FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *3600+EXTRACT(MINUTE FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *60+EXTRACT(SECOND FROM (TO_TIMESTAMP(TO_CHAR(S.START_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))))),
                    round(CEIL( EXTRACT(HOUR FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *3600+EXTRACT(MINUTE FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))) *60+EXTRACT(SECOND FROM (TO_TIMESTAMP(TO_CHAR(S.END_TIME, 'YYYYMMDDHH24MISS'), 'YYYYMMDDHH24MISS'))))),
                    sysdate)
;
end;
end if;

	
	/*
	if p_flag = 'EZ_RESOURCE1' then	 
		begin		 
     		 INSERT INTO EZJOBS.EZ_RESOURCE ( DATA_CENTER ,QRESNAME, QRTOTAL, QRUSED, INS_DATE) 
			  SELECT p_data_center, a.QRESNAME , a.QRTOTAL, sum(b.JOBUSED) AS QRUSED, SYSDATE  FROM CTMCORE.CMR_QRTAB a, CTMCORE.CMR_QRUSE b 
				WHERE a.QRESNAME = b.QRESNAME(+) 
				GROUP BY  a.QRESNAME , a.QRTOTAL;
		end; 
	end if; 

	if p_flag = 'EZ_RESOURCE2' then	 
		begin		 
     		 INSERT INTO EZJOBS.EZ_RESOURCE (DATA_CENTER, QRESNAME, QRTOTAL, QRUSED, INS_DATE)
			  SELECT p_data_center, a.QRESNAME , a.QRTOTAL, sum(b.JOBUSED) AS QRUSED, SYSDATE  FROM CTMINFO.CMR_QRTAB a, CTMINFO.CMR_QRUSE b
				WHERE a.QRESNAME = b.QRESNAME(+) 
				GROUP BY  a.QRESNAME , a.QRTOTAL;
		end; 
	end if;
	*/

    r_code := '1';
    r_msg := 'DEBUG.01';
    return;


--EXCEPTION
--    WHEN OTHERS THEN
--        r_code := '-1';
--        if r_msg IS NULL then
--            r_msg := 'ERROR.01';
--        end if;
    --r_code := '-2';
    --r_msg := SQLERRM;

EXCEPTION
	WHEN v_ERROR THEN
		ROLLBACK;
WHEN OTHERS THEN
		r_code := '-2';
		r_msg := SQLERRM;
ROLLBACK;
END;