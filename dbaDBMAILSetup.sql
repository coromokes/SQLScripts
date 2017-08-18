sp_configure 'show advanced options', 1
reconfigure;
EXECUTE sp_configure 'Database Mail XPs',1;
RECONFIGURE;
GO

declare @instance varchar(100)
select @instance = @@servername
-- Create a Database Mail account
EXECUTE msdb.dbo.sysmail_add_account_sp
    @account_name = 'relay',
    @description = 'Account used by SQL Admin and all mail profiles.',
    @email_address = 'sqlexec@kforce.com',
    @replyto_address = 'sqlexec@kforce.com',
    @display_name = @instance,
    @mailserver_name = 'relay.kforce.com';
 
-- Create a Database Mail profile
EXECUTE msdb.dbo.sysmail_add_profile_sp
    @profile_name = 'DBMAIL',
    @description = 'Default public profile for all users';
 
-- Add the account to the profile
EXECUTE msdb.dbo.sysmail_add_profileaccount_sp
    @profile_name = 'DBMAIL',
    @account_name = 'relay',
    @sequence_number = 1;
 
-- Grant access to the profile to all msdb database users
EXECUTE msdb.dbo.sysmail_add_principalprofile_sp
    @profile_name = 'DBMAIL',
    @principal_name = 'public',
    @is_default = 1;
GO
 
--send a test email
EXECUTE msdb.dbo.sp_send_dbmail
    @subject = 'Test Database Mail Message',
    @recipients = 'mbrown2@kforce.com',
    @query = 'SELECT @@SERVERNAME';
GO

USE [msdb]
GO
EXEC master.dbo.sp_MSsetalertinfo @failsafeoperator=N'SQL ADMINISTRATORS', 
		@notificationmethod=1
GO
USE [msdb]
GO
EXEC msdb.dbo.sp_set_sqlagent_properties @email_save_in_sent_folder=1, 
		@databasemail_profile=N'DBMAIL', 
		@use_databasemail=1
GO
