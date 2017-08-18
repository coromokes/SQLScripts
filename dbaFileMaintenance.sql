select name, 'alter database ' + db_name(database_id) + ' add file (name= ' 
+ replace(replacE(replace(replace(replace(name,'04','07'),'02','04'),'03','04'),'01','07'),'05','07') + ', size=256MB,filegrowth=256MB,
filename= ' + '''' + 'C:\ClusterStorage\CSV_Data02\MSSQL12.PIVSSQ21\MSSQL\Data\' 
+ replace(replacE(replace(replace(replace(name,'04','07'),'02','04'),'03','04'),'01','07'),'05','07') + '.ndf' + '''' + ')'
,'alter database ' + db_name(database_id) + ' modify file (name= ' + name + ', filegrowth=0)'

--select  *
  from sys.master_files
    where type_desc <> 'log'
	  and size >= 960000
	  --and growth <> 0
	  and physical_name like 'C:\ClusterStorage\CSV_Data01\%'
  order by size desc

