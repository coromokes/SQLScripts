USE fpmodsprod
GO
SELECT DISTINCT OBJECT_NAME(sis.OBJECT_ID) TableName, si.name AS IndexName, sc.Name AS ColumnName,
sic.Index_ID, sis.user_seeks, sis.user_scans, sis.user_lookups, sis.user_updates
FROM sys.dm_db_index_usage_stats sis
INNER JOIN sys.indexes si ON sis.OBJECT_ID = si.OBJECT_ID AND sis.Index_ID = si.Index_ID
INNER JOIN sys.index_columns sic ON sis.OBJECT_ID = sic.OBJECT_ID AND sic.Index_ID = si.Index_ID
INNER JOIN sys.columns sc ON sis.OBJECT_ID = sc.OBJECT_ID AND sic.Column_ID = sc.Column_ID
WHERE sis.Database_ID = DB_ID('fpmodsprod') AND sis.OBJECT_ID = OBJECT_ID('dbo.rm_users');
GO 