SELECT d.name,
ROUND(SUM(cast(mf.size as bigint)) * 8 / 1024, 0) Size_MBs,
@@version as SQLVersion
FROM sys.master_files mf
INNER JOIN sys.databases d ON d.database_id = mf.database_id
WHERE d.database_id > 4 -- Skip system databases
GROUP BY d.name
ORDER BY d.name