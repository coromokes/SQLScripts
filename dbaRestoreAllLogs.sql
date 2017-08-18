select 'restore log ' + name + ' from disk = ''C:\ClusterStorage\CSV_Backup01\MSSQL10.PIVSSQ23\Backup\Logs\' + name + '.trn'' with stats, recovery
go'
  from sys.databases
  where database_id > 4

 
