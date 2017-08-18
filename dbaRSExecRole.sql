USE [master]
GO
CREATE ROLE [RSExecRole] AUTHORIZATION [dbo];
GRANT EXECUTE ON [dbo].[xp_sqlagent_enum_jobs] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[xp_sqlagent_is_starting] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[xp_sqlagent_notify] TO [RSExecRole];

USE [msdb]
GO
CREATE ROLE [RSExecRole] AUTHORIZATION [dbo];
GRANT EXECUTE ON [dbo].[sp_add_job] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_help_job] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_add_jobserver] TO [RSExecRole];
GRANT SELECT ON [dbo].[syscategories] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_add_jobstep] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_add_category] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_help_category] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_add_jobschedule] TO [RSExecRole];
GRANT SELECT ON [dbo].[sysjobs] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_delete_job] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_verify_job_identifiers] TO [RSExecRole];
GRANT EXECUTE ON [dbo].[sp_help_jobschedule] TO [RSExecRole];

--add appropriate user(s)
--use master
--go
--create user [kforce\svc-npsqlsde] 
--go
--sp_addrolemember 'rsexecrole', [kforce\svc-npsqlsde]
--go
--use msdb
--go
--create user [kforce\svc-npsqlsde]
--go
--sp_addrolemember 'rsexecrole', [kforce\svc-npsqlsde]
--go