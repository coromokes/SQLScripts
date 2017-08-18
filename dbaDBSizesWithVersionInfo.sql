SELECT d.name,
ROUND(SUM(cast(mf.size as bigint)) * 8 / 1024, 0) Size_MBs
,(select SERVERPROPERTY('productversion')) as SQLVersion
,(select SERVERPROPERTY('Edition')) as SQLEdition
,(select ServerProperty('ProductLevel')) as ProductLevel
,CASE WHEN LEFT(CAST(serverproperty('productversion') as char), 1) = 9 THEN 'Microsoft SQL Server 2005'
 WHEN LEFT(CAST(serverproperty('productversion') as char), 4) = 10.0 THEN 'Microsoft SQL Server 2008'
 WHEN LEFT(CAST(serverproperty('productversion') as char), 4) = 10.5 THEN 'Microsoft SQL Server 2008 R2'
 WHEN LEFT(CAST(serverproperty('productversion') as char), 2) = 11 THEN 'Microsoft SQL Server 2012'
 WHEN LEFT(CAST(serverproperty('productversion') as char), 2) = 12 THEN 'Microsoft SQL Server 2014'
END AS MajorVersion
FROM sys.master_files mf
INNER JOIN sys.databases d ON d.database_id = mf.database_id
WHERE d.database_id > 4 -- Skip system databases
GROUP BY d.name
ORDER BY d.name


