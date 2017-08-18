CREATE TABLE #Temp
 (TableName NVARCHAR(255), UserSeeks DEC, UserScans DEC, UserUpdates DEC)
 INSERT INTO #Temp
 EXEC sp_MSForEachDB 'USE [?]; IF DB_ID(''?'') > 4
 BEGIN
 SELECT DB_NAME() + ''.'' + object_name(b.object_id), a.user_seeks, a.user_scans, a.user_updates 
 FROM sys.dm_db_index_usage_stats a
 RIGHT OUTER JOIN [?].sys.indexes b on a.object_id = b.object_id and a.database_id = DB_ID()
 WHERE b.object_id > 100 
 END'
 
SELECT TableName as 'Table Name', sum(UserSeeks + UserScans + UserUpdates) as 'Total Accesses',
 sum(UserUpdates) as 'Total Writes', 
 CONVERT(DEC(25,2),(sum(UserUpdates)/sum(UserSeeks + UserScans + UserUpdates)*100)) as '% Accesses are Writes',
 sum(UserSeeks + UserScans) as 'Total Reads', 
 CONVERT(DEC(25,2),(sum(UserSeeks + UserScans)/sum(UserSeeks + UserScans + UserUpdates)*100)) as '% Accesses are Reads',
 SUM(UserSeeks) as 'Read Seeks', CONVERT(DEC(25,2),(SUM(UserSeeks)/sum(UserSeeks + UserScans)*100)) as '% Reads are Index Seeks', 
 SUM(UserScans) as 'Read Scans', CONVERT(DEC(25,2),(SUM(UserScans)/sum(UserSeeks + UserScans)*100)) as '% Reads are Index Scans'
 FROM #Temp
 GROUP by TableName
 HAVING sum(UserSeeks + UserScans) > 0
 ORDER by sum(UserSeeks + UserScans + UserUpdates) DESC
 DROP table #Temp
 --SQL Script end
 