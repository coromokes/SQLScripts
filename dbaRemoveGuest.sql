sp_configure 'allow updates',1
reconfigure with override
go

update sysusers
    set sid = 0x00
  where name = 'guest'
go

sp_configure 'allow updates',1
reconfigure with override
go
