-- ezjobs.ez_admin_approval_group definition

-- Drop table

-- DROP TABLE ezjobs.ez_admin_approval_group;

CREATE TABLE ezjobs.ez_admin_approval_group (
                                                 admin_line_grp_cd int4 NOT NULL,
                                                 admin_line_grp_nm varchar(100) NOT NULL,
                                                 use_yn bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
                                                 owner_user_cd int4 NOT NULL,
                                                 ins_date timestamp NULL,
                                                 ins_user_cd int4 NOT NULL,
                                                 doc_gubun bpchar(2) NULL,
                                                 top_level_yn bpchar(1) NULL,
                                                 schedule_yn bpchar(1) NULL,
                                                 post_approval_yn bpchar(1) NULL
);
CREATE UNIQUE INDEX pk_ez_admin_approval_group ON ezjobs.ez_admin_approval_group USING btree (admin_line_grp_cd);


-- ezjobs.ez_admin_approval_line definition

-- Drop table

-- DROP TABLE ezjobs.ez_admin_approval_line;

CREATE TABLE ezjobs.ez_admin_approval_line (
                                                admin_line_cd int4 NOT NULL,
                                                admin_line_grp_cd int4 NOT NULL,
                                                approval_cd int4 NULL,
                                                approval_seq int4 NOT NULL,
                                                use_yn bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
                                                ins_date timestamp NULL,
                                                ins_user_cd int4 NOT NULL,
                                                approval_gb bpchar(2) NOT NULL,
                                                approval_type bpchar(2) NOT NULL,
                                                group_line_grp_cd int4 NULL
);
CREATE UNIQUE INDEX pk_ez_admin_approval_line ON ezjobs.ez_admin_approval_line USING btree (admin_line_cd);


-- ezjobs.ez_alarm definition

-- Drop table

-- DROP TABLE ezjobs.ez_alarm;

CREATE TABLE ezjobs.ez_alarm (
                                  alarm_cd int4 NOT NULL,
                                  data_center varchar(20) NULL,
                                  host_time timestamp NOT NULL,
                                  job_name varchar(64) NULL,
                                  application varchar(64) NULL,
                                  group_name varchar(64) NULL,
                                  memname varchar(64) NULL,
                                  order_id varchar(5) NULL,
                                  node_id varchar(50) NULL,
                                  run_counter int4 NULL,
                                  message varchar(50) NULL,
                                  action_yn varchar(1) NULL,
                                  action_date timestamp NULL,
                                  recur_yn varchar(1) NULL,
                                  error_gubun varchar(10) NULL,
                                  error_description varchar(4000) NULL,
                                  solution_description varchar(4000) NULL,
                                  user_cd int4 NULL,
                                  del_yn varchar(1) NULL,
                                  update_time timestamp NULL,
                                  update_user_cd int4 NULL,
                                  action_gubun varchar(20) NULL,
                                  order_table varchar(64) NULL,
                                  confirm_user_cd int4 NULL,
                                  confirm_yn varchar(40) NULL,
                                  confirm_time timestamp NULL,
                                  odate varchar(6) NULL,
                                  description varchar(4000) NULL,
                                  cyclic varchar(1) NULL
);
CREATE UNIQUE INDEX pk_ez_alarm ON ezjobs.ez_alarm USING btree (alarm_cd);


-- ezjobs.ez_alarm_info definition

-- Drop table

-- DROP TABLE ezjobs.ez_alarm_info;

CREATE TABLE ezjobs.ez_alarm_info (
                                       alarm_seq int4 NOT NULL,
                                       alarm_standard varchar(64) NULL,
                                       alarm_min varchar(10) NULL,
                                       alarm_max varchar(10) NULL,
                                       alarm_unit varchar(10) NULL,
                                       alarm_time varchar(64) NULL,
                                       alarm_over varchar(64) NULL,
                                       alarm_over_time varchar(64) NULL,
                                       CONSTRAINT pk_ez_alarm_info PRIMARY KEY (alarm_seq)
);


-- ezjobs.ez_app_grp_code definition

-- Drop table

-- DROP TABLE ezjobs.ez_app_grp_code;

CREATE TABLE ezjobs.ez_app_grp_code (
                                         grp_cd int4 NOT NULL,
                                         grp_nm varchar(100) NULL,
                                         grp_eng_nm varchar(100) NOT NULL,
                                         grp_depth int4 NOT NULL,
                                         grp_parent_cd varchar(100) NOT NULL,
                                         grp_use_yn bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
                                         grp_desc varchar(4000) NULL,
                                         grp_ins_date bpchar(14) NOT NULL,
                                         grp_ins_user_cd int4 NOT NULL,
                                         grp_udt_date varchar(14) NULL,
                                         grp_udt_user_cd int4 NULL,
                                         scode_cd varchar(10) NULL,
                                         host_cd int4 NULL,
                                         user_daily varchar(100) NULL
);
CREATE UNIQUE INDEX pk_ez_app_grp_code ON ezjobs.ez_app_grp_code USING btree (grp_cd);


-- ezjobs.ez_approval_doc definition

-- Drop table

-- DROP TABLE ezjobs.ez_approval_doc;

CREATE TABLE ezjobs.ez_approval_doc (
                                         doc_cd varchar(16) NOT NULL,
                                         seq int4 NOT NULL,
                                         user_cd int4 NULL,
                                         dept_nm varchar(200) NULL,
                                         duty_nm varchar(200) NULL,
                                         approval_cd varchar(2) NOT NULL,
                                         approval_date timestamp NULL,
                                         approval_comment varchar(4000) NULL,
                                         ins_date timestamp NOT NULL,
                                         ins_user_cd int4 NOT NULL,
                                         ins_user_ip varchar(50) NOT NULL,
                                         udt_date timestamp NULL,
                                         udt_user_cd int4 NULL,
                                         udt_user_ip varchar(50) NULL,
                                         line_gb bpchar(1) NULL,
                                         approval_gb bpchar(2) NULL,
                                         group_line_grp_cd int4 NULL,
                                         approval_type bpchar(2) NULL,
                                         grp_approval_userlist varchar(200) NULL,
                                         grp_alarm_userlist varchar(200) NULL
);
CREATE UNIQUE INDEX pk_ez_approval_doc ON ezjobs.ez_approval_doc USING btree (doc_cd, seq);


-- ezjobs.ez_avg_info definition

-- Drop table

-- DROP TABLE ezjobs.ez_avg_info;

CREATE TABLE ezjobs.ez_avg_info (
                                     data_center varchar(50) NOT NULL,
                                     order_id varchar(5) NOT NULL,
                                     job_name varchar(64) NOT NULL,
                                     order_table varchar(770) NULL,
                                     application varchar(64) NOT NULL,
                                     group_name varchar(64) NOT NULL,
                                     odate varchar(6) NOT NULL,
                                     avg_runtime varchar(6) NULL,
                                     start_time varchar(14) NULL,
                                     end_time varchar(14) NULL
);


-- ezjobs.ez_avg_time definition

-- Drop table

-- DROP TABLE ezjobs.ez_avg_time;

CREATE TABLE ezjobs.ez_avg_time (
                                     job_name varchar(64) NOT NULL,
                                     avg_run_time int8 NULL,
                                     avg_start_time int8 NULL,
                                     avg_end_time int8 NULL,
                                     ins_date timestamp NULL,
                                     udt_date timestamp NULL,
                                     data_center varchar(20) NOT NULL
);


-- ezjobs.ez_avg_time_all definition

-- Drop table

-- DROP TABLE ezjobs.ez_avg_time_all;

CREATE TABLE ezjobs.ez_avg_time_all (
                                         job_name varchar(64) NOT NULL,
                                         start_time timestamp NULL,
                                         end_time timestamp NULL,
                                         ins_date timestamp NULL,
                                         data_center varchar(20) NOT NULL,
                                         order_id varchar(5) NOT NULL,
                                         order_date varchar(8) NOT NULL,
                                         rerun_counter int4 NOT NULL
);
CREATE INDEX ez_avg_time_all_0 ON ezjobs.ez_avg_time_all USING btree (start_time);
CREATE INDEX ez_avg_time_all_1 ON ezjobs.ez_avg_time_all USING btree (end_time);
CREATE INDEX ez_avg_time_all_job_name_idx ON ezjobs.ez_avg_time_all USING btree (job_name);


-- ezjobs.ez_board definition

-- Drop table

-- DROP TABLE ezjobs.ez_board;

CREATE TABLE ezjobs.ez_board (
                                  board_cd int4 NOT NULL,
                                  title varchar(200) NOT NULL,
                                  "content" text NULL,
                                  status bpchar(2) NOT NULL DEFAULT '01'::bpchar,
                                  del_yn bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
                                  file_nm varchar(200) NULL,
                                  file_path varchar(500) NULL,
                                  noti_yn bpchar(1) NOT NULL DEFAULT 'N'::bpchar,
                                  app_user_cd int4 NULL,
                                  ins_user_cd int4 NOT NULL,
                                  ins_date timestamp NOT NULL,
                                  board_gb bpchar(2) NOT NULL,
                                  seq int4 NULL,
                                  popup_yn bpchar(1) NULL,
                                  popup_s_date bpchar(8) NULL,
                                  popup_e_date bpchar(8) NULL
);
CREATE UNIQUE INDEX pk_ez_board ON ezjobs.ez_board USING btree (board_cd);


-- ezjobs.ez_cmr_rpln definition

