Declare @netpath varchar(500) = (select '\\'+CONVERT(sysname,SERVERPROPERTY('ComputerNamePhysicalNetBIOS'))+
			  				'\'+Replace(log_file_path,':','$') from master.sys.server_file_audits  where name ='AllLoginsAudit')
Declare @path varchar(500) = (select (log_file_path)  + 'Backup\*.sqlaudit' from master.sys.server_file_audits where name ='AllLoginsAudit')
--Print 'Network Path to logfile(s) ' + @netpath
--Print 'Local Path to logfile(s) ' + @path
INSERT INTO DataServices.dbo.dbaloginAudit
SELECT * FROM fn_get_audit_file(@path, default, default)  
order by event_time desc

