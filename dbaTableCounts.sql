/* msb

Note	Determines how many records each table has in the specified database

*/

SELECT sc.name +'.'+ ta.name TableName
 ,SUM(pa.rows) AS CountRows
 FROM sys.tables ta
 INNER JOIN sys.partitions pa
 ON pa.OBJECT_ID = ta.OBJECT_ID
 INNER JOIN sys.schemas sc
 ON ta.schema_id = sc.schema_id
 WHERE ta.is_ms_shipped = 0 AND pa.index_id <2
 GROUP BY sc.name,ta.name
 order by sum(pa.rows) desc