select 
    j.name, jh.message, jh.run_date, 
    jh.run_time, case run_status
                   when 0 then 'Failed'
                   when 1 then 'Succeeded'
                   when 2 then 'Retry'
                   when 3 then 'Canceled'
                   when 4 then 'In progress'
                 end as run_status,
  isnull((select name
     from msdb.dbo.sysoperators o 
     where o.id = jh.operator_id_emailed),'N/A') as operator_emailed,
  isnull((select name
     from msdb.dbo.sysoperators o 
     where o.id = jh.operator_id_paged),'N/A') as operator_paged
  from msdb.dbo.sysjobs j with (nolock)
   inner join msdb.dbo.sysjobhistory jh with (nolock) on j.job_id = jh.job_id
  where j.name = 'ps download mifcms'
    and jh.run_date >= '20040601'
  order by j.name, jh.run_date, jh.run_time


