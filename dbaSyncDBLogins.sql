
sp_configure 'allow updates',1
reconfigure with override
go

update u
    set u.sid = l.sid
  from sysusers u with (nolock) 
    inner join master..syslogins l with (nolock) on right(l.name,(len(l.name) - charindex('\',l.name, 1))) collate database_default = u.name collate database_default
  where l.name like '%\%'
go
update u
    set u.sid = l.sid
  from sysusers u with (nolock)
    inner join master..syslogins l with (nolock) on l.name = u.name collate database_default
go
update u
    set u.sid = (select sid from master..syslogins where name = 'sa')
  from sysusers u
  where u.name = 'dbo'
go
sp_configure 'allow updates',0
reconfigure with override
go

