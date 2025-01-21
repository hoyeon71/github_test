--2023-06-20 기준 동기화
-- 기본 부서
INSERT INTO EZJOBS.ez_dept (dept_cd,dept_nm,del_yn,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,dept_id) VALUES 
(1,'부서','N',sysdate,1,'0:0:0:0:0:0:0:1',sysdate,1,'0:0:0:0:0:0:0:1',NULL);

-- 기본 직책
INSERT INTO EZJOBS.ez_duty (duty_cd,duty_nm,del_yn,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,duty_id) VALUES 
(1,'직책1','N',sysdate,1,'0:0:0:0:0:0:0:1',sysdate,1,'0:0:0:0:0:0:0:1',NULL);

-- 기본 유저(패스워드 server_gb이 추가됨으로써 login.jsp에서 bypass시켜줘야할수도있음)
INSERT INTO EZJOBS.ez_user (user_cd,user_id,user_nm,user_pw,user_gb,no_auth,dept_cd,duty_cd,del_yn,retire_yn,reset_yn,user_email,user_hp,user_tel,select_data_center_code,pw_fail_cnt,pw_date,before_pw,account_lock,absence_start_date,absence_end_date,absence_reason,absence_user_cd,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,default_paging,select_table_name,select_application,select_group_name,user_appr_gb)
    VALUES (1,'admin','관리자','99d0a3fbac7121e7280cfef5a8712e5bf041e7b1526bde94dd76585fa1a60d5f','99',NULL,1,1,'N','N',NULL,'example@naver.com','','','',NULL,sysdate,'6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b','N',NULL,NULL,'',0,sysdate,1,'127.0.0.1',sysdate,1,'0:0:0:0:0:0:0:1',NULL,'','','','00');
    
-- 로그인 이력 
INSERT INTO EZJOBS.EZ_LOGIN_LOG (LOGIN_CD,INS_DATE,INS_USER_CD,INS_USER_IP) VALUES(1,sysdate,1,'0:0:0:0:0:0:0:1');

-- mcode
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M51','발송구분','N',sysdate,'발송구분');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M42','작업유형구분','N',sysdate,'작업유형구분');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M9','배치작업등급','N',sysdate,'배치작업등급');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M1','C-M 한글명','N',sysdate,NULL);
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M71','SYSOUT 라인 제한','N',sysdate,'SYSOUT 조회 가능한 라인 제안');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M5','서버계정','N',sysdate,'서버계정 마스터 코드');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M72','작업 통제','N',sysdate,'작업 통제');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M6','CTM 관리','N',sysdate,'CTM 관리 마스터 코드');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M74','오류관리 조회 계정','N',sysdate,'오류관리 조회 계정');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M75','오류 시 알림 발송 여부','N',sysdate,'오류 시 알림 발송 여부');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M73','결재알림발송여부','N',sysdate,'알림발송여부');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M76','장기미사용 일수','N',sysdate,'장기미사용 일수');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M3','패스워드변경 주기','N',sysdate,'패스워드변경 주기');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M2','EzJOBs 배치 수행 서버','N',sysdate,'EzJOBs 배치 수행 서버');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M80','운영즉시결재노출','N',sysdate,'운영즉시결재노출');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M85','CM_SCHEMA','N',sysdate,'CM_SCHEMA');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M82','변수 기본값','N',sysdate,'변수 기본값');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M86','평균수행시간알림 발송 여부','N',sysdate,'평균수행시간알림 발송 여부');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M81','리소스 기본값','N',sysdate,'리소스 기본값');
INSERT INTO EZJOBS.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M91','실시간 작업 속성 변경 시 비활성화 문자열','N',sysdate,'실시간 작업 속성 변경 시 비활성화 문자열');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M92','오류처리 결재여부','N',sysdate,'오류처리 결재여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M95','사용자의 폴더 권한 사용 여부','N',sysdate,'사용자의 폴더 권한 사용 여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M96','폴더의 수행 서버 권한 사용 여부','N',sysdate,'폴더의 수행 서버 권한 사용 여부');
INSERT INTO ezjobs.ez_mcode (mcode_cd,mcode_nm,del_yn,ins_date,mcode_desc) VALUES ('M97','쿠버네티스 NFS 경로','N',sysdate,'쿠버네티스 NFS 경로');

