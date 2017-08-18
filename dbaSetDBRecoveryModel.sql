select 'alter database [' + name + '] set recovery full with no_wait
go'
  from sys.sysdatabases
  where name not in ('tempdb', 'master', 'msdb', 'model')


--alter database [ReportServer] set recovery simple with no_wait
--go
--alter database [ReportServerTempDB] set recovery simple with no_wait
--go
--alter database [STS_Config_TFS] set recovery simple with no_wait
--go
--alter database [STS_Content_TFS] set recovery simple with no_wait
--go
--alter database [TFS_ADMIN_STS] set recovery simple with no_wait
--go
--alter database [TfsActivityLogging] set recovery simple with no_wait
--go
--alter database [TfsBuild] set recovery simple with no_wait
--go
--alter database [TfsIntegration] set recovery simple with no_wait
--go
--alter database [TfsVersionControl] set recovery simple with no_wait
--go
--alter database [TFSWarehouse] set recovery simple with no_wait
--go
--alter database [TfsWorkItemTracking] set recovery simple with no_wait
--go
--alter database [TfsWorkItemTrackingAttachments] set recovery simple with no_wait
--go
