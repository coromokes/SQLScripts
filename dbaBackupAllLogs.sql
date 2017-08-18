select 'backup log ' + name + ' to disk = ''\\sta0-ddom01.kforce.com\prodsqlrefresh\MSSQL10.PIVSSQ08\Backup\' + name + '_last.trn'' with stats
go'
  from sys.databases
  where database_id > 4

/*
select 'backup log ' + name + ' to disk = ''\\sta0-ddom01.kforce.com\prodsqlrefresh\MSSQL10.PIVSSQ08\Backup\' + name + '_last.trn'' with stats
go'
  from sys.databases
  where database_id > 4

  
*/