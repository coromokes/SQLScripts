SELECT j.name, CAST(s.active_start_time / 10000 AS VARCHAR(10))   
+ ':' + RIGHT('00' + CAST(s.active_start_time % 10000 / 100 AS VARCHAR(10)), 2) AS active_start_time,   
dbo.udf_schedule_description(s.freq_type, 
s.freq_interval,  
s.freq_subday_type, 
s.freq_subday_interval, 
s.freq_relative_interval,  
s.freq_recurrence_factor, 
s.active_start_date, 
s.active_end_date,  
s.active_start_time, 
s.active_end_time) AS ScheduleDscr,
jst.step_name,
jst.command, jst.subsystem
, case 
  when subsystem = 'tsql' and command like '%_%' then 
  (select top 1 TEXT from rmprod.dbo.syscomments c 
    inner join rmprod.dbo.sysobjects o on o.id = c.id 
    where o.name = jst.step_name)
  else ''
  end as 'StoredProcSQL'
FROM sysjobs j 
 INNER JOIN sysjobschedules js ON j.job_id = js.job_id 
INNER JOIN sysschedules s ON s.schedule_id = js.schedule_id  
inner join syscategories c on c.category_id = j.category_id
inner join sysjobsteps jst on jst.job_id = j.job_id
 where c.name = 'ecs - prod'
 --where (c.name = 'rm ssis packages - prod' or c.name like 'tidal%') and (j.name like 'rm%')
   --and j.name not like 'rm_olap%'

   and j.enabled = 1




--select * from sysjobsteps
--where subsystem = 'ssis'


