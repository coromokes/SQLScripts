

   -- Get Top 20 executed SP's ordered by physical reads (read I/O pressure)
    SELECT TOP 20 qt.text AS 'SP Name', qs.total_physical_reads, qs.total_physical_reads/qs.execution_count AS 'Avg Physical Reads',
    qs.execution_count AS 'Execution Count',
    qs.execution_count/DATEDIFF(Second, qs.creation_time, GetDate()) AS 'Calls/Second',  
    qs.total_worker_time/qs.execution_count AS 'AvgWorkerTime',
    qs.total_worker_time AS 'TotalWorkerTime',
    qs.total_elapsed_time/qs.execution_count AS 'AvgElapsedTime',
    qs.max_logical_reads, qs.max_logical_writes,  
    DATEDIFF(Minute, qs.creation_time, GetDate()) AS 'Age in Cache', qt.dbid 
    FROM sys.dm_exec_query_stats AS qs
    CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt
    WHERE qt.dbid = db_id() -- Filter by current database
    ORDER BY qs.total_physical_reads DESC