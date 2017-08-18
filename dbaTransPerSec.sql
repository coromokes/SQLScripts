DECLARE @ctr bigint
SELECT @ctr = cntr_value
    FROM sys.dm_os_performance_counters 
    WHERE counter_name = 'transactions/sec' 
        AND object_name = 'MSSQL$PZVSSQ03:Databases' 
        AND instance_name = 'TE'
WAITFOR DELAY '00:00:01'

SELECT cntr_value - @ctr 
    FROM sys.dm_os_performance_counters 
    WHERE counter_name = 'transactions/sec' 
        AND object_name = 'MSSQL$PZVSSQ03:Databases' 
        AND instance_name = 'TE'

--select * FROM sys.dm_os_performance_counters where counter_name = 'transactions/sec' AND object_name = 'MSSQL$PZVSSQ03:Databases' 

--select * FROM sys.dm_os_performance_counters where counter_name like '%physical%'