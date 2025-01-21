--2024-02-01 기준 동기화
-- 기본 부서
INSERT INTO ezjobs.ez_dept (dept_cd,dept_nm,del_yn,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,dept_id) VALUES 
(1,'부서','N',current_timestamp,1,'0:0:0:0:0:0:0:1',current_timestamp,1,'0:0:0:0:0:0:0:1',NULL);

-- 기본 직책
INSERT INTO ezjobs.ez_duty (duty_cd,duty_nm,del_yn,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,duty_id) VALUES 
(1,'직책1','N',current_timestamp,1,'0:0:0:0:0:0:0:1',current_timestamp,1,'0:0:0:0:0:0:0:1',NULL);

-- 기본 유저(패스워드 server_gb이 추가됨으로써 login.jsp에서 bypass시켜줘야할수도있음)
INSERT INTO ezjobs.ez_user (user_cd,user_id,user_nm,user_pw,user_gb,no_auth,dept_cd,duty_cd,del_yn,retire_yn,reset_yn,user_email,user_hp,user_tel,select_data_center_code,pw_fail_cnt,pw_date,before_pw,account_lock,absence_start_date,absence_end_date,absence_reason,absence_user_cd,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,default_paging,select_table_name,select_application,select_group_name,user_appr_gb)
VALUES (1,'admin','관리자','99d0a3fbac7121e7280cfef5a8712e5bf041e7b1526bde94dd76585fa1a60d5f','99',NULL,1,1,'N','N',NULL,'example@naver.com','','','',NULL,current_timestamp,'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','N',NULL,NULL,'',0,current_timestamp,1,'127.0.0.1',current_timestamp,1,'0:0:0:0:0:0:0:1',NULL,'','','','00');

INSERT INTO ezjobs.EZ_LOGIN_LOG (LOGIN_CD, INS_DATE, INS_USER_CD, INS_USER_IP) VALUES(1, current_timestamp, 1, '0:0:0:0:0:0:0:1');

-- mcode
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M51','발송구분','N',current_timestamp,'발송구분');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M42','작업유형구분','N',current_timestamp,'작업유형구분');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M9','배치작업등급','N',current_timestamp,'배치작업등급');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M1','C-M 한글명','N',current_timestamp,NULL);
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M71','SYSOUT 라인 제한','N',current_timestamp,'SYSOUT 조회 가능한 라인 제안');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M5','서버계정','N',current_timestamp,'서버계정 마스터 코드');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M72','작업 통제','N',current_timestamp,'작업 통제');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M6','CTM 관리','N',current_timestamp,'CTM 관리 마스터 코드');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M73','결재알림발송여부','N',current_timestamp,'알림발송여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M76','장기미사용 일수','N',current_timestamp,'장기미사용 일수');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M3','패스워드변경 주기','N',current_timestamp,'패스워드변경 주기');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M2','EzJOBs 배치 수행 서버','N',current_timestamp,'EzJOBs 배치 수행 서버');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M80','운영즉시결재노출','N',current_timestamp,'운영즉시결재노출');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M85','CM_SCHEMA','N',current_timestamp,'CM_SCHEMA');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M82','변수 기본값','N',current_timestamp,'변수 기본값');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M86','평균수행시간알림 발송 여부','N',current_timestamp,'평균수행시간알림 발송 여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M81','리소스 기본값','N',current_timestamp,'리소스 기본값');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M91','실시간 작업 속성 변경 시 비활성화 문자열','N',current_timestamp,'실시간 작업 속성 변경 시 비활성화 문자열');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M92','오류처리 결재여부','N',current_timestamp,'오류처리 결재여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M95','사용자의 폴더 권한 사용 여부','N',current_timestamp,'사용자의 폴더 권한 사용 여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M96','폴더의 수행 서버 권한 사용 여부','N',current_timestamp,'폴더의 수행 서버 권한 사용 여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M97','쿠버네티스 NFS 경로','N',current_timestamp,'쿠버네티스 NFS 경로');

