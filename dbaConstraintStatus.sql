--diabled
 SELECT name, tbl = object_name(parent_obj)
, 'alter table ' + object_name(parent_obj) + ' check constraint ' + name + '
go' 
FROM sysobjects
WHERE objectproperty(id, 'CnstIsDisabled') = 1

--enabled
SELECT name, tbl = object_name(parent_obj)
FROM sysobjects
WHERE objectproperty(id, 'CnstIsNotTrusted') = 1



