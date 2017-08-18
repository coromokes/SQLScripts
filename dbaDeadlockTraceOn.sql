--Deadlock tracing
dbcc traceon (-1,3605)
dbcc traceon (-1,1204)
dbcc traceon (-1,1205) 
dbcc traceon (-1,1222)

--All active traces
DBCC TRACESTATUS(-1)

--Off
dbcc traceoff (-1,3605)
dbcc traceoff (-1,1204)
dbcc traceoff (-1,1205) 
dbcc traceoff (-1,1222)

--enable for sql profiler deadlock trace
EXEC sp_configure 'blocked process threshold', 0
GO
RECONFIGURE
GO

--xp_readerrorlog
--sp_cycle_errorlog

sp_configure