use rmprod
go
SELECT t.name AS TableName, fc.name AS FTCatalogName, c.name as columnName
FROM sys.tables t JOIN sys.fulltext_indexes i ON t.object_id = i.object_id
inner join sys.fulltext_catalogs fc ON i.fulltext_catalog_id = fc.fulltext_catalog_id
 inner join sys.fulltext_index_columns fic on fic.object_id = i.object_id
 inner join sys.columns c on c.object_id = i.object_id and c.column_id = fic.column_id
 
