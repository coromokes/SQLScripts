DECLARE @dbid int
SELECT @dbid = db_id('rmprod')

SELECT TableName = object_name(s.object_id),
       Reads = SUM(user_seeks + user_scans + user_lookups), Writes =  SUM(user_updates)
	   --,	   CAST(SUM(user_updates) AS FLOAT)/cast(SUM(user_seeks + user_scans + user_lookups) AS FLOAT)
FROM sys.dm_db_index_usage_stats AS s
INNER JOIN sys.indexes AS i
ON s.object_id = i.object_id
AND i.index_id = s.index_id
WHERE objectproperty(s.object_id,'IsUserTable') = 1
AND s.database_id = @dbid
GROUP BY object_name(s.object_id)
ORDER BY writes DESC