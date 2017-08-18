declare @newlogdir varchar(1000), @newdatadir varchar(1000), @backupdir varchar(1000)

set @backupdir = '\\sta0nzw-sqcn04\d$\sqldata\DATA\'
set @newdatadir = 'I:\MSSQL10_50.PZVSSQ03\MSSQL\DATA\'
set @newlogdir = 'J:\MSSQL10_50.PZVSSQ03\MSSQL\Data\'
--set @newlogdir = 'Q:\Q_RMax2_Logs\MSSQL10_50.PIVSSQ09\MSSQL\Data\'
--set @newdatadir = 'Q:\Q_RMax2_Data\MSSQL10_50.PIVSSQ09\MSSQL\Data\'
  
  
;
with c (database_id, Script, roword)
as
(select d.database_id, 'restore database ' + name + ' from disk = ''' + @backupdir + name + '.bak' + ''' with  ', 1
  from sys.databases d
  where d.database_id > 4
    --and recovery_model_desc <> 'full'
union all
select d.database_id, 'move ' + '''' + mf.name + ''' to ''' + 
    case 
      when type = 1 and isnull(@newlogdir,'') != '' then @newlogdir + right(physical_name,charindex('\',reverse(physical_name))-1)
      when type = 0 and isnull(@newdatadir,'') != '' then @newdatadir + right(physical_name,charindex('\',reverse(physical_name))-1)
      else physical_name
    end
+ '''' +
case when file_id = (select max(file_id) from sys.master_files mf2 where mf2.database_id = mf.database_id) then ', norecovery, stats;
 ' else ', ' end, 2
  from sys.master_files mf 
    inner join sys.databases d on mf.database_id = d.database_id
	where d.database_id > 4
	  --and recovery_model_desc <> 'full'
)
select script from c
order by database_id, roword