-- scode
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M71','S1188','8000',1,current_timestamp,'8000','8000라인까지 조회가능','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M9','S56','2등급',2,current_timestamp,'2','DB의 변경작업, 특정 고객이나 당행직원이 영향을 받는 경우','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M9','S57','3등급',3,current_timestamp,'3','DB의 변경작업이 없는 단순 조회 작업이나 정기배치작업의 재처리','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M1','S10','001-TEST',1,current_timestamp,'1',NULL,'Y',NULL);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M9','S55','1등급',1,current_timestamp,'1','DB의 변경작업, 영향받는 고객이 불특정 다수인 작업','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M42','S1181','DUMMY',3,current_timestamp,'dummy','DUMMY','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M42','S1195','SCRIPT',1,current_timestamp,'job','SCRIPT','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M42','S608','COMMAND',2,current_timestamp,'command','COMMAND','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M72','S1194','N',1,current_timestamp,'N','N','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M51','S831','메일',2,current_timestamp,'M','메일','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M51','S830','SMS',1,current_timestamp,'S','SMS','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M51','S1196','메신저',3,current_timestamp,'U','메신저','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M5','S1197','ctmuser',1,current_timestamp,'ctmuser','ctmuser','Y',1);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M5','S1198','emuser',2,current_timestamp,'emuser','emuser ','Y',1);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M3','S30','90',1,current_timestamp,'90','패스워드변경 주기','Y',NULL);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M76','S1209','100',1,current_timestamp,'100',NULL,'Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M6','S54','EZJOBS4',1,current_timestamp,(select max(data_center) from comm),'EZJOBS4','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M73','S1199','N',1,current_timestamp,'Y','Y','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M92','S1283','N',1,current_timestamp,'N','오류처리 결재여부 설정','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M86','S1284','N',1,current_timestamp,'N','평균수행시간알림 발송 여부','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M80','S1285','N',1,current_timestamp,'N','운영즉시결재노출여부','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M95','S1307','Y',1,current_timestamp,'Y','사용자의 폴더 권한 체크 로직 및 UI 노출 제한 제거','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M96','S1306','Y',1,current_timestamp,'Y','폴더의 수행 서버 권한 체크 로직 및 UI 노출 제한 제거','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M97','S1314','/NFS/','NFS 경로',current_timestamp,'Y','','Y',0);

-- 코드관리 : 오류관리 조회 계정 추가
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M74','오류관리 조회 계정','N',current_timestamp,'오류관리 조회 계정');
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M74','S1203','user1',1,current_timestamp,'user1','user1','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M74','S1204','user2',1,current_timestamp,'user2','user2','Y',0);

-- 코드관리 : 오류 시 알림 발송 여부 (2022.11.02 강명준)
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M75','오류 시 알림 발송 여부','N',current_timestamp,'오류 시 알림 발송 여부');
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M75','S1206','N',1,current_timestamp,'N','N','Y',0);

-- SMS, MAIL 기본값, 체크유무
INSERT INTO EZJOBS.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M87', 'S1262', 'N', 1, current_timestamp, 'SMS', '텍스트/체크박스 체크 유무', 'Y', 0);
INSERT INTO EZJOBS.ez_mcode (mcode_cd, mcode_nm, del_yn, ins_date, mcode_gubun, mcode_desc) VALUES('M87', 'SMS 기본값', 'N', current_timestamp,'' , '기본값, 체크유무');
INSERT INTO EZJOBS.ez_mcode (mcode_cd, mcode_nm, del_yn, ins_date, mcode_gubun, mcode_desc) VALUES('M88', 'MAIL 기본값', 'N', current_timestamp, '', '기본값, 체크유무');

-- 알림설정관리 기본 데이터 (2024.11.29 최호연)
INSERT INTO ezjobs.ez_alarm_info (alarm_seq,alarm_standard,alarm_min,alarm_max,alarm_unit,alarm_time,alarm_over,alarm_over_time) VALUES
	 (4,'3분~10분','3','10','min','perform','10','min'),
	 (6,'1시간~3시간','1','3','hour','average','1','hour'),
	 (7,'3시간~5시간','3','5','hour','average','5','hour'),
	 (8,'5시간~10시간','5','10','hour','average','10','hour'),
	 (9,'10시간~','10',NULL,'hour','average','10','hour'),
	 (3,'1분~3분','1','3','min','perform','3','min'),
	 (2,'1분이하','0','1','min','perform','1','min'),
	 (5,'10분~1시간','10','60','min','average','1','hour');


