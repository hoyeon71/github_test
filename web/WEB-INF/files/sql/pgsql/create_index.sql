CREATE INDEX ez_runinfo_history_0 ON ezjobs4.ez_runinfo_history USING btree (start_time);
CREATE INDEX ez_runinfo_history_1 ON ezjobs4.ez_runinfo_history USING btree (end_time);
CREATE INDEX ez_runinfo_history_2 ON ezjobs4.ez_runinfo_history USING btree (order_id, rerun_counter);

ALTER TABLE ezjobs4.ez_avg_time ADD CONSTRAINT ez_avg_time_pk PRIMARY KEY (job_name, data_center);