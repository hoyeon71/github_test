-- ezjobs_jbb.doc_master_seq definition

-- DROP SEQUENCE ezjobs_jbb.doc_master_seq;

CREATE SEQUENCE ezjobs.doc_master_seq
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 99999
    START 1
    CACHE 1
    CYCLE;