/*EZJOBS배치조회 */
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(1, 'EZ_ALARM', 'WEB-INF/logs/EzSmsJobServiceImpl/', '1', '처리완료', current_timestamp);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(2, 'EZ_USER_INFO', 'WEB-INF/logs/EzUserInfoGetJobServiceImpl/', '1', '처리완료', current_timestamp);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(3, 'EZ_RESOURCE', 'WEB-INF/logs/EzResourceJobServiceImpl/', '1', '처리완료', current_timestamp);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(4, 'EZ_HISTORY_001', 'WEB-INF/logs/EzHistoryJobServiceImpl/', '1', '처리완료', current_timestamp);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(6, 'EZ_LOG_DEL', 'WEB-INF/logs/EzLogDeleteJobServiceImpl/', '1', '처리완료', current_timestamp);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(7, 'EZ_AVG_TIME', 'WEB-INF/logs/EzAvgTimeJobServiceImpl/', '1', '처리완료', current_timestamp);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(8, 'EZ_RPLNJOB_001', 'WEB-INF/logs/EzRplnJobServiceImpl/', '1', '처리완료', current_timestamp);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(9, 'EZ_AVG_OVERTIME', 'WEB-INF/logs/EzAvgTimeOverJobServiceImpl/', '1', '처리완료', current_timestamp);

/*필수결재선 */
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (1,'등록-순차','Y',1,NULL,1,'01',NULL,NULL,'N');
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (2,'등록-후결','Y',1,NULL,1,'01',NULL,NULL,'Y');
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (3,'실행-순차','Y',1,NULL,1,'05',NULL,NULL,'N');
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (4,'실행-후결','Y',1,NULL,1,'05',NULL,NULL,'Y');
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (5,'상태변경-순차','Y',1,NULL,1,'07',NULL,NULL,'N');
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (6,'상태변경-후결','Y',1,NULL,1,'07',NULL,NULL,'Y');
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (7,'오류처리-순차','Y',1,NULL,1,'10',NULL,NULL,'N');
INSERT INTO EZJOBS.ez_admin_approval_group (admin_line_grp_cd,admin_line_grp_nm,use_yn,owner_user_cd,ins_date,ins_user_cd,doc_gubun,top_level_yn,schedule_yn,post_approval_yn) VALUES (8,'오류처리-후결','Y',1,NULL,1,'10',NULL,NULL,'Y');

--코드관리 통보사유
INSERT INTO ezjobs.ez_mcode (mcode_cd, mcode_nm, del_yn, ins_date, mcode_desc) VALUES('M93', '통보사유', 'N', '2024-04-23 23:03:03.410', '통보사유');
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1287', 'Ended not OK', 1, current_timestamp, '에러발생', 'Ended not OK', 'Y', 0);
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1288', 'Ended OK', 2, current_timestamp, '정상종료', 'Ended OK', 'Y', 0);
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1289', 'LATE_SUB', 3, current_timestamp, '시작임계시간초과', 'LATE_SUB', 'Y', 0);
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1290', 'LATE_TIME', 4, current_timestamp, '종료임계시간초과', 'LATE_TIME', 'Y', 0);
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1291', 'LATE_EXEC', 5, current_timestamp, '수행임계시간초과', 'LATE_EXEC', 'Y', 0);
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1292', 'AVG_OVERTIME', 6, current_timestamp, '평균수행시간초과', 'AVG_OVERTIME', 'Y', 0);
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1293', 'APPROVAL', 7, current_timestamp, '결재통보', 'APPROVAL', 'Y', 0);
INSERT INTO ezjobs.ez_scode (mcode_cd, scode_cd, scode_nm, order_no, ins_date, scode_eng_nm, scode_desc, scode_use_yn, host_cd) VALUES('M93', 'S1294', 'EXEC', 8, current_timestamp, '반영완료', 'EXEC', 'Y', 0);

-- 호스트관리 C-M서버 최초 등록
INSERT INTO ezjobs.ez_host (host_cd,data_center,agent,agent_nm,agent_id,agent_pw,file_path,access_gubun,access_port,server_gubun,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,scode_cd,server_lang,certify_gubun) VALUES
    (1,(select 'S54,'||max(data_center) from comm),(select max(data_center) from comm),(select max(data_center) from comm),'','','/','S',22,'S',current_timestamp,1,'0:0:0:0:0:0:0:1',current_timestamp,1,'0:0:0:0:0:0:0:1',NULL,'U','P')

-- SYSOUT 파일 보관 기간이 3일이므로 sysout에 대한 값 디폴트 설정
update ezjobs.ez_runinfo_history set sysout_yn ='Y', sysout = '해당 작업의 SYSOUT 조회 기간이 지났습니다.' WHERE odate < (TO_char(current_date, 'YYMMDD')::integer - 3)::text