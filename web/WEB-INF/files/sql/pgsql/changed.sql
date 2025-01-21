ALTER TABLE ezjobs4.ez_host ADD certify_gubun varchar(1) DEFAULT 'P'::character varying NULL;


ALTER TABLE ezjobs4.ez_send_log ADD rerun_counter int4 NULL;
ALTER TABLE ezjobs4.ez_send_log ADD odate varchar(8) NULL;
ALTER TABLE ezjobs4.ez_send_log ADD send_description varchar(100) NULL;
ALTER TABLE ezjobs4.ez_doc_03 ADD deleted_yn varchar(2) NULL;
ALTER TABLE ezjobs4.ez_doc_03 ADD del_sms_yn varchar(2) NULL;

ALTER TABLE ezjobs4.ez_doc_07 ALTER COLUMN before_status TYPE varchar(40) USING before_status::varchar(40);


ALTER TABLE ezjobs4.ez_doc_01 ALTER COLUMN description TYPE varchar(4000) USING description::varchar(4000);
ALTER TABLE ezjobs4.ez_doc_02 ALTER COLUMN description TYPE varchar(4000) USING description::varchar(4000);
ALTER TABLE ezjobs4.ez_doc_03 ALTER COLUMN description TYPE varchar(4000) USING description::varchar(4000);
ALTER TABLE ezjobs4.ez_doc_04 ALTER COLUMN description TYPE varchar(4000) USING description::varchar(4000);
ALTER TABLE ezjobs4.ez_doc_04_original ALTER COLUMN description TYPE varchar(4000) USING description::varchar(4000);
ALTER TABLE ezjobs4.ez_doc_05 ALTER COLUMN description TYPE varchar(4000) USING description::varchar(4000);
ALTER TABLE ezjobs4.ez_doc_06_detail ALTER COLUMN description TYPE varchar(4000) USING description::varchar(4000);

-- CTM 에서 만든 작업은 APPLICATION, GROUP_NAME 항목이 없을 수 있는데,
-- 상태 변경을 진행하면 EZ_DOC_07 테이블에 NOT NULL 컬럼이어서 필수라고 오류 발생하기 때문에 NULL 로 속성 변경. (2024.12.27 강명준)
ALTER TABLE ezjobs4.ez_doc_07 ALTER COLUMN application DROP NOT NULL;
ALTER TABLE ezjobs4.ez_doc_07 ALTER COLUMN group_name DROP NOT NULL;