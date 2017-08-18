declare @auditfile varchar(max)

select @auditfile=left(rtrim(audit_file_path),patindex('%\soxaudit%', audit_file_path))
--select *, left(rtrim(audit_file_path),patindex('%\SoxAudit%', audit_file_path))
 from sys.dm_server_audit_status
 where name = 'soxaudit'
select @auditfile

SELECT top 10 *--server_principal_name, database_name, object_name,statement, event_time 
FROM sys.fn_get_audit_file (@auditfile + '*.sqlaudit',default,default)
--where (statement like '%update%')
order by event_time desc

