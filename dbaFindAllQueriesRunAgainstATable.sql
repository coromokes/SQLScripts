/*
Find All Queries Run Against a Table
Posted by Derek Dieter
on  June 26 2009 
This script will show you all the queries that have run against a particular table since the last time SQL Server was rebooted. 
This query is good in helping to define indexes. 

!!!!!!!!!!!   This only works against SQL 2008. !!!!!!!!!!!!

*/

SELECT DISTINCT TOP 1000  
    ProcedureName       = OBJECT_SCHEMA_NAME(qt.objectid) + '.' + OBJECT_NAME(qt.objectid)  
    ,SQLStatement       = SUBSTRING(  
                                    qt.Text  
                                    ,(qs.statement_start_offset/2)+1  
                                    ,CASE qs.statement_end_offset  
                                    WHEN -1 THEN DATALENGTH(qt.text)  
                                    ELSE qs.statement_end_offset  
                                    END - (qs.statement_start_offset/2) + 1  
                                    )  
    ,DiskReads          = qs.total_physical_reads   -- The worst reads, disk reads  
    ,MemoryReads        = qs.total_logical_reads    --Logical Reads are memory reads  
    ,ExecutionCount     = qs.execution_count  
    ,CPUTime            = qs.total_worker_time  
    ,DiskWaitAndCPUTime = qs.total_elapsed_time  
    ,MemoryWrites       = qs.max_logical_writes  
    ,DateCached         = qs.creation_time  
    ,DatabaseName       = DB_Name(qt.dbid)  
    ,LastExecutionTime  = qs.last_execution_time  
    --,sre.*  
FROM sys.dm_exec_query_stats AS qs  
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) AS qt  
CROSS APPLY sys.dm_sql_referenced_entities(  
        OBJECT_SCHEMA_NAME(qt.objectid) + '.' + OBJECT_NAME(qt.objectid)  
        , 'OBJECT' 
    ) sre  
WHERE qt.dbid = db_id() -- Filter by current database  
AND sre.referenced_schema_name + '.' + sre.referenced_entity_name = 'dbo.Candidates' 
