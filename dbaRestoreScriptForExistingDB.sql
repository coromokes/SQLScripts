declare @newlogdir varchar(1000), @newdatadir varchar(1000), 
  @backupdir varchar(1000), @dbname varchar(100), @newftdir varchar(1000)

set @backupdir = 'J:\SCOM_DATA_VOL\MSSQL\Backup\'
set @newlogdir = 'C:\ClusterStorage\CSV_Data01\MSSQL12.PIVSSQ20\MSSQL\Data\'
set @newdatadir = 'C:\ClusterStorage\CSV_Log01\MSSQL12.PIVSSQ20\MSSQL\Data\'
set @newftdir = 'K:\DB1_RMAXDATA_Vol\MSSQL\FTDATA\'
set @dbname = 'ePOCSR'
--[ePOCSR]
;
with c (database_id, Script, roword)
as
(select d.database_id, 'restore database ' + name + ' from disk = ''' + @backupdir + name + '.bak' + ''' with  ', 1
  from sys.databases d
  where d.name = @dbname
union all
select d.database_id, 'move ' + '''' + mf.name + ''' to ''' + 
    case 
      when type = 4 and isnull(@newftdir,'') != '' then @newftdir + right(physical_name,charindex('\',reverse(physical_name))-1)
      when type = 1 and isnull(@newlogdir,'') != '' then @newlogdir + right(physical_name,charindex('\',reverse(physical_name))-1)
      when type = 0 and isnull(@newdatadir,'') != '' then @newdatadir + right(physical_name,charindex('\',reverse(physical_name))-1)      
      else physical_name
    end
+ '''' +
case when file_id = (select max(file_id) from sys.master_files mf2 where mf2.database_id = mf.database_id) then ', stats; ' else ', ' end, 2
  from sys.master_files mf 
    inner join sys.databases d on mf.database_id = d.database_id
  where d.name = @dbname

)
select script from c
order by database_id, roword

