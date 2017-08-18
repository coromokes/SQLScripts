--select 'alter database ' + name + ' set single_user with rollback immediate
--go
--exec sp_detach_db ' + name + '
--go'
--from sys.databases
--  where database_id > 4

declare @newlogdir varchar(1000), @newdatadir varchar(1000)

set @newlogdir = 'C:\ClusterStorage\CSV_Log02\MSSQL12.NIVSSQ20\MSSQL\Data\'
set @newdatadir = 'C:\ClusterStorage\CSV_Data02\MSSQL12.NIVSSQ20\MSSQL\Data\'

;
with c (database_id, Script, roword)
as
(select d.database_id, 'create database ' + name + '
on', 1
  from sys.databases d
  where d.database_id > 4
union all
select d.database_id, '(FILENAME = ' + '''' +  
    case 
      when type = 1 and isnull(@newlogdir,'') != '' then @newlogdir + right(physical_name,charindex('\',reverse(physical_name))-1)
      when type = 0 and isnull(@newdatadir,'') != '' then @newdatadir + right(physical_name,charindex('\',reverse(physical_name))-1)
      else physical_name
    end
+ '''' +
case when file_id = (select max(file_id) from sys.master_files mf2 where mf2.database_id = mf.database_id) then ') 
FOR ATTACH
go' else '), ' end, 2
  from sys.master_files mf 
    inner join sys.databases d on mf.database_id = d.database_id
  where d.database_id > 4

)
select script from c
order by database_id, roword