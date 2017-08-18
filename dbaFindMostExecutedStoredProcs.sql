SELECT 
    DatabaseName        = DB_NAME(st.dbid)  
    ,SchemaName         = OBJECT_SCHEMA_NAME(st.objectid,dbid)  
    ,StoredProcedure    = OBJECT_NAME(st.objectid,dbid)  
    ,ExecutionCount     = MAX(cp.usecounts)  
FROM sys.dm_exec_cached_plans cp  
CROSS APPLY sys.dm_exec_sql_text(cp.plan_handle) st  
WHERE DB_NAME(st.dbid) IS NOT NULL 
AND cp.objtype = 'proc' 
GROUP BY 
    cp.plan_handle  
    ,DB_NAME(st.dbid)  
    ,OBJECT_SCHEMA_NAME(objectid,st.dbid)  
    ,OBJECT_NAME(objectid,st.dbid)  
ORDER BY MAX(cp.usecounts) DESC 

