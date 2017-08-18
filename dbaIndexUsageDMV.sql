/*
•User Seeks – A high number indicates a well utilized index.
•User Scans – Number of times the index has been scanned. Could indicate improper ordering of the composite columns
•User Lookups – Indicates a different index was used for criteria and the actual data was looked up from this index for the select list
•User Updates – Number of times the index was updated with additional records
*/

SELECT 
    ObjectName      = object_schema_name(idx.object_id) + '.' + object_name(idx.object_id)  
    ,IndexName      = idx.name 
    ,IndexType      = CASE 
                        WHEN is_unique = 1 THEN 'UNIQUE ' 
                        ELSE '' END + idx.type_desc  
    ,User_Seeks     = us.user_seeks  
    ,User_Scans     = us.user_scans  
    ,User_Lookups   = us.user_lookups  
    ,User_Updates   = us.user_updates 
	, us.last_user_seek
	, us.last_user_scan
	, us.last_user_lookup
FROM sys.indexes idx  
LEFT JOIN sys.dm_db_index_usage_stats us  
    ON idx.object_id = us.object_id  
    AND idx.index_id = us.index_id  
    AND us.database_id = db_id()  
WHERE object_schema_name(idx.object_id) != 'sys' 
--and object_name(us.object_id) = 'FS_PS_RI_REV_FACT_TBL'
--dbo.FS_PS_RI_REV_FACT_TBL.ixFS_PS_RI_REV_FACT_TBL_RI_ACCTG_PD_ENDDT (6)
and us.user_seeks   = 0
and us.user_scans = 0
and us.user_lookups = 0
ORDER BY us.user_seeks + us.user_scans + us.user_lookups DESC 
--order by user_scans desc
--order by user_updates desc




