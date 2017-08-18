select 'exec msdb.dbo.sp_update_job @job_name = ''' + j.name + ''''
    + ', @notify_email_operator_name = ''DBA OnCall''
go'
  from msdb..sysjobs j
    inner join msdb..sysoperators o on j.notify_email_operator_id = o.id
  where o.name = 'mike brown'

select 'exec msdb.dbo.sp_update_job @job_name = ''' + j.name + ''''
    + ', @notify_page_operator_name = ''DBA OnCall''
go'
  from msdb..sysjobs j
    inner join msdb..sysoperators o on j.notify_page_operator_id = o.id
  where o.name = 'mike brown'


