SELECT  cntr_value AS NumOfDeadLocks, getdate()
  FROM sys.dm_os_performance_counters
 WHERE --object_name = 'SQLServer:Locks'
    counter_name = 'Number of Deadlocks/sec'
   AND instance_name = '_Total'
   
   

   --xp_readerrorlog

   --select * from sys.dm_os_sys_info