-- scode
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M1','S10','001-TEST',1,sysdate,'1',NULL,'Y',NULL);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M1','S1229','002-TEST',1,sysdate,'2','1','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M2','S1223','LEE',1,sysdate,'LEE','LEE','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M3','S30','100',1,sysdate,NULL,NULL,'Y',NULL);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M42','S608','COMMAND',2,sysdate,'command','COMMAND','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M42','S1195','SCRIPT',1,sysdate,'job','SCRIPT','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M42','S1181','DUMMY',3,sysdate,'dummy','DUMMY','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M5','S1254','EZJOBS',1,sysdate,'EZJOBS','EZJOBS','Y',6);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M51','S1196','메신저',3,sysdate,'U','메신저','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M51','S831','메일',2,sysdate,'M','메일','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M51','S830','SMS',1,sysdate,'S','SMS','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M6','S54','계정계',1,sysdate,(select max(data_center) from comm),'계정계','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M71','S1188','8000',1,sysdate,'8000','8000라인까지 조회가능','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M72','S1194','N',1,sysdate,'N','N','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M73','S1199','Y',1,sysdate,'Y','N','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M74','S1203','user1',1,sysdate,'user1','user1','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M74','S1204','user2',2,sysdate,'user2','user2','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M75','S1206','Y',1,sysdate,'Y','Y','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M77','S1213','RUNNOW',4,sysdate,'RUNNOW','RUNNOW','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M77','S1212','FREE',3,sysdate,'FREE','FREE','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M77','S1211','KILL',2,sysdate,'KILL','KILL','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M77','S1210','HOLD',1,sysdate,'HOLD','HOLD','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M80','S1225','N',1,sysdate,'N','운영즉시결재노출','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M81','S1231','1',1,sysdate,'name1res','value1','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M82','S1233','value2',2,sysdate,'name2','value2','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M82','S1232','value1',1,sysdate,'name1','value1','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M85','S1252','ctmcore',1,sysdate,'ctmcore','(한글) datacenter (영문) db schema','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M85','S1253','ctminfo',2,sysdate,'ctminfo','(한글) datacenter (영문) db schema','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M86','S1255','Y',1,sysdate,'Y','Y','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M9','S57','3등급',3,sysdate,'3','DB의 변경작업이 없는 단순 조회 작업이나 정기배치작업의 재처리','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M9','S55','1등급',1,sysdate,'1','DB의 변경작업, 영향받는 고객이 불특정 다수인 작업','Y',0);
INSERT INTO EZJOBS.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M9','S56','2등급',2,sysdate,'2','DB의 변경작업, 특정 고객이나 당행직원이 영향을 받는 경우','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M92','S1283','Y',1,sysdate,'Y','오류처리 결재여부 설정','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M95','S1307','Y',1,current_timestamp,'Y','사용자의 폴더 권한 체크 로직 및 UI 노출 제한 제거','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M96','S1306','Y',1,current_timestamp,'Y','폴더의 수행 서버 권한 체크 로직 및 UI 노출 제한 제거','Y',0);
INSERT INTO ezjobs.ez_scode (mcode_cd,scode_cd,scode_nm,order_no,ins_date,scode_eng_nm,scode_desc,scode_use_yn,host_cd) VALUES ('M97','S1314','/NFS/','NFS 경로',current_timestamp,'Y','','Y',0);

-- SMS, MAIL 기본값, 체크유무
INSERT INTO EZJOBS.EZ_MCODE (MCODE_CD, MCODE_NM, DEL_YN, INS_DATE, MCODE_DESC) VALUES('M87', 'SMS 기본값', 'N', sysdate, '기본값, 체크유무');
INSERT INTO EZJOBS.EZ_MCODE (MCODE_CD, MCODE_NM, DEL_YN, INS_DATE, MCODE_DESC) VALUES('M88', 'MAIL 기본값', 'N', sysdate, '기본값, 체크유무');
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M88', 'S1279', 'Y', 1, sysdate, 'MAIL', '텍스트/체크박스 체크 유무', 'Y', 0);


/*알림설정관리데이터 */
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (4,'3분~10분','3','10','min','perform','10','min');
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (6,'1시간~3시간','1','3','hour','average','1','hour');
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (7,'3시간~5시간','3','5','hour','average','5','hour');
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (8,'5시간~10시간','5','10','hour','average','10','hour');
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (9,'10시간~','10',NULL,'hour','average','10','hour');
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (3,'1분~3분','1','3','min','perform','3','min');
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (2,'1분이하','0','1','min','perform','1','min');
INSERT INTO EZJOBS.EZ_ALARM_INFO (ALARM_SEQ,ALARM_STANDARD,ALARM_MIN,ALARM_MAX,ALARM_UNIT,ALARM_TIME,ALARM_OVER,ALARM_OVER_TIME) VALUES  (5,'10분~1시간','10','60','min','average','1','hour');

