------------------------------------------------------------------------------------------- 
--Most Recent Database Backup for Each Database - Detailed 
------------------------------------------------------------------------------------------- 
SELECT  
   A.[Server],  
   A.last_db_backup_date,
   b.user_name, 
   B.database_name, 
   B.backup_start_date,  
   B.expiration_date, 
   B.backup_size,  
   B.logical_device_name,  
   B.physical_device_name,   
   B.backupset_name, 
   B.description
FROM 
   ( 
   SELECT   
       CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
       msdb.dbo.backupset.database_name,  
       MAX(msdb.dbo.backupset.backup_finish_date) AS last_db_backup_date 
   FROM    msdb.dbo.backupmediafamily  
       INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id  
   WHERE   msdb..backupset.type = 'D' 
   GROUP BY 
       msdb.dbo.backupset.database_name  
   ) AS A 
    
   LEFT JOIN  

   ( 
   SELECT   
   CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server, 
   bs.database_name,  
   bs.backup_start_date,  
   bs.backup_finish_date, 
   bs.expiration_date, 
   bs.backup_size,  
   bf.logical_device_name,  
   bf.physical_device_name,   
   bs.name AS backupset_name, 
   bs.description, bs.user_name 

FROM   msdb.dbo.backupmediafamily  bf
   INNER JOIN msdb.dbo.backupset bs ON bf.media_set_id = bs.media_set_id  
WHERE  bs.type = 'D' 
   ) AS B 
   ON A.[server] = B.[server] AND A.[database_name] = B.[database_name] AND A.[last_db_backup_date] = B.[backup_finish_date] 
ORDER BY  
   A.database_name 