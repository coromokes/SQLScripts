SELECT 
    TEXT  
    ,query_plan  
    ,requested_memory_kb  
    ,granted_memory_kb  
    ,used_memory_kb  
FROM sys.dm_exec_query_memory_grants emg  
CROSS APPLY sys.dm_exec_sql_text(sql_handle)  
CROSS APPLY sys.dm_exec_query_plan(emg.plan_handle)  
ORDER BY emg.requested_memory_kb DESC 
