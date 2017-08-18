--works in sql 2008
SELECT OBJECT_NAME([table_id]) AS TableName, COUNT([fragment_id]) AS Fragments
FROM sys.fulltext_index_fragments
GROUP BY OBJECT_NAME([table_id])
HAVING COUNT([fragment_id]) >=0

