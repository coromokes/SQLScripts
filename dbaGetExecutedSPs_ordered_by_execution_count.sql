    -- Get Top 100 executed SP's ordered by execution count
    SELECT OBJECT_NAME(objectid) ObjectName, qs.execution_count AS 'Execution Count',  
    qs.execution_count/DATEDIFF(Second, qs.creation_time, GetDate()) AS 'Calls/Second',
    qs.total_worker_time/qs.execution_count AS 'AvgWorkerTime',
    qs.total_worker_time AS 'TotalWorkerTime',
    qs.total_elapsed_time/qs.execution_count AS 'AvgElapsedTime',
    qs.max_logical_reads, qs.max_logical_writes, qs.total_physical_reads, 
    DATEDIFF(Minute, qs.creation_time, GetDate()) AS 'Age in Cache'
	--qt.text AS 'SP Name'
    FROM sys.dm_exec_query_stats AS qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
    WHERE qt.dbid = db_id() -- Filter by current database
	--group by OBJECT_NAME(objectid)
    ORDER BY qs.execution_count DESC

