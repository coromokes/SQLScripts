select 'backup database ' + name + ' to disk = ''\\sta0niw-sqcn20\Backup\' + name + '.bak'' with stats
go'
  from sys.databases
  where database_id > 4
  

  backup log CRM_Extract to disk = 'c:\ClusterStorage\CSV_SysData01\STA0NIW-SQCN19\CRM_Extract.trn' with stats  
  go