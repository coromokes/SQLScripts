declare @dbname varchar(256), @restoreDate datetime
set @dbname = 'mobile'
set @restoreDate = GETDATE() - 5

select 'restore database ' + msdb.dbo.backupset.database_name + ' 
   from disk = ' + '''' + msdb.dbo.backupmediafamily.physical_device_name + '''' + '
 with stats, norecovery
 go'
 --,backup_finish_date
FROM   msdb.dbo.backupmediafamily  
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
   inner join (SELECT database_name, MAX(msdb.dbo.backupset.backup_finish_date) backup_finish_date
                FROM   msdb.dbo.backupmediafamily  
                INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
                WHERE  (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) 
                <= @restoreDate
                  and database_name = @dbname)--GETDATE() - 7)  
				  
  and msdb..backupset.type  = 'd'
  group by database_name ) x on x.database_name = msdb.dbo.backupset.database_name  and msdb.dbo.backupset.backup_finish_date = x.backup_finish_date
  where msdb..backupset.type  = 'D'
ORDER BY  
   msdb.dbo.backupset.database_name, 
   msdb.dbo.backupset.backup_finish_date asc
--union
SELECT  
'restore log ' + msdb.dbo.backupset.database_name + ' 
   from disk = ' + '''' + msdb.dbo.backupmediafamily.physical_device_name + '''' + '
 with stats, norecovery
 go'
 --, msdb.dbo.backupset.backup_finish_date 
FROM   msdb.dbo.backupmediafamily  
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
   inner join (SELECT database_name, MAX(msdb.dbo.backupset.backup_finish_date) backup_finish_date
                FROM   msdb.dbo.backupmediafamily  
                INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
                WHERE  (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) 
                <= @restoreDate
                  and database_name = @dbname)--GETDATE() - 7) 			  
  and msdb..backupset.type  = 'd'
  group by database_name ) x on x.database_name = msdb.dbo.backupset.database_name and msdb.dbo.backupset.backup_finish_date >= x.backup_finish_date
WHERE  --(CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - 7)  
   msdb..backupset.type  = 'L'

ORDER BY  
   msdb.dbo.backupset.database_name, 
   msdb.dbo.backupset.backup_finish_date asc
   

   select  msdb.dbo.backupmediafamily.physical_device_name 
 --,backup_finish_date
FROM   msdb.dbo.backupmediafamily  
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
   inner join (SELECT database_name, MAX(msdb.dbo.backupset.backup_finish_date) backup_finish_date
                FROM   msdb.dbo.backupmediafamily  
                INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
                WHERE  (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) <= '2016-09-26 11:00:00.000' and database_name = 'SPContentSales')--GETDATE() - 7)  
				  
  and msdb..backupset.type  = 'd'
  group by database_name ) x on x.database_name = msdb.dbo.backupset.database_name  and msdb.dbo.backupset.backup_finish_date = x.backup_finish_date
  where msdb..backupset.type  = 'D'
ORDER BY  
   msdb.dbo.backupset.database_name, 
   msdb.dbo.backupset.backup_finish_date asc
--union
SELECT   msdb.dbo.backupmediafamily.physical_device_name 
 --, msdb.dbo.backupset.backup_finish_date 
FROM   msdb.dbo.backupmediafamily  
   INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
   inner join (SELECT database_name, MAX(msdb.dbo.backupset.backup_finish_date) backup_finish_date
                FROM   msdb.dbo.backupmediafamily  
                INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id 
                WHERE  (CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) <= '2016-09-26 11:00:00.000' and database_name = 'SPContentSales')--GETDATE() - 7)  				  
  and msdb..backupset.type  = 'd'
  group by database_name ) x on x.database_name = msdb.dbo.backupset.database_name and msdb.dbo.backupset.backup_finish_date >= x.backup_finish_date
WHERE  --(CONVERT(datetime, msdb.dbo.backupset.backup_start_date, 102) >= GETDATE() - 7)  
   msdb..backupset.type  = 'L'

ORDER BY  
   msdb.dbo.backupset.database_name, 
   msdb.dbo.backupset.backup_finish_date asc
