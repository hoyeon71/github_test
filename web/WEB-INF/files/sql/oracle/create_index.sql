CREATE INDEX ez_runinfo_history_0 ON ezjobs4o.ez_runinfo_history (start_time);
CREATE INDEX ez_runinfo_history_1 ON ezjobs4o.ez_runinfo_history (end_time);
CREATE INDEX ez_runinfo_history_2 ON ezjobs4o.ez_runinfo_history (order_id, rerun_counter);

ALTER TABLE EZJOBS4O.EZ_AVG_TIME ADD CONSTRAINT EZ_AVG_TIME_PK PRIMARY KEY (JOB_NAME,DATA_CENTER) ENABLE;