/*EZJOBS배치조회 */
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(1, 'EZ_ALARM', 'WEB-INF/logs/EzSmsJobServiceImpl/', '1', '처리완료', sysdate);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(2, 'EZ_USER_INFO', 'WEB-INF/logs/EzUserInfoGetJobServiceImpl/', '1', '처리완료', sysdate);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(3, 'EZ_RESOURCE', 'WEB-INF/logs/EzResourceJobServiceImpl/', '1', '처리완료', sysdate);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(4, 'EZ_HISTORY_001', 'WEB-INF/logs/EzHistoryJobServiceImpl/', '1', '처리완료', sysdate);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(6, 'EZ_LOG_DEL', 'WEB-INF/logs/EzLogDeleteJobServiceImpl/', '1', '처리완료', sysdate);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(7, 'EZ_AVG_TIME', 'WEB-INF/logs/EzAvgTimeJobServiceImpl/', '1', '처리완료', sysdate);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(8, 'EZ_RPLNJOB_001', 'WEB-INF/logs/EzRplnJobServiceImpl/', '1', '처리완료', sysdate);
INSERT INTO EZJOBS.ez_quartz_log (quartz_cd, quartz_name, trace_log_path, status_cd, status_log, ins_date) VALUES(9, 'EZ_AVG_OVERTIME', 'WEB-INF/logs/EzAvgTimeOverJobServiceImpl/', '1', '처리완료', sysdate);


/*필수결재선 */
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (1,'등록-순차','Y',1,NULL,1,'01',NULL,NULL,'N');
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (2,'등록-후결','Y',1,NULL,1,'01',NULL,NULL,'Y');
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (3,'실행-순차','Y',1,NULL,1,'05',NULL,NULL,'N');
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (4,'실행-후결','Y',1,NULL,1,'05',NULL,NULL,'Y');
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (5,'상태변경-순차','Y',1,NULL,1,'07',NULL,NULL,'N');
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (6,'상태변경-후결','Y',1,NULL,1,'07',NULL,NULL,'Y');
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (7,'오류처리-순차','Y',1,NULL,1,'10',NULL,NULL,'N');
INSERT INTO EZJOBS.EZ_ADMIN_APPROVAL_GROUP (ADMIN_LINE_GRP_CD,ADMIN_LINE_GRP_NM,USE_YN,OWNER_USER_CD,INS_DATE,INS_USER_CD,DOC_GUBUN,TOP_LEVEL_YN,SCHEDULE_YN,POST_APPROVAL_YN) VALUES (8,'오류처리-후결','Y',1,NULL,1,'10',NULL,NULL,'Y');

--코드관리 통보사유
INSERT INTO EZJOBS.EZ_MCODE (MCODE_CD, MCODE_NM, DEL_YN, INS_DATE, MCODE_DESC) VALUES('M93', '통보사유', 'N', sysdate, '통보사유');
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1285', 'Ended OK', 2, sysdate, '정상종료', 'Ended OK', 'Y', 0);
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1287', 'LATE_TIME', 4, sysdate, '종료임계시간 초과', 'LATE_TIME', 'Y', 0);
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1289', 'AVG_OVERTIME', 6, sysdate, '평균수행시간 초과', 'AVG_OVERTIME', 'Y', 0);
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1291', 'EXEC', 8, sysdate, '반영완료', 'EXEC', 'Y', 0);
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1286', 'LATE_SUB', 3, sysdate, '시작임계시간 초과', 'LATE_SUB', 'Y', 0);
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1290', 'APPROVAL', 7, sysdate, '결재통보', 'APPROVAL', 'Y', 0);
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1284', 'Ended not OK', 1, sysdate, '에러발생', 'Ended not OK', 'Y', 0);
INSERT INTO EZJOBS.EZ_SCODE (MCODE_CD, SCODE_CD, SCODE_NM, ORDER_NO, INS_DATE, SCODE_ENG_NM, SCODE_DESC, SCODE_USE_YN, HOST_CD) VALUES('M93', 'S1288', 'LATE_EXEC', 5, sysdate, '수행임계시간 초과', 'LATE_EXEC', 'Y', 0);

-- 호스트관리 C-M서버 최초 등록
INSERT INTO ezjobs.ez_host (host_cd,data_center,agent,agent_nm,agent_id,agent_pw,file_path,access_gubun,access_port,server_gubun,ins_date,ins_user_cd,ins_user_ip,udt_date,udt_user_cd,udt_user_ip,scode_cd,server_lang,certify_gubun) VALUES
    (1,(select 'S54,'||max(data_center) from comm),(select max(data_center) from comm),(select max(data_center) from comm),'','','/','S',22,'S',sysdate,1,'0:0:0:0:0:0:0:1',sysdate,1,'0:0:0:0:0:0:0:1',NULL,'U','P')

-- SYSOUT 파일 보관 기간이 3일이므로 sysout에 대한 값 디폴트 설정
update ezjobs.ez_runinfo_history set sysout_yn ='Y', sysout = '해당 작업의 SYSOUT 조회 기간이 지났습니다.' WHERE odate < (TO_char(sysdate, 'YYMMDD') - 3)