SELECT 'CREATE ' +
CASE IS_UNIQUE WHEN 1 THEN 'UNIQUE ' ELSE ' ' END +
'NONCLUSTERED ' + ' INDEX '+
NAME + ' ' +' ON ' +
OBJECT_NAME (OBJECT_ID) +
'('+
DBO.fddl_GetIndexCols (object_NAME(OBJECT_ID), index_id) +
')'+
' ON ['+
( SELECT GROUPNAME
FROM SYSFILEGROUPS
WHERE GROUPID = DATA_SPACE_ID
) + ']' IndexScript
FROM SYS.INDEXES
WHERE NAME IS NOT NULL
AND Is_Primary_Key =0
AND type_desc ='NONCLUSTERED'
AND OBJECT_ID > 97

