-- EZJOBS 로그인 후 권한 부여
grant select, insert, update, delete on EZ_ADMIN_APPROVAL_GROUP     to emuser;
grant select, insert, update, delete on EZ_ADMIN_APPROVAL_LINE      to emuser;
grant select, insert, update, delete on EZ_ALARM                    to emuser;
grant select, insert, update, delete on EZ_APPROVAL_DOC             to emuser;
grant select, insert, update, delete on EZ_APP_GRP_CODE             to emuser;
grant select, insert, update, delete on EZ_AVG_INFO                 to emuser;
grant select, insert, update, delete on EZ_AVG_TIME                 to emuser;
grant select, insert, update, delete on EZ_BOARD                    to emuser;
grant select, insert, update, delete on EZ_CMR_RPLN                 to emuser;
grant select, insert, update, delete on EZ_CONFIRM                  to emuser;
grant select, insert, update, delete on EZ_DEPT                     to emuser;
grant select, insert, update, delete on EZ_DEPT_RELAY               to emuser;
grant select, insert, update, delete on EZ_DOC_01                   to emuser;
grant select, insert, update, delete on EZ_DOC_02                   to emuser;
grant select, insert, update, delete on EZ_DOC_03                   to emuser;
grant select, insert, update, delete on EZ_DOC_04                   to emuser;
grant select, insert, update, delete on EZ_DOC_04_ORIGINAL          to emuser;
grant select, insert, update, delete on EZ_DOC_05                   to emuser;
grant select, insert, update, delete on EZ_DOC_06                   to emuser;
grant select, insert, update, delete on EZ_DOC_06_DETAIL            to emuser;
grant select, insert, update, delete on EZ_DOC_07                   to emuser;
grant select, insert, update, delete on EZ_DOC_09                   to emuser;
grant select, insert, update, delete on EZ_DOC_10                   to emuser;
grant select, insert, update, delete on EZ_DOC_GROUP                to emuser;
grant select, insert, update, delete on EZ_DOC_MASTER               to emuser;
grant select, insert, update, delete on EZ_DUTY                     to emuser;
grant select, insert, update, delete on EZ_DUTY_RELAY               to emuser;
grant select, insert, update, delete on EZ_GROUP_APPROVAL_GROUP     to emuser;
grant select, insert, update, delete on EZ_GROUP_APPROVAL_LINE      to emuser;
grant select, insert, update, delete on EZ_GRP_HOST                 to emuser;
grant select, insert, update, delete on EZ_HISTORY_001              to emuser;
grant select, insert, update, delete on EZ_HISTORY_002              to emuser;
grant select, insert, update, delete on EZ_HOST                     to emuser;
grant select, insert, update, delete on EZ_JOBGROUP                 to emuser;
grant select, insert, update, delete on EZ_JOBGROUP_JOB             to emuser;
grant select, insert, update, delete on EZ_JOB_MAPPER               to emuser;
grant select, insert, update, delete on EZ_JOB_MAPPER_DOC           to emuser;
grant select, insert, update, delete on EZ_LOGIN_LOG                to emuser;
grant select, insert, update, delete on EZ_MCODE                    to emuser;
grant select, insert, update, delete on EZ_QUARTZ_LOG               to emuser;
grant select, insert, update, delete on EZ_RUNINFO_HISTORY          to emuser;
grant select, insert, update, delete on EZ_SCODE                    to emuser;
grant select, insert, update, delete on EZ_SEND_LOG                 to emuser;
grant select, insert, update, delete on EZ_USER                     to emuser;
grant select, insert, update, delete on EZ_USER_APPROVAL_GROUP      to emuser;
grant select, insert, update, delete on EZ_USER_APPROVAL_LINE       to emuser;
grant select, insert, update, delete on EZ_USER_FOLDER              to emuser;
grant select, insert, update, delete on EZ_USER_HISTORY             to emuser;
grant select, insert, update, delete on EZ_USER_RELAY               to emuser;
grant select, insert, update, delete on EZ_WORK						to emuser;
grant select, insert, update, delete on EZ_RESOURCE					to emuser;
grant select, insert, update, delete on EZ_OVER_SEND				to emuser;
grant select, insert, update, delete on EZ_ALARM_INFO				to emuser;
grant select, insert, update, delete on EZ_DOC_10                   to emuser;
grant select, insert, update, delete on EZ_OTP						to emuser;

grant execute on SP_EZ_ALARM_PRC                                    to emuser;
grant execute on SP_EZ_DEPT_PRC                                     to emuser;
grant execute on SP_EZ_DOC_01_PRC_NEW                               to emuser;
grant execute on SP_EZ_DOC_02_PRC_NEW                               to emuser;
grant execute on SP_EZ_DOC_03_PRC                                   to emuser;
grant execute on SP_EZ_DOC_04_PRC_NEW                               to emuser;
grant execute on SP_EZ_DOC_05_PRC                                   to emuser;
grant execute on SP_EZ_DOC_06_PRC_NEW                               to emuser;
grant execute on SP_EZ_DOC_07_PRC                                   to emuser;
grant execute on SP_EZ_DOC_09_PRC                                   to emuser;
grant execute on SP_EZ_DOC_10_PRC                                   to emuser;
grant execute on SP_EZ_DOC_APPROVAL_PRC                             to emuser;
grant execute on SP_EZ_DOC_APPROVAL_SET_PRC                         to emuser;
grant execute on SP_EZ_DUTY_PRC                                     to emuser;
grant execute on SP_EZ_HOST_PRC                                     to emuser;
grant execute on SP_EZ_JOBGROUP_PRC                                 to emuser;
grant execute on SP_EZ_JOB_MAPPER_NEW_PRC                           to emuser;
grant execute on SP_EZ_LOG_PRC                                      to emuser;
grant execute on SP_EZ_USER_PRC                                     to emuser;
grant execute on SP_EZ_WORK_PRC                                     to emuser;
grant execute on SP_QUARTZ_PRC										to emuser;
grant execute on SP_EZ_DOC_SETVAR_PRC								to emuser;

-- EMUSER 로그인 후 권한 부여
GRANT SELECT ON def_job TO ezjobs;
GRANT SELECT ON def_tables TO ezjobs;
GRANT SELECT ON def_tags TO ezjobs;
GRANT SELECT ON comm TO ezjobs;
GRANT SELECT ON alarm TO ezjobs;
GRANT SELECT ON runinfo_history TO ezjobs;

-- CTM 로그인 후 권한 부여
GRANT SELECT ON CMR_IOALOG TO emuser;
GRANT SELECT ON CMR_QRTAB TO emuser;
GRANT SELECT ON CMR_QRUSE TO emuser;
GRANT SELECT ON CMR_NODES TO emuser;

-- history 선후행 쌓기위한 테이블 권한 부여(23.10.05)
GRANT SELECT, DELETE, UPDATE, INSERT on EZ_HISTORY_I_001 TO emuser;
GRANT SELECT, DELETE, UPDATE, INSERT on EZ_HISTORY_O_001 TO emuser;

-- 요청서 용 변수 테이블 권한 부여
GRANT SELECT, INSERT, UPDATE, DELETE ON EZ_DOC_SETVAR TO emuser;

-- TRUNCATE 하기 위한 권한 부여
grant drop any table to emuser
