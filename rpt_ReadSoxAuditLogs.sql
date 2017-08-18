alter procedure [dbo].[rpt_ReadSoxAuditLogs]
( 
@startdate date
)
as
begin

declare @cnt int, @numgroups int, @groupacct varchar(255)
, @account_name varchar(255), @type varchar(50), @privilege varchar(50)
, @mapped_login_name varchar(255), @permission_path varchar(255)
, @auditfile varchar(max), @enddate date

set @cnt = 0 
set @enddate = dateadd(d, 1, @startdate)

declare @alllogins table 
( loginname varchar(255), isntgroup int)

declare @grouplogins table
( account_name varchar(255), [type] varchar(50), privilege varchar(50), mapped_login_name varchar(255), permission_path varchar(255) )

insert into @alllogins
select p.name AS [loginname], isntgroup
from sys.server_principals p
join sys.syslogins s on p.sid = s.sid
where p.type_desc in ('sql_login', 'windows_login', 'windows_group')
-- logins that are not process logins
and (p.name not like '##%'
and p.name not like 'nt service%'
and p.name not like 'nt authority\system%')
-- logins that are sysadmins
and (s.sysadmin = 1 or s.serveradmin = 1 or s.securityadmin = 1
or s.setupadmin = 1 or s.processadmin = 1 or s.diskadmin = 1
or s.dbcreator = 1 or s.bulkadmin = 1)

declare c cursor for
select loginname from @alllogins where isntgroup = 1

open c
fetch next from c 
into @groupacct

insert into @grouplogins
exec xp_logininfo @groupacct, 'members'
set @cnt = @cnt + 1

close c
deallocate c


select @auditfile= left(rtrim(audit_file_path),patindex('%\SoxAudit%', audit_file_path))
from sys.dm_server_audit_status
where name = 'soxaudit'

select server_principal_name, database_name, object_name,statement, event_time from sys.fn_get_audit_file (@auditfile + '*.sqlaudit',default,default)
where event_time between @startdate and @enddate
and server_principal_name in 
( select account_name as loginname
from @grouplogins
where (account_name <> 'kforce\sqlexec'
and account_name not like 'kforce\svc%')
union
select loginname 
from @alllogins 
where isntgroup <> 1 
and (loginname <> 'kforce\sqlexec'
and loginname not like 'kforce\svc%'))
order by event_time desc

end
