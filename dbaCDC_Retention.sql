SELECT [retention], retention/60 [hrs], (retention/60)/24 [days]
  FROM [msdb].[dbo].[cdc_jobs]
  WHERE [database_id] = DB_ID('rmprod')
  AND [job_type] = 'cleanup'
  