-- Drop table

-- DROP TABLE ezjobs.ez_cmr_rpln;

CREATE TABLE ezjobs.ez_cmr_rpln (
                                     data_center varchar(50) NOT NULL,
                                     job_name varchar(64) NOT NULL,
                                     odate varchar(8) NOT NULL
);


-- ezjobs.ez_cond_history definition

-- Drop table

-- DROP TABLE ezjobs.ez_cond_history;

CREATE TABLE ezjobs.ez_cond_history (
                                         gubun varchar(20) NULL,
                                         condition_name varchar(4000) NULL,
                                         odate varchar(6) NULL,
                                         ins_user_cd int4 NOT NULL,
                                         ins_date timestamp NULL
);


-- ezjobs.ez_dept definition

-- Drop table

-- DROP TABLE ezjobs.ez_dept;

CREATE TABLE ezjobs.ez_dept (
                                 dept_cd int4 NOT NULL,
                                 dept_nm varchar(200) NOT NULL,
                                 del_yn varchar(1) NOT NULL DEFAULT 'N'::character varying,
                                 ins_date timestamp NOT NULL,
                                 ins_user_cd int4 NOT NULL,
                                 ins_user_ip varchar(50) NOT NULL,
                                 udt_date timestamp NULL,
                                 udt_user_cd int4 NULL,
                                 udt_user_ip varchar(50) NULL,
                                 dept_id varchar(200) NULL
);
CREATE UNIQUE INDEX pk_ez_dept ON ezjobs.ez_dept USING btree (dept_cd);


-- ezjobs.ez_dept_relay definition

-- Drop table

-- DROP TABLE ezjobs.ez_dept_relay;

CREATE TABLE ezjobs.ez_dept_relay (
                                       dept_cd varchar(100) NULL,
                                       dept_nm varchar(100) NULL,
                                       ins_date timestamp NOT NULL
);


-- ezjobs.ez_doc_01 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_01;

CREATE TABLE ezjobs.ez_doc_01 (
                                   doc_cd varchar(16) NOT NULL,
                                   title varchar(2000) NULL,
                                   "content" varchar(4000) NULL,
                                   table_id int4 NULL,
                                   job_id int4 NULL,
                                   data_center varchar(50) NULL,
                                   table_name varchar(770) NULL,
                                   application varchar(50) NULL,
                                   group_name varchar(50) NULL,
                                   mem_name varchar(64) NULL,
                                   job_name varchar(64) NULL,
                                   description varchar(200) NULL,
                                   author varchar(50) NULL,
                                   "owner" varchar(50) NULL,
                                   priority varchar(2) NULL,
                                   critical varchar(1) NULL,
                                   task_type varchar(21) NULL,
                                   cyclic varchar(1) NULL,
                                   node_id varchar(50) NULL,
                                   rerun_interval varchar(6) NULL,
                                   rerun_interval_time varchar(1) NULL,
                                   mem_lib varchar(255) NULL,
                                   command varchar(512) NULL,
                                   confirm_flag varchar(1) NULL,
                                   days_cal varchar(50) NULL,
                                   weeks_cal varchar(50) NULL,
                                   retro varchar(1) NULL,
                                   max_wait int4 NULL,
                                   rerun_max int4 NULL,
                                   time_from varchar(4) NULL,
                                   time_until varchar(4) NULL,
                                   month_days varchar(160) NULL,
                                   week_days varchar(50) NULL,
                                   month_1 varchar(1) NULL,
                                   month_2 varchar(1) NULL,
                                   month_3 varchar(1) NULL,
                                   month_4 varchar(1) NULL,
                                   month_5 varchar(1) NULL,
                                   month_6 varchar(1) NULL,
                                   month_7 varchar(1) NULL,
                                   month_8 varchar(1) NULL,
                                   month_9 varchar(1) NULL,
                                   month_10 varchar(1) NULL,
                                   month_11 varchar(1) NULL,
                                   month_12 varchar(1) NULL,
                                   count_cyclic_from varchar(10) NULL,
                                   time_zone varchar(9) NULL,
                                   multiagent varchar(1) NULL,
                                   user_daily varchar(20) NULL,
                                   schedule_and_or varchar(1) NULL,
                                   in_conditions_opt varchar(10) NULL,
                                   t_general_date varchar(4000) NULL,
                                   t_conditions_in varchar(4000) NULL,
                                   t_conditions_out varchar(4000) NULL,
                                   t_resources_q varchar(4000) NULL,
                                   t_resources_c varchar(4000) NULL,
                                   t_set varchar(4000) NULL,
                                   t_steps varchar(4000) NULL,
                                   t_postproc varchar(4000) NULL,
                                   t_sfile varchar(4000) NULL,
                                   conf_cal varchar(30) NULL,
                                   shift varchar(10) NULL,
                                   shift_num varchar(3) NULL,
                                   t_tag_name varchar(4000) NULL,
                                   interval_sequence varchar(4000) NULL,
                                   specific_times varchar(4000) NULL,
                                   tolerance int4 NULL,
                                   cyclic_type varchar(1) NULL,
                                   active_from varchar(8) NULL,
                                   active_till varchar(8) NULL,
                                   apply_date varchar(8) NULL,
                                   apply_check varchar(1) NULL,
                                   sr_code bpchar(1) NULL,
                                   dates_str varchar(255) NULL,
                                   monitor_time varchar(10) NULL,
                                   monitor_interval varchar(10) NULL,
                                   filesize_comparison varchar(10) NULL,
                                   num_of_iterations varchar(10) NULL,
                                   stop_time varchar(10) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_01 ON ezjobs.ez_doc_01 USING btree (doc_cd);


-- ezjobs.ez_doc_02 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_02;

CREATE TABLE ezjobs.ez_doc_02 (
                                   doc_cd varchar(16) NOT NULL,
                                   title varchar(2000) NULL,
                                   "content" varchar(4000) NULL,
                                   table_id int4 NULL,
                                   job_id int4 NULL,
                                   data_center varchar(50) NULL,
                                   table_name varchar(770) NULL,
                                   application varchar(50) NULL,
                                   group_name varchar(50) NULL,
                                   mem_name varchar(64) NULL,
                                   job_name varchar(64) NULL,
                                   description varchar(200) NULL,
                                   author varchar(50) NULL,
                                   "owner" varchar(50) NULL,
                                   priority varchar(2) NULL,
                                   critical varchar(1) NULL,
                                   task_type varchar(21) NULL,
                                   cyclic varchar(1) NULL,
                                   node_id varchar(50) NULL,
                                   rerun_interval varchar(6) NULL,
                                   rerun_interval_time varchar(1) NULL,
                                   mem_lib varchar(255) NULL,
                                   command varchar(512) NULL,
                                   confirm_flag varchar(1) NULL,
                                   days_cal varchar(50) NULL,
                                   weeks_cal varchar(50) NULL,
                                   retro varchar(1) NULL,
                                   max_wait int4 NULL,
                                   rerun_max int4 NULL,
                                   time_from varchar(4) NULL,
                                   time_until varchar(4) NULL,
                                   month_days varchar(160) NULL,
                                   week_days varchar(50) NULL,
                                   month_1 varchar(1) NULL,
                                   month_2 varchar(1) NULL,
                                   month_3 varchar(1) NULL,
                                   month_4 varchar(1) NULL,
                                   month_5 varchar(1) NULL,
                                   month_6 varchar(1) NULL,
                                   month_7 varchar(1) NULL,
                                   month_8 varchar(1) NULL,
                                   month_9 varchar(1) NULL,
                                   month_10 varchar(1) NULL,
                                   month_11 varchar(1) NULL,
                                   month_12 varchar(1) NULL,
                                   count_cyclic_from varchar(10) NULL,
                                   time_zone varchar(9) NULL,
                                   multiagent varchar(1) NULL,
                                   user_daily varchar(20) NULL,
                                   schedule_and_or varchar(1) NULL,
                                   in_conditions_opt varchar(10) NULL,
                                   t_general_date varchar(4000) NULL,
                                   t_conditions_in varchar(4000) NULL,
                                   t_conditions_out varchar(4000) NULL,
                                   t_resources_q varchar(4000) NULL,
                                   t_resources_c varchar(4000) NULL,
                                   t_set varchar(4000) NULL,
                                   t_steps varchar(4000) NULL,
                                   t_postproc varchar(4000) NULL,
                                   t_sfile varchar(4000) NULL,
                                   conf_cal varchar(30) NULL,
                                   shift varchar(10) NULL,
                                   shift_num varchar(3) NULL,
                                   t_tag_name varchar(4000) NULL,
                                   interval_sequence varchar(4000) NULL,
                                   specific_times varchar(4000) NULL,
                                   tolerance int4 NULL,
                                   cyclic_type varchar(1) NULL,
                                   active_from varchar(8) NULL,
                                   active_till varchar(8) NULL,
                                   apply_date varchar(8) NULL,
                                   apply_check varchar(1) NULL,
                                   sr_code bpchar(1) NULL,
                                   dates_str varchar(255) NULL,
                                   monitor_time varchar(10) NULL,
                                   monitor_interval varchar(10) NULL,
                                   filesize_comparison varchar(10) NULL,
                                   num_of_iterations varchar(10) NULL,
                                   stop_time varchar(10) NULL,
                                   order_id varchar(5) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_02 ON ezjobs.ez_doc_02 USING btree (doc_cd);


-- ezjobs.ez_doc_03 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_03;

CREATE TABLE ezjobs.ez_doc_03 (
                                   doc_cd varchar(16) NOT NULL,
                                   title varchar(2000) NULL,
                                   "content" varchar(4000) NULL,
                                   table_id int4 NULL,
                                   job_id int4 NULL,
                                   data_center varchar(50) NULL,
                                   table_name varchar(770) NULL,
                                   application varchar(50) NULL,
                                   group_name varchar(50) NULL,
                                   mem_name varchar(64) NULL,
                                   job_name varchar(64) NULL,
                                   task_type varchar(21) NULL,
                                   user_daily varchar(20) NULL,
                                   description varchar(200) NULL,
                                   "owner" varchar(50) NULL,
                                   author varchar(50) NULL,
                                   mem_lib varchar(255) NULL,
                                   command varchar(512) NULL,
                                   in_condition varchar(4000) NULL,
                                   out_condition varchar(4000) NULL,
                                   apply_date varchar(8) NULL,
                                   apply_check varchar(1) NULL,
                                   node_id varchar(50) NULL,
                                   deleted_yn varchar(1) NULL,
                                   del_sms_yn varchar(1) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_03 ON ezjobs.ez_doc_03 USING btree (doc_cd);


-- ezjobs.ez_doc_04 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_04;

CREATE TABLE ezjobs.ez_doc_04 (
                                   doc_cd varchar(16) NOT NULL,
                                   title varchar(2000) NULL,
                                   "content" varchar(4000) NULL,
                                   table_id int4 NULL,
                                   job_id int4 NULL,
                                   data_center varchar(50) NULL,
                                   table_name varchar(770) NULL,
                                   application varchar(50) NULL,
                                   group_name varchar(50) NULL,
                                   mem_name varchar(64) NULL,
                                   job_name varchar(64) NULL,
                                   description varchar(200) NULL,
                                   author varchar(50) NULL,
                                   "owner" varchar(50) NULL,
                                   priority varchar(2) NULL,
                                   critical varchar(1) NULL,
                                   task_type varchar(21) NULL,
                                   cyclic varchar(1) NULL,
                                   node_id varchar(50) NULL,
                                   rerun_interval varchar(6) NULL,
                                   rerun_interval_time varchar(1) NULL,
                                   mem_lib varchar(255) NULL,
                                   command varchar(512) NULL,
                                   confirm_flag varchar(1) NULL,
                                   days_cal varchar(50) NULL,
                                   weeks_cal varchar(50) NULL,
                                   retro varchar(1) NULL,
                                   max_wait int4 NULL,
                                   rerun_max int4 NULL,
                                   time_from varchar(4) NULL,
                                   time_until varchar(4) NULL,
                                   month_days varchar(160) NULL,
                                   week_days varchar(50) NULL,
                                   month_1 varchar(1) NULL,
                                   month_2 varchar(1) NULL,
                                   month_3 varchar(1) NULL,
                                   month_4 varchar(1) NULL,
                                   month_5 varchar(1) NULL,
                                   month_6 varchar(1) NULL,
                                   month_7 varchar(1) NULL,
                                   month_8 varchar(1) NULL,
                                   month_9 varchar(1) NULL,
                                   month_10 varchar(1) NULL,
                                   month_11 varchar(1) NULL,
                                   month_12 varchar(1) NULL,
                                   count_cyclic_from varchar(10) NULL,
                                   time_zone varchar(9) NULL,
                                   multiagent varchar(1) NULL,
                                   user_daily varchar(20) NULL,
                                   schedule_and_or varchar(1) NULL,
                                   in_conditions_opt varchar(10) NULL,
                                   t_general_date varchar(4000) NULL,
                                   t_conditions_in varchar(4000) NULL,
                                   t_conditions_out varchar(4000) NULL,
                                   t_resources_q varchar(4000) NULL,
                                   t_resources_c varchar(4000) NULL,
                                   t_set varchar(4000) NULL,
                                   t_steps varchar(4000) NULL,
                                   t_postproc varchar(4000) NULL,
                                   before_table_name varchar(770) NULL,
                                   before_application varchar(50) NULL,
                                   before_group_name varchar(50) NULL,
                                   t_tag_name varchar(4000) NULL,
                                   interval_sequence varchar(4000) NULL,
                                   specific_times varchar(4000) NULL,
                                   tolerance int4 NULL,
                                   cyclic_type varchar(1) NULL,
                                   active_from varchar(8) NULL,
                                   active_till varchar(8) NULL,
                                   apply_date varchar(8) NULL,
                                   apply_check varchar(1) NULL,
                                   sr_code bpchar(1) NULL,
                                   dates_str varchar(255) NULL,
                                   monitor_time varchar(10) NULL,
                                   monitor_interval varchar(10) NULL,
                                   conf_cal varchar(30) NULL,
                                   shift varchar(10) NULL,
                                   shift_num varchar(3) NULL,
                                   filesize_comparison varchar(10) NULL,
                                   num_of_iterations varchar(10) NULL,
                                   stop_time varchar(10) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_04 ON ezjobs.ez_doc_04 USING btree (doc_cd);


-- ezjobs.ez_doc_04_original definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_04_original;

CREATE TABLE ezjobs.ez_doc_04_original (
                                            doc_cd varchar(16) NOT NULL,
                                            title varchar(2000) NULL,
                                            "content" varchar(4000) NULL,
                                            table_id int4 NULL,
                                            job_id int4 NULL,
                                            data_center varchar(50) NULL,
                                            table_name varchar(770) NULL,
                                            application varchar(50) NULL,
                                            group_name varchar(50) NULL,
                                            mem_name varchar(64) NULL,
                                            job_name varchar(64) NULL,
                                            description varchar(200) NULL,
                                            author varchar(50) NULL,
                                            "owner" varchar(50) NULL,
                                            priority varchar(2) NULL,
                                            critical varchar(1) NULL,
                                            task_type varchar(21) NULL,
                                            cyclic varchar(1) NULL,
                                            node_id varchar(50) NULL,
                                            rerun_interval varchar(6) NULL,
                                            rerun_interval_time varchar(1) NULL,
                                            mem_lib varchar(255) NULL,
                                            command varchar(512) NULL,
                                            confirm_flag varchar(1) NULL,
                                            days_cal varchar(50) NULL,
                                            weeks_cal varchar(50) NULL,
                                            retro varchar(1) NULL,
                                            max_wait int4 NULL,
                                            rerun_max int4 NULL,
                                            time_from varchar(4) NULL,
                                            time_until varchar(4) NULL,
                                            month_days varchar(160) NULL,
                                            week_days varchar(50) NULL,
                                            month_1 varchar(1) NULL,
                                            month_2 varchar(1) NULL,
                                            month_3 varchar(1) NULL,
                                            month_4 varchar(1) NULL,
                                            month_5 varchar(1) NULL,
                                            month_6 varchar(1) NULL,
                                            month_7 varchar(1) NULL,
                                            month_8 varchar(1) NULL,
                                            month_9 varchar(1) NULL,
                                            month_10 varchar(1) NULL,
                                            month_11 varchar(1) NULL,
                                            month_12 varchar(1) NULL,
                                            count_cyclic_from varchar(10) NULL,
                                            time_zone varchar(9) NULL,
                                            multiagent varchar(1) NULL,
                                            user_daily varchar(20) NULL,
                                            schedule_and_or varchar(1) NULL,
                                            in_conditions_opt varchar(10) NULL,
                                            t_general_date varchar(4000) NULL,
                                            t_conditions_in varchar(4000) NULL,
                                            t_conditions_out varchar(4000) NULL,
                                            t_resources_q varchar(4000) NULL,
                                            t_resources_c varchar(4000) NULL,
                                            t_set varchar(4000) NULL,
                                            t_steps varchar(4000) NULL,
                                            t_postproc varchar(4000) NULL,
                                            before_table_name varchar(770) NULL,
                                            before_application varchar(50) NULL,
                                            before_group_name varchar(50) NULL,
                                            t_tag_name varchar(4000) NULL,
                                            interval_sequence varchar(4000) NULL,
                                            specific_times varchar(4000) NULL,
                                            tolerance int4 NULL,
                                            cyclic_type varchar(1) NULL,
                                            active_from varchar(8) NULL,
                                            active_till varchar(8) NULL,
                                            apply_date varchar(8) NULL,
                                            apply_check varchar(1) NULL,
                                            sr_code bpchar(1) NULL,
                                            dates_str varchar(255) NULL,
                                            monitor_time varchar(10) NULL,
                                            monitor_interval varchar(10) NULL,
                                            conf_cal varchar(30) NULL,
                                            shift varchar(10) NULL,
                                            shift_num varchar(3) NULL,
                                            filesize_comparison varchar(10) NULL,
                                            num_of_iterations varchar(10) NULL,
                                            stop_time varchar(10) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_04_original ON ezjobs.ez_doc_04_original USING btree (doc_cd);


-- ezjobs.ez_doc_05 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_05;

CREATE TABLE ezjobs.ez_doc_05 (
                                   doc_cd varchar(16) NOT NULL,
                                   doc_group_id varchar(10) NULL,
                                   title varchar(2000) NOT NULL,
                                   "content" varchar(4000) NULL,
                                   table_id int4 NULL,
                                   job_id int4 NULL,
                                   data_center varchar(50) NULL,
                                   table_name varchar(770) NULL,
                                   mem_name varchar(50) NULL,
                                   job_name varchar(64) NULL,
                                   hold_yn varchar(1) NULL,
                                   force_yn varchar(1) NULL,
                                   order_date varchar(8) NULL,
                                   from_time varchar(4) NULL,
                                   cmd_line2 varchar(8) NULL,
                                   t_set varchar(4000) NULL,
                                   apply_check varchar(1) NULL,
                                   wait_for_odate_yn bpchar(1) NULL,
                                   order_id varchar(5) NULL,
                                   status varchar(16) NULL,
                                   application varchar(50) NULL,
                                   group_name varchar(50) NULL,
                                   description varchar(200) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_05 ON ezjobs.ez_doc_05 USING btree (doc_cd);


-- ezjobs.ez_doc_06 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_06;

CREATE TABLE ezjobs.ez_doc_06 (
                                   doc_cd varchar(16) NOT NULL,
                                   title varchar(2000) NULL,
                                   "content" varchar(4000) NULL,
                                   data_center varchar(50) NULL,
                                   table_name varchar(770) NULL,
                                   file_nm varchar(255) NULL,
                                   apply_date varchar(8) NULL,
                                   apply_check varchar(1) NULL,
                                   act_gb varchar(1) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_06 ON ezjobs.ez_doc_06 USING btree (doc_cd);


-- ezjobs.ez_doc_06_detail definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_06_detail;

CREATE TABLE ezjobs.ez_doc_06_detail (
                                          doc_cd varchar(16) NOT NULL,
                                          seq int4 NOT NULL,
                                          application varchar(50) NULL,
                                          group_name varchar(50) NULL,
                                          mem_name varchar(64) NULL,
                                          job_name varchar(64) NULL,
                                          description varchar(200) NULL,
                                          author varchar(50) NULL,
                                          "owner" varchar(50) NULL,
                                          priority varchar(2) NULL,
                                          critical varchar(1) NULL,
                                          task_type varchar(21) NULL,
                                          cyclic varchar(1) NULL,
                                          node_id varchar(50) NULL,
                                          rerun_interval varchar(6) NULL,
                                          rerun_interval_time varchar(1) NULL,
                                          mem_lib varchar(255) NULL,
                                          command varchar(512) NULL,
                                          confirm_flag varchar(1) NULL,
                                          days_cal varchar(50) NULL,
                                          weeks_cal varchar(50) NULL,
                                          retro varchar(1) NULL,
                                          max_wait int4 NULL,
                                          rerun_max int4 NULL,
                                          time_from varchar(4) NULL,
                                          time_until varchar(4) NULL,
                                          month_days varchar(160) NULL,
                                          week_days varchar(50) NULL,
                                          month_1 varchar(1) NULL,
                                          month_2 varchar(1) NULL,
                                          month_3 varchar(1) NULL,
                                          month_4 varchar(1) NULL,
                                          month_5 varchar(1) NULL,
                                          month_6 varchar(1) NULL,
                                          month_7 varchar(1) NULL,
                                          month_8 varchar(1) NULL,
                                          month_9 varchar(1) NULL,
                                          month_10 varchar(1) NULL,
                                          month_11 varchar(1) NULL,
                                          month_12 varchar(1) NULL,
                                          count_cyclic_from varchar(10) NULL,
                                          time_zone varchar(9) NULL,
                                          multiagent varchar(1) NULL,
                                          user_daily varchar(20) NULL,
                                          schedule_and_or varchar(1) NULL,
                                          in_conditions_opt varchar(10) NULL,
                                          t_general_date varchar(4000) NULL,
                                          t_conditions_in varchar(4000) NULL,
                                          t_conditions_out varchar(4000) NULL,
                                          t_resources_q varchar(4000) NULL,
                                          t_resources_c varchar(4000) NULL,
                                          t_set varchar(4000) NULL,
                                          t_steps varchar(4000) NULL,
                                          t_postproc varchar(4000) NULL,
                                          t_sfile varchar(4000) NULL,
                                          conf_cal varchar(30) NULL,
                                          shift varchar(10) NULL,
                                          shift_num varchar(3) NULL,
                                          t_tag_name varchar(4000) NULL,
                                          interval_sequence varchar(4000) NULL,
                                          specific_times varchar(4000) NULL,
                                          tolerance int4 NULL,
                                          cyclic_type varchar(1) NULL,
                                          active_from varchar(8) NULL,
                                          active_till varchar(8) NULL,
                                          dates_str varchar(255) NULL,
                                          apply_date varchar(14) NULL,
                                          apply_check varchar(1) NULL,
                                          r_msg varchar(1000) NULL,
                                          monitor_time varchar(10) NULL,
                                          monitor_interval varchar(10) NULL,
                                          filesize_comparison varchar(10) NULL,
                                          num_of_iterations varchar(10) NULL,
                                          stop_time varchar(10) NULL,
                                          ind_cyclic varchar(1) NULL,
                                          table_name varchar(770) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_06_detail ON ezjobs.ez_doc_06_detail USING btree (doc_cd, seq);


-- ezjobs.ez_doc_07 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_07;

CREATE TABLE ezjobs.ez_doc_07 (
                                   doc_cd varchar(16) NOT NULL,
                                   title varchar(2000) NOT NULL,
                                   "content" varchar(4000) NULL,
                                   order_id varchar(5) NOT NULL,
                                   odate varchar(6) NULL,
                                   data_center varchar(50) NOT NULL,
                                   table_name varchar(770) NOT NULL,
                                   application varchar(50) NOT NULL,
                                   group_name varchar(50) NOT NULL,
                                   job_name varchar(64) NOT NULL,
                                   before_status varchar(40) NOT NULL,
                                   after_status varchar(15) NOT NULL,
                                   description varchar(4000) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_07 ON ezjobs.ez_doc_07 USING btree (doc_cd);


-- ezjobs.ez_doc_08 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_08;

CREATE TABLE ezjobs.ez_doc_08 (
                                   doc_cd varchar(16) NOT NULL,
                                   title varchar(200) NOT NULL,
                                   "content" varchar(4000) NULL,
                                   data_center varchar(50) NOT NULL,
                                   table_name varchar(770) NOT NULL,
                                   application varchar(50) NOT NULL,
                                   group_name varchar(50) NOT NULL,
                                   job_name varchar(64) NOT NULL,
                                   description varchar(4000) NULL,
                                   order_date varchar(8) NOT NULL,
                                   from_time varchar(5) NOT NULL,
                                   after_status varchar(15) NOT NULL,
                                   order_id varchar(10) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_08 ON ezjobs.ez_doc_08 USING btree (doc_cd);


-- ezjobs.ez_doc_09 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_09;

CREATE TABLE ezjobs.ez_doc_09 (
                                   doc_cd varchar(16) NOT NULL,
                                   doc_gb varchar(2) NULL,
                                   job_name varchar(64) NULL,
                                   title varchar(200) NULL,
                                   data_center varchar(50) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_09 ON ezjobs.ez_doc_09 USING btree (doc_cd);


-- ezjobs.ez_doc_10 definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_10;

CREATE TABLE ezjobs.ez_doc_10 (
                                   doc_cd varchar(16) NOT NULL,
                                   alarm_cd int4 NOT NULL,
                                   data_center varchar(50) NULL,
                                   job_name varchar(64) NULL,
                                   error_description varchar(300) NULL,
                                   main_doc_cd varchar(16) NULL,
                                   user_cd int4 NULL
);
CREATE UNIQUE INDEX pk_ez_doc_10 ON ezjobs.ez_doc_10 USING btree (doc_cd, alarm_cd);


-- ezjobs.ez_doc_group definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_group;

CREATE TABLE ezjobs.ez_doc_group (
                                      doc_group_id varchar(10) NOT NULL,
                                      jobgroup_id varchar(5) NOT NULL,
                                      doc_group_name varchar(100) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_group ON ezjobs.ez_doc_group USING btree (doc_group_id);


-- ezjobs.ez_doc_master definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_master;

CREATE TABLE ezjobs.ez_doc_master (
                                       doc_cd varchar(16) NOT NULL,
                                       doc_gb varchar(2) NOT NULL,
                                       user_cd int4 NOT NULL,
                                       dept_nm varchar(200) NULL,
                                       duty_nm varchar(200) NULL,
                                       state_cd varchar(2) NOT NULL,
                                       draft_date timestamp NULL,
                                       cur_approval_seq int4 NULL,
                                       del_yn varchar(1) NOT NULL DEFAULT 'N'::character varying,
                                       ins_date timestamp NOT NULL,
                                       ins_user_cd int4 NOT NULL,
                                       ins_user_ip varchar(50) NOT NULL,
                                       udt_date timestamp NULL,
                                       udt_user_cd int4 NULL,
                                       udt_user_ip varchar(50) NULL,
                                       jobgroup_id varchar(5) NULL,
                                       doc_group_id varchar(10) NULL,
                                       apply_cd varchar(2) NULL,
                                       apply_date timestamp NULL,
                                       cancel_comment varchar(1000) NULL,
                                       fail_comment varchar(4000) NULL,
                                       main_doc_cd varchar(16) NULL,
                                       post_approval_yn bpchar(1) NULL,
                                       admin_approval_yn varchar(1) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_master ON ezjobs.ez_doc_master USING btree (doc_cd);


-- ezjobs.ez_doc_setvar definition

-- Drop table

-- DROP TABLE ezjobs.ez_doc_setvar;

CREATE TABLE ezjobs.ez_doc_setvar (
                                       doc_cd varchar(16) NOT NULL,
                                       seq int4 NOT NULL,
                                       var_name varchar(128) NOT NULL,
                                       var_value varchar(4000) NULL
);
CREATE UNIQUE INDEX pk_ez_doc_setvar ON ezjobs.ez_doc_setvar USING btree (doc_cd, seq);


-- ezjobs.ez_duty definition

-- Drop table

-- DROP TABLE ezjobs.ez_duty;

CREATE TABLE ezjobs.ez_duty (
                                 duty_cd int4 NOT NULL,
                                 duty_nm varchar(200) NOT NULL,
                                 del_yn varchar(1) NOT NULL DEFAULT 'N'::character varying,
                                 ins_date timestamp NOT NULL,
                                 ins_user_cd int4 NOT NULL,
                                 ins_user_ip varchar(50) NOT NULL,
                                 udt_date timestamp NULL,
                                 udt_user_cd int4 NULL,
                                 udt_user_ip varchar(50) NULL,
                                 duty_id varchar(200) NULL
);
CREATE UNIQUE INDEX pk_ez_duty ON ezjobs.ez_duty USING btree (duty_cd);


-- ezjobs.ez_duty_relay definition

-- Drop table

-- DROP TABLE ezjobs.ez_duty_relay;

CREATE TABLE ezjobs.ez_duty_relay (
                                       duty_cd varchar(100) NULL,
                                       duty_nm varchar(100) NULL,
                                       ins_date timestamp NOT NULL
);


-- ezjobs.ez_group_approval_group definition

-- Drop table

-- DROP TABLE ezjobs.ez_group_approval_group;

CREATE TABLE ezjobs.ez_group_approval_group (
                                                 group_line_grp_cd int4 NOT NULL,
                                                 group_line_grp_nm varchar(100) NOT NULL,
                                                 use_yn bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
                                                 owner_user_cd int4 NOT NULL,
                                                 ins_date timestamp NOT NULL,
                                                 ins_user_cd int4 NOT NULL
);
CREATE UNIQUE INDEX ez_group_approval_group_pk ON ezjobs.ez_group_approval_group USING btree (group_line_grp_cd);


-- ezjobs.ez_group_approval_line definition

-- Drop table

-- DROP TABLE ezjobs.ez_group_approval_line;

CREATE TABLE ezjobs.ez_group_approval_line (
                                                group_line_cd int4 NOT NULL,
                                                group_line_grp_cd int4 NOT NULL,
                                                approval_cd int4 NOT NULL,
                                                approval_seq int4 NOT NULL,
                                                use_yn bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
                                                ins_date timestamp NOT NULL,
                                                ins_user_cd int4 NOT NULL
);
CREATE UNIQUE INDEX ez_group_approval_line_pk ON ezjobs.ez_group_approval_line USING btree (group_line_cd);


-- ezjobs.ez_grp_host definition

-- Drop table

-- DROP TABLE ezjobs.ez_grp_host;

CREATE TABLE ezjobs.ez_grp_host (
                                     grp_cd int4 NOT NULL,
                                     host_cd int4 NOT NULL,
                                     ins_date bpchar(14) NOT NULL,
                                     ins_user_cd int4 NOT NULL
);
CREATE UNIQUE INDEX pk_ez_grp_host ON ezjobs.ez_grp_host USING btree (grp_cd, host_cd);


-- ezjobs.ez_history_001 definition

-- Drop table

-- DROP TABLE ezjobs.ez_history_001;

CREATE TABLE ezjobs.ez_history_001 (
                                        order_id varchar(5) NOT NULL,
                                        application varchar(64) NULL,
                                        group_name varchar(64) NULL,
                                        memname varchar(64) NULL,
                                        rba varchar(6) NULL,
                                        grp_rba varchar(6) NULL,
                                        mem_lib varchar(255) NULL,
                                        "owner" varchar(30) NULL,
                                        task_type varchar(21) NULL,
                                        job_name varchar(64) NULL,
                                        job_id varchar(17) NULL,
                                        odate varchar(6) NULL,
                                        max_wait int2 NULL,
                                        description varchar(4000) NULL,
                                        from_pgmstep varchar(8) NULL,
                                        from_procstep varchar(8) NULL,
                                        to_pgmstep varchar(8) NULL,
                                        to_procstep varchar(8) NULL,
                                        confirm_flag varchar(1) NOT NULL,
                                        prevent_nct2 varchar(1) NULL,
                                        doc_mem varchar(64) NULL,
                                        doc_lib varchar(255) NULL,
                                        from_time varchar(4) NULL,
                                        to_time varchar(4) NULL,
                                        "interval" varchar(6) NULL,
                                        rerun_mem varchar(8) NULL,
                                        next_time varchar(14) NULL,
                                        priority varchar(2) NULL,
                                        cpu_id varchar(50) NULL,
                                        nje varchar(1) NULL,
                                        search_count int4 NULL,
                                        max_rerun int2 NULL,
                                        auto_archive varchar(1) NOT NULL,
                                        sysdb varchar(1) NOT NULL,
                                        max_days int2 NULL,
                                        max_runs int2 NULL,
                                        avg_runtime varchar(6) NULL,
                                        std_dev varchar(6) NULL,
                                        sysopt varchar(16) NULL,
                                        from_class varchar(1) NULL,
                                        parm varchar(255) NULL,
                                        state_digits varchar(15) NULL,
                                        status varchar(16) NOT NULL,
                                        state varchar(40) NULL,
                                        delete_flag varchar(1) NOT NULL,
                                        seq_cnt int4 NULL,
                                        start_time varchar(14) NULL,
                                        end_time varchar(14) NULL,
                                        rerun_counter int4 NULL,
                                        nr_records int4 NULL,
                                        over_lib varchar(255) NULL,
                                        cmd_line varchar(512) NULL,
                                        critical varchar(1) NULL,
                                        cyclic varchar(1) NULL,
                                        due_in varchar(4) NULL,
                                        due_out varchar(4) NULL,
                                        elapsed int4 NULL,
                                        nodegroup varchar(50) NULL,
                                        nje_node varchar(8) NULL,
                                        task_class varchar(3) NULL,
                                        ind_cyclic varchar(1) NULL,
                                        reten_days varchar(3) NULL,
                                        reten_gen varchar(2) NULL,
                                        order_table varchar(770) NULL,
                                        order_lib varchar(44) NULL,
                                        sticky_ind varchar(1) NULL,
                                        seq_cnt_added int4 NULL,
                                        short_ffu varchar(12) NULL,
                                        dsect_ffu varchar(100) NULL,
                                        isn_ int4 NOT NULL,
                                        time_ref varchar(1) NULL,
                                        time_zone varchar(9) NULL,
                                        appl_type varchar(10) NULL,
                                        appl_ver varchar(10) NULL,
                                        appl_form varchar(30) NULL,
                                        cm_ver varchar(10) NULL,
                                        state_mask varchar(9) NULL,
                                        multy_agent varchar(1) NULL,
                                        schedule_env varchar(16) NULL,
                                        sys_affinity varchar(5) NULL,
                                        req_nje_node varchar(8) NULL,
                                        adjust_cond varchar(1) NULL,
                                        in_service varchar(255) NULL,
                                        stat_cal varchar(30) NULL,
                                        stat_period varchar(1) NULL,
                                        instream_jcl text NULL,
                                        use_instream_jcl varchar(1) NULL,
                                        lpar varchar(8) NULL,
                                        due_out_daysoffset varchar(3) NULL,
                                        from_daysoffset varchar(3) NULL,
                                        to_daysoffset varchar(3) NULL,
                                        order_time varchar(14) NULL,
                                        avg_start_time varchar(6) NULL,
                                        cpu_time int4 NULL,
                                        em_stat_cal_ctm varchar(20) NULL,
                                        em_stat_cal varchar(30) NULL,
                                        em_stat_period varchar(1) NULL,
                                        interval_sequence varchar(4000) NULL,
                                        specific_times varchar(4000) NULL,
                                        tolerance int4 NULL,
                                        cyclic_type varchar(1) NULL,
                                        current_run int4 NULL,
                                        elapsed_runtime int4 NULL,
                                        workloads varchar(525) NULL,
                                        def_nodegroup varchar(50) NULL,
                                        nodegroup_set_by varchar(1) NULL,
                                        failure_rc varchar(5) NULL,
                                        failure_rc_step varchar(8) NULL,
                                        failure_rc_procstep varchar(8) NULL,
                                        highest_rc varchar(5) NULL,
                                        highest_rc_step varchar(8) NULL,
                                        highest_rc_procstep varchar(8) NULL,
                                        highest_rc_memname varchar(8) NULL,
                                        associated_rbc varchar(20) NULL,
                                        cm_status varchar(32) NULL,
                                        depend_service_in varchar(1) NULL,
                                        depend_service_out varchar(1) NULL,
                                        em_stat_detail_data varchar(1500) NULL,
                                        prev_odate_rerun_counter int4 NULL,
                                        jobrc varchar(5) NULL,
                                        removeatonce varchar(1) NULL,
                                        dayskeepinnotok int2 NULL,
                                        delay int4 NULL,
                                        biminfo varchar(20) NULL,
                                        std_dev_start_time varchar(11) NULL,
                                        end_folder varchar(1) NULL
);
CREATE INDEX ez_history_001_0 ON ezjobs.ez_history_001 USING btree (order_id);
CREATE INDEX ez_history_001_1 ON ezjobs.ez_history_001 USING btree (odate);
CREATE INDEX ez_history_001_2 ON ezjobs.ez_history_001 USING btree (start_time);
CREATE INDEX ez_history_001_3 ON ezjobs.ez_history_001 USING btree (end_time);


-- ezjobs.ez_history_i_001 definition

-- Drop table

-- DROP TABLE ezjobs.ez_history_i_001;

CREATE TABLE ezjobs.ez_history_i_001 (
                                          order_id varchar(5) NOT NULL,
                                          "condition" varchar(255) NOT NULL,
                                          odate varchar(4) NOT NULL,
                                          and_or varchar(1) NOT NULL,
                                          parentheses varchar(2) NULL,
                                          "ignore" varchar(1) NULL,
                                          order_ int4 NULL,
                                          isn_ int4 NULL
);


-- ezjobs.ez_history_o_001 definition

-- Drop table

-- DROP TABLE ezjobs.ez_history_o_001;

CREATE TABLE ezjobs.ez_history_o_001 (
                                          order_id varchar(5) NOT NULL,
                                          "condition" varchar(255) NOT NULL,
                                          odate varchar(4) NOT NULL,
                                          sign varchar(1) NOT NULL,
                                          isn_ int4 NULL
);


-- ezjobs.ez_history_setvar_001 definition

-- Drop table

-- DROP TABLE ezjobs.ez_history_setvar_001;

CREATE TABLE ezjobs.ez_history_setvar_001 (
                                               order_id varchar(5) NOT NULL,
                                               "name" varchar(128) NULL,
                                               value varchar(4000) NULL,
                                               global_ind varchar(1) NULL,
                                               order_ int2 NOT NULL,
                                               isn_ int4 NULL
);
CREATE INDEX ez_history_setvar_001_0 ON ezjobs.ez_history_setvar_001 USING btree (order_id, name);


-- ezjobs.ez_host definition

-- Drop table

-- DROP TABLE ezjobs.ez_host;

CREATE TABLE ezjobs.ez_host (
                                 host_cd int4 NOT NULL,
                                 data_center varchar(64) NOT NULL,
                                 agent varchar(100) NOT NULL,
                                 agent_nm varchar(400) NULL,
                                 agent_id varchar(100) NULL,
                                 agent_pw varchar(100) NULL,
                                 file_path varchar(256) NULL,
                                 access_gubun varchar(1) NULL,
                                 access_port int4 NULL,
                                 server_gubun varchar(1) NULL,
                                 ins_date timestamp NOT NULL,
                                 ins_user_cd int4 NOT NULL,
                                 ins_user_ip varchar(50) NOT NULL,
                                 udt_date timestamp NULL,
                                 udt_user_cd int4 NULL,
                                 udt_user_ip varchar(50) NULL,
                                 scode_cd varchar(10) NULL,
                                 server_lang varchar(1) NULL,
                                 certify_gubun varchar(1) NULL DEFAULT 'P'::character varying
);
CREATE UNIQUE INDEX pk_ez_host ON ezjobs.ez_host USING btree (host_cd);


-- ezjobs.ez_job_mapper definition

-- Drop table

-- DROP TABLE ezjobs.ez_job_mapper;

CREATE TABLE ezjobs.ez_job_mapper (
                                       data_center varchar(64) NOT NULL,
                                       job varchar(64) NOT NULL,
                                       user_cd_1 int4 NULL,
                                       user_cd_2 int4 NULL,
                                       user_cd_3 int4 NULL,
                                       user_cd_4 int4 NULL,
                                       user_cd_5 int4 NULL,
                                       user_cd_6 int4 NULL,
                                       user_cd_7 int4 NULL,
                                       user_cd_8 int4 NULL,
                                       user_cd_9 int4 NULL,
                                       user_cd_10 int4 NULL,
                                       sms_1 varchar(1) NULL,
                                       sms_2 varchar(1) NULL,
                                       sms_3 varchar(1) NULL,
                                       sms_4 varchar(1) NULL,
                                       sms_5 varchar(1) NULL,
                                       sms_6 varchar(1) NULL,
                                       sms_7 varchar(1) NULL,
                                       sms_8 varchar(1) NULL,
                                       sms_9 varchar(1) NULL,
                                       sms_10 varchar(1) NULL,
                                       mail_1 varchar(1) NULL,
                                       mail_2 varchar(1) NULL,
                                       mail_3 varchar(1) NULL,
                                       mail_4 varchar(1) NULL,
                                       mail_5 varchar(1) NULL,
                                       mail_6 varchar(1) NULL,
                                       mail_7 varchar(1) NULL,
                                       mail_8 varchar(1) NULL,
                                       mail_9 varchar(1) NULL,
                                       mail_10 varchar(1) NULL,
                                       grp_cd_1 int4 NULL,
                                       grp_cd_2 int4 NULL,
                                       grp_sms_1 varchar(1) NULL,
                                       grp_sms_2 varchar(1) NULL,
                                       grp_mail_1 varchar(1) NULL,
                                       grp_mail_2 varchar(1) NULL,
                                       error_description varchar(4000) NULL,
                                       late_sub varchar(4) NULL,
                                       late_time varchar(4) NULL,
                                       late_exec varchar(10) NULL,
                                       success_sms_yn bpchar(1) NULL,
                                       batchjobgrade varchar(100) NULL,
                                       jobschedgb varchar(20) NULL,
                                       cc_count varchar(10) NULL,
                                       ins_user_cd int4 NOT NULL,
                                       ins_date timestamp NOT NULL,
                                       ins_user_ip varchar(50) NULL,
                                       udt_user_cd int4 NULL,
                                       udt_date timestamp NULL,
                                       udt_user_ip varchar(50) NULL
);
CREATE UNIQUE INDEX pk_ez_job_mapper ON ezjobs.ez_job_mapper USING btree (data_center, job);


-- ezjobs.ez_job_mapper_doc definition

-- Drop table

-- DROP TABLE ezjobs.ez_job_mapper_doc;

CREATE TABLE ezjobs.ez_job_mapper_doc (
                                           doc_cd varchar(64) NOT NULL,
                                           data_center varchar(64) NOT NULL,
                                           job varchar(64) NOT NULL,
                                           user_cd_1 int4 NULL,
                                           user_cd_2 int4 NULL,
                                           user_cd_3 int4 NULL,
                                           user_cd_4 int4 NULL,
                                           user_cd_5 int4 NULL,
                                           user_cd_6 int4 NULL,
                                           user_cd_7 int4 NULL,
                                           user_cd_8 int4 NULL,
                                           user_cd_9 int4 NULL,
                                           user_cd_10 int4 NULL,
                                           sms_1 varchar(1) NULL,
                                           sms_2 varchar(1) NULL,
                                           sms_3 varchar(1) NULL,
                                           sms_4 varchar(1) NULL,
                                           sms_5 varchar(1) NULL,
                                           sms_6 varchar(1) NULL,
                                           sms_7 varchar(1) NULL,
                                           sms_8 varchar(1) NULL,
                                           sms_9 varchar(1) NULL,
                                           sms_10 varchar(1) NULL,
                                           mail_1 varchar(1) NULL,
                                           mail_2 varchar(1) NULL,
                                           mail_3 varchar(1) NULL,
                                           mail_4 varchar(1) NULL,
                                           mail_5 varchar(1) NULL,
                                           mail_6 varchar(1) NULL,
                                           mail_7 varchar(1) NULL,
                                           mail_8 varchar(1) NULL,
                                           mail_9 varchar(1) NULL,
                                           mail_10 varchar(1) NULL,
                                           grp_cd_1 int4 NULL,
                                           grp_cd_2 int4 NULL,
                                           grp_sms_1 varchar(1) NULL,
                                           grp_sms_2 varchar(1) NULL,
                                           grp_mail_1 varchar(1) NULL,
                                           grp_mail_2 varchar(1) NULL,
                                           error_description varchar(4000) NULL,
                                           late_sub varchar(4) NULL,
                                           late_time varchar(4) NULL,
                                           late_exec varchar(10) NULL,
                                           success_sms_yn bpchar(1) NULL,
                                           batchjobgrade varchar(100) NULL,
                                           jobschedgb varchar(20) NULL,
                                           cc_count varchar(10) NULL,
                                           ins_user_cd int4 NOT NULL,
                                           ins_date timestamp NOT NULL,
                                           ins_user_ip varchar(50) NULL,
                                           udt_user_cd int4 NULL,
                                           udt_date timestamp NULL,
                                           udt_user_ip varchar(50) NULL
);
CREATE UNIQUE INDEX pk_ez_job_mapper_doc ON ezjobs.ez_job_mapper_doc USING btree (doc_cd, data_center, job);


-- ezjobs.ez_job_mapper_original definition

-- Drop table

-- DROP TABLE ezjobs.ez_job_mapper_original;

CREATE TABLE ezjobs.ez_job_mapper_original (
                                                doc_cd varchar(64) NOT NULL,
                                                data_center varchar(64) NOT NULL,
                                                job varchar(64) NOT NULL,
                                                user_cd_1 int4 NULL,
                                                user_cd_2 int4 NULL,
                                                user_cd_3 int4 NULL,
                                                user_cd_4 int4 NULL,
                                                user_cd_5 int4 NULL,
                                                user_cd_6 int4 NULL,
                                                user_cd_7 int4 NULL,
                                                user_cd_8 int4 NULL,
                                                user_cd_9 int4 NULL,
                                                user_cd_10 int4 NULL,
                                                sms_1 varchar(1) NULL,
                                                sms_2 varchar(1) NULL,
                                                sms_3 varchar(1) NULL,
                                                sms_4 varchar(1) NULL,
                                                sms_5 varchar(1) NULL,
                                                sms_6 varchar(1) NULL,
                                                sms_7 varchar(1) NULL,
                                                sms_8 varchar(1) NULL,
                                                sms_9 varchar(1) NULL,
                                                sms_10 varchar(1) NULL,
                                                mail_1 varchar(1) NULL,
                                                mail_2 varchar(1) NULL,
                                                mail_3 varchar(1) NULL,
                                                mail_4 varchar(1) NULL,
                                                mail_5 varchar(1) NULL,
                                                mail_6 varchar(1) NULL,
                                                mail_7 varchar(1) NULL,
                                                mail_8 varchar(1) NULL,
                                                mail_9 varchar(1) NULL,
                                                mail_10 varchar(1) NULL,
                                                grp_cd_1 int4 NULL,
                                                grp_cd_2 int4 NULL,
                                                grp_sms_1 varchar(1) NULL,
                                                grp_sms_2 varchar(1) NULL,
                                                grp_mail_1 varchar(1) NULL,
                                                grp_mail_2 varchar(1) NULL,
                                                error_description varchar(4000) NULL,
                                                late_sub varchar(4) NULL,
                                                late_time varchar(4) NULL,
                                                late_exec varchar(10) NULL,
                                                success_sms_yn bpchar(1) NULL,
                                                batchjobgrade varchar(100) NULL,
                                                jobschedgb varchar(20) NULL,
                                                cc_count varchar(10) NULL,
                                                ins_user_cd int4 NOT NULL,
                                                ins_date timestamp NOT NULL,
                                                ins_user_ip varchar(50) NULL,
                                                udt_user_cd int4 NULL,
                                                udt_date timestamp NULL,
                                                udt_user_ip varchar(50) NULL
);
CREATE UNIQUE INDEX pk_ez_job_mapper_original ON ezjobs.ez_job_mapper_original USING btree (doc_cd, data_center, job);


-- ezjobs.ez_jobgroup definition

-- Drop table

-- DROP TABLE ezjobs.ez_jobgroup;

CREATE TABLE ezjobs.ez_jobgroup (
                                     jobgroup_id varchar(5) NOT NULL,
                                     jobgroup_name varchar(100) NULL,
                                     ins_user_cd int4 NULL,
                                     ins_date timestamp NULL,
                                     udt_user_cd int4 NULL,
                                     udt_date timestamp NULL,
                                     "content" varchar(4000) NULL,
                                     CONSTRAINT pk_ez_jobgroup PRIMARY KEY (jobgroup_id)
);


-- ezjobs.ez_jobgroup_job definition

-- Drop table

-- DROP TABLE ezjobs.ez_jobgroup_job;

CREATE TABLE ezjobs.ez_jobgroup_job (
                                         jobgroup_id varchar(5) NOT NULL,
                                         table_id int4 NOT NULL,
                                         job_id int4 NOT NULL,
                                         data_center varchar(50) NOT NULL,
                                         ins_date timestamp NULL,
                                         job_name varchar(64) NULL,
                                         table_name varchar(50) NULL,
                                         application varchar(50) NULL,
                                         group_name varchar(50) NULL,
                                         CONSTRAINT pk_ez_jobgroup_job PRIMARY KEY (jobgroup_id, table_id, job_id, data_center)
);


-- ezjobs.ez_login_log definition

-- Drop table

-- DROP TABLE ezjobs.ez_login_log;

CREATE TABLE ezjobs.ez_login_log (
                                      login_cd int4 NOT NULL,
                                      ins_date timestamp NOT NULL,
                                      ins_user_cd int4 NOT NULL,
                                      ins_user_ip varchar(50) NOT NULL
);
CREATE UNIQUE INDEX pk_ez_login_log ON ezjobs.ez_login_log USING btree (login_cd);


-- ezjobs.ez_mcode definition

-- Drop table

-- DROP TABLE ezjobs.ez_mcode;

CREATE TABLE ezjobs.ez_mcode (
                                  mcode_cd varchar(5) NOT NULL,
                                  mcode_nm varchar(80) NOT NULL,
                                  del_yn varchar(1) NOT NULL,
                                  ins_date timestamp NOT NULL,
                                  mcode_desc varchar(4000) NULL
);
CREATE UNIQUE INDEX pk_ez_mcode ON ezjobs.ez_mcode USING btree (mcode_cd);


-- ezjobs.ez_otp definition

-- Drop table

-- DROP TABLE ezjobs.ez_otp;

CREATE TABLE ezjobs.ez_otp (
                                otp_cd int4 NOT NULL,
                                otp varchar(100) NOT NULL,
                                otp_time varchar(10) NOT NULL,
                                ins_date timestamp NOT NULL,
                                ins_user_cd int4 NOT NULL,
                                ins_user_ip varchar(50) NOT NULL
);
CREATE UNIQUE INDEX pk_ez_otp ON ezjobs.ez_otp USING btree (otp_cd);


-- ezjobs.ez_over_send definition

-- Drop table

-- DROP TABLE ezjobs.ez_over_send;

CREATE TABLE ezjobs.ez_over_send (
                                      "DATA_CENTER" varchar(20) NULL,
                                      "SEND_DATE" date NULL,
                                      "JOB_NAME" varchar(64) NULL,
                                      "DESCRIPTION" varchar(4000) NULL,
                                      "AVG_RUNTIME" varchar(12) NULL,
                                      "ALARM_STANDARD" varchar(64) NULL,
                                      "ALARM_TIME" varchar(64) NULL,
                                      "ALARM_OVER" varchar(64) NULL,
                                      "ALARM_OVER_TIME" varchar(64) NULL,
                                      "ORDER_ID" varchar(50) NULL,
                                      "ODATE" varchar(8) NULL
);


-- ezjobs.ez_quartz_log definition

-- Drop table

-- DROP TABLE ezjobs.ez_quartz_log;

CREATE TABLE ezjobs.ez_quartz_log (
                                       quartz_cd int4 NOT NULL,
                                       quartz_name varchar(200) NULL,
                                       trace_log_path varchar(200) NULL,
                                       status_cd varchar(2) NULL,
                                       status_log varchar(4000) NULL,
                                       ins_date timestamp NULL
);
CREATE UNIQUE INDEX ez_quartz_log_pk ON ezjobs.ez_quartz_log USING btree (quartz_cd);


-- ezjobs.ez_resource definition

-- Drop table

-- DROP TABLE ezjobs.ez_resource;

CREATE TABLE ezjobs.ez_resource (
                                     qresname varchar(64) NULL,
                                     qrtotal int4 NULL,
                                     qrused int4 NULL DEFAULT 0,
                                     ins_date timestamp NULL,
                                     data_center varchar(64) NULL
);


-- ezjobs.ez_runinfo_history definition

-- Drop table

-- DROP TABLE ezjobs.ez_runinfo_history;

CREATE TABLE ezjobs.ez_runinfo_history (
                                            order_id varchar(5) NOT NULL,
                                            data_center varchar(20) NOT NULL,
                                            sched_table varchar(770) NOT NULL,
                                            application varchar(64) NULL,
                                            group_name varchar(64) NULL,
                                            job_name varchar(64) NULL,
                                            "owner" varchar(30) NULL,
                                            node_group varchar(50) NULL,
                                            node_id varchar(50) NULL,
                                            start_time timestamp NULL,
                                            end_time timestamp NULL,
                                            odate varchar(6) NOT NULL,
                                            rerun_counter int4 NOT NULL,
                                            status varchar(50) NULL,
                                            description varchar(4000) NULL,
                                            sysout varchar(4000) NULL
);


-- ezjobs.ez_scode definition

-- Drop table

-- DROP TABLE ezjobs.ez_scode;

CREATE TABLE ezjobs.ez_scode (
                                  mcode_cd varchar(10) NOT NULL,
                                  scode_cd varchar(10) NOT NULL,
                                  scode_nm varchar(200) NOT NULL,
                                  order_no int4 NOT NULL,
                                  ins_date timestamp NOT NULL,
                                  scode_eng_nm varchar(200) NULL,
                                  scode_desc varchar(4000) NULL,
                                  scode_use_yn bpchar(1) NULL,
                                  host_cd int4 NULL
);
CREATE UNIQUE INDEX pk_ez_scode ON ezjobs.ez_scode USING btree (mcode_cd, scode_cd);


-- ezjobs.ez_send_log definition

-- Drop table

-- DROP TABLE ezjobs.ez_send_log;

CREATE TABLE ezjobs.ez_send_log (
                                     send_cd int4 NOT NULL,
                                     data_center varchar(20) NOT NULL,
                                     job_name varchar(64) NOT NULL,
                                     order_id varchar(50) NULL,
                                     send_gubun varchar(5) NOT NULL,
                                     message varchar(1000) NOT NULL,
                                     send_info varchar(100) NOT NULL,
                                     send_user_cd int4 NOT NULL,
                                     send_date timestamp NOT NULL,
                                     return_code bpchar(2) NULL,
                                     return_date timestamp NULL,
                                     send_desc varchar(20) NULL,
                                     rerun_counter int4 NULL,
                                     odate varchar(8) NULL,
                                     send_description varchar(100) NULL
);
CREATE UNIQUE INDEX pk_ez_send_log ON ezjobs.ez_send_log USING btree (send_cd);


-- ezjobs.ez_user definition

-- Drop table

-- DROP TABLE ezjobs.ez_user;

CREATE TABLE ezjobs.ez_user (
                                 user_cd int4 NOT NULL,
                                 user_id varchar(50) NOT NULL,
                                 user_nm varchar(50) NOT NULL,
                                 user_pw varchar(512) NOT NULL,
                                 user_gb varchar(2) NOT NULL DEFAULT 'N'::character varying,
                                 no_auth varchar(4000) NULL,
                                 dept_cd int4 NOT NULL,
                                 duty_cd int4 NOT NULL,
                                 del_yn varchar(1) NOT NULL DEFAULT 'N'::character varying,
                                 retire_yn varchar(1) NULL DEFAULT 'N'::character varying,
                                 reset_yn varchar(1) NULL,
                                 user_email varchar(100) NULL,
                                 user_hp varchar(20) NULL,
                                 user_tel varchar(50) NULL,
                                 select_data_center_code varchar(20) NULL,
                                 pw_fail_cnt varchar NULL,
                                 pw_date timestamp NULL,
                                 before_pw varchar(4000) NULL,
                                 account_lock varchar(1) NULL,
                                 absence_start_date timestamp NULL,
                                 absence_end_date timestamp NULL,
                                 absence_reason varchar(200) NULL,
                                 absence_user_cd int4 NULL,
                                 ins_date timestamp NOT NULL,
                                 ins_user_cd int4 NOT NULL,
                                 ins_user_ip varchar(50) NOT NULL,
                                 udt_date timestamp NULL,
                                 udt_user_cd int4 NULL,
                                 udt_user_ip varchar(50) NULL,
                                 default_paging varchar(5) NULL,
                                 select_table_name varchar(50) NULL,
                                 select_application varchar(50) NULL,
                                 select_group_name varchar(50) NULL,
                                 user_appr_gb varchar(2) NULL,
                                 user_ip varchar(100) NULL
);
CREATE UNIQUE INDEX pk_ez_user ON ezjobs.ez_user USING btree (user_cd);


-- ezjobs.ez_user_approval_group definition

-- Drop table

-- DROP TABLE ezjobs.ez_user_approval_group;

CREATE TABLE ezjobs.ez_user_approval_group (
                                                line_grp_cd int4 NOT NULL,
                                                line_grp_nm varchar(100) NOT NULL,
                                                use_yn bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
                                                owner_user_cd int4 NOT NULL,
                                                ins_date timestamp NOT NULL DEFAULT now(),
                                                ins_user_cd int4 NOT NULL,
                                                doc_gubun bpchar(2) NULL
);
CREATE UNIQUE INDEX ez_user_approval_group_pk ON ezjobs.ez_user_approval_group USING btree (line_grp_cd);


-- ezjobs.ez_user_approval_line definition

-- Drop table

-- DROP TABLE ezjobs.ez_user_approval_line;

CREATE TABLE ezjobs.ez_user_approval_line (
                                               line_cd int4 NOT NULL,
                                               line_grp_cd int4 NOT NULL,
                                               approval_cd int4 NOT NULL,
                                               approval_seq int4 NOT NULL,
                                               use_yn bpchar(1) NOT NULL DEFAULT 'Y'::bpchar,
                                               ins_date timestamp NOT NULL DEFAULT now(),
                                               ins_user_cd int4 NOT NULL,
                                               approval_gb bpchar(2) NULL
);
CREATE UNIQUE INDEX ez_user_approval_line_pk ON ezjobs.ez_user_approval_line USING btree (line_cd);


-- ezjobs.ez_user_folder definition

-- Drop table

-- DROP TABLE ezjobs.ez_user_folder;

CREATE TABLE ezjobs.ez_user_folder (
                                        user_cd int4 NOT NULL,
                                        folder_auth varchar(4000) NULL,
                                        data_center varchar(50) NOT NULL
);


-- ezjobs.ez_user_folder_history definition

-- Drop table

-- DROP TABLE ezjobs.ez_user_folder_history;

CREATE TABLE ezjobs.ez_user_folder_history (
                                                user_cd int4 NOT NULL,
                                                folder_auth varchar(4000) NULL,
                                                data_center varchar(50) NOT NULL,
                                                status_gb varchar(10) NULL,
                                                ins_date timestamp NOT NULL,
                                                ins_user_ip varchar(50) NOT NULL,
                                                ins_user_cd int4 NOT NULL
);


-- ezjobs.ez_user_history definition

-- Drop table

-- DROP TABLE ezjobs.ez_user_history;

CREATE TABLE ezjobs.ez_user_history (
                                         user_cd int4 NOT NULL,
                                         user_id varchar(50) NOT NULL,
                                         user_nm varchar(50) NOT NULL,
                                         flag varchar(50) NULL,
                                         user_gb varchar(2) NOT NULL DEFAULT 'N'::character varying,
                                         dept_cd int4 NOT NULL,
                                         duty_cd int4 NOT NULL,
                                         del_yn varchar(1) NOT NULL DEFAULT 'N'::character varying,
                                         retire_yn varchar(1) NOT NULL DEFAULT 'N'::character varying,
                                         user_email varchar(100) NULL,
                                         user_hp varchar(20) NULL,
                                         user_tel varchar(50) NULL,
                                         select_data_center_code varchar(20) NULL,
                                         account_lock varchar(1) NULL,
                                         ins_date timestamp NOT NULL,
                                         ins_user_cd int4 NOT NULL,
                                         ins_user_ip varchar(50) NOT NULL,
                                         udt_date timestamp NULL,
                                         udt_user_cd int4 NULL,
                                         udt_user_ip varchar(50) NULL,
                                         select_table_name varchar(50) NULL,
                                         select_application varchar(50) NULL,
                                         select_group_name varchar(50) NULL,
                                         user_appr_gb varchar(2) NULL,
                                         reg_date timestamp NOT NULL,
                                         user_ip varchar(100) NULL
);


-- ezjobs.ez_user_relay definition

-- Drop table

-- DROP TABLE ezjobs.ez_user_relay;

CREATE TABLE ezjobs.ez_user_relay (
                                       user_id varchar(100) NULL,
                                       user_nm varchar(100) NULL,
                                       duty_nm varchar(100) NULL,
                                       dept_nm varchar(100) NULL,
                                       user_email varchar(100) NULL,
                                       user_hp varchar(100) NULL,
                                       state_cd varchar(100) NULL,
                                       ins_date timestamp NOT NULL
);


-- ezjobs.ez_work definition

-- Drop table

-- DROP TABLE ezjobs.ez_work;

CREATE TABLE ezjobs.ez_work (
                                 work_cd int4 NOT NULL,
                                 work_date varchar(8) NULL,
                                 "content" varchar(64) NULL,
                                 user_cd int4 NULL
);
CREATE UNIQUE INDEX pk_ez_work ON ezjobs.ez_work USING btree (work_cd);


-- Drop table

-- DROP TABLE ezjobs4.ez_database;

CREATE TABLE ezjobs4.ez_database (
	database_cd int4 NOT NULL,
	profile_name varchar(50) NULL,
	data_center varchar(64) NOT NULL,
	"type" varchar(100) NOT NULL,
	port int4 NOT NULL,
	host varchar(100) NOT NULL,
	user_nm varchar(100) NOT NULL,
	"password" varchar(100) NULL,
	database_name varchar(100) NULL,
	database_version varchar(100) NOT NULL,
	sid varchar(50) NULL,
	target_agent varchar(64) NOT NULL,
	ins_date timestamp NOT NULL,
	ins_user_cd int4 NOT NULL,
	ins_user_ip varchar(50) NOT NULL,
	udt_date timestamp NULL,
	udt_user_cd int4 NULL,
	udt_user_ip varchar(50) NULL
);
CREATE UNIQUE INDEX pk_ez_database ON ezjobs4.ez_database USING btree (database_cd);


ALTER TABLE ezjobs.ez_runinfo_history ADD sysout_yn varchar(1) NULL;
ALTER TABLE ezjobs.ez_runinfo_history ADD sysout varchar(4000) NULL;
ALTER TABLE ezjobs.ez_runinfo_history ADD appl_type varchar(10) NULL;
ALTER TABLE ezjobs.ez_alarm ALTER COLUMN order_table TYPE varchar(770) USING order_table::varchar;




-- 스마트폴더 사용으로 인한 폴더 컬럼 사이즈 증가
ALTER TABLE ezjobs.ez_doc_01 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_02 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_03 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_04 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_04_original ALTER COLUMN table_name SET DATA TYPE varchar(770);

ALTER TABLE ezjobs.ez_doc_04 ALTER COLUMN before_table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_04_original ALTER COLUMN before_table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_05 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_06 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_06_detail ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_07 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_doc_08 ALTER COLUMN table_name SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_runinfo_history ALTER COLUMN sched_table SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.EZ_AVG_INFO ALTER COLUMN order_table SET DATA TYPE varchar(770);
ALTER TABLE ezjobs.ez_alarm ALTER COLUMN order_table TYPE varchar(770) USING order_table::varchar;

-- 스마트폴더 orderIntoFolder 옵션 추가
ALTER TABLE ezjobs.ez_doc_05 ADD order_into_folder varchar(5) NULL;

