
SELECT      command, percent_complete,
            'elapsed' = total_elapsed_time / 60000.0,
            'remaining' = estimated_completion_time / 60000.0
FROM        sys.dm_exec_requests

WHERE       command like 'BACKUP%'



select top 2 start_time,
 percent_complete ,estimated_completion_time 

 select *
 from sys.dm_exec_requests 
 WHERE       command like 'BACKUP%'
order by start_time desc

--sp_who2