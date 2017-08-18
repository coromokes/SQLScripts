use ifw;
SELECT sqlserver_start_time AS LASTRESTARTDATE FROM sys.dm_os_sys_info

DECLARE @dbid int
SELECT @dbid = db_id('ifw')

declare @PageSize float 
select @PageSize=v.low/1024.0 from master.dbo.spt_values v where v.number=1 and v.type='E'

SELECT SCHEMA_NAME(tbl.schema_id) as [Schema], TBL.NAME,
--tbl.*, idx.index_id,
 --CAST(CASE idx.index_id WHEN 1 THEN 1 ELSE 0 END AS bit) AS [HasClusteredIndex],
 ISNULL( ( select sum (spart.rows) from sys.partitions spart where spart.object_id = tbl.object_id and spart.index_id < 2), 0) AS [RowCount],
 ISNULL((select @PageSize 
	* SUM(a.used_pages - CASE WHEN a.type <> 1 THEN a.used_pages WHEN p.index_id < 2 THEN a.data_pages ELSE 0 END) 
		FROM sys.indexes as i
		 JOIN sys.partitions as p ON p.object_id = i.object_id and p.index_id = i.index_id
		 JOIN sys.allocation_units as a ON a.container_id = p.partition_id
		where i.object_id = tbl.object_id  )
	, 0.0) AS [IndexSpaceUsed]

, ISNULL((select @PageSize 
	* SUM(CASE WHEN a.type <> 1 THEN a.used_pages WHEN p.index_id < 2 THEN a.data_pages ELSE 0 END) 
		FROM sys.indexes as i
		 JOIN sys.partitions as p ON p.object_id = i.object_id and p.index_id = i.index_id
		 JOIN sys.allocation_units as a ON a.container_id = p.partition_id
		where i.object_id = tbl.object_id)
	, 0.0) AS [DataSpaceUsed]
	, X.READS,X.WRITES
FROM sys.tables AS tbl
 INNER JOIN sys.indexes AS idx ON idx.object_id = tbl.object_id and idx.index_id < 2
 INNER JOIN (SELECT TableName = object_name(s.object_id),
       Reads = SUM(user_seeks + user_scans + user_lookups), Writes =  SUM(user_updates)	   
FROM sys.dm_db_index_usage_stats AS s
INNER JOIN sys.indexes AS i
ON s.object_id = i.object_id
AND i.index_id = s.index_id
WHERE objectproperty(s.object_id,'IsUserTable') = 1
AND s.database_id = @dbid
GROUP BY object_name(s.object_id)
)  X ON X.TableName = TBL.NAME