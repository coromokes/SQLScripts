
 CREATE TABLE #DirTree (
    Id int identity(1,1),
    SubDirectory nvarchar(255),
    Depth smallint,
    FileFlag bit,
    ParentDirectoryID int
   )

   INSERT INTO #DirTree (SubDirectory, Depth, FileFlag)
    EXEC xp_dirtree '\\corpserv\groups\CIS\Data Services\SQL Server\Scripts\mbrown\DMV\sql_Scripts', 10, 1

--select SubDirectory 
select 'sqlcmd -S nivssq20\nivssq20 -E -s, -W -i ' + '"' + '\\corpserv\groups\CIS\Data Services\SQL Server\Scripts\mbrown\DMV\sql_Scripts\' + subdirectory + '"' + ' > ' + 
+ '"' + '\\corpserv\groups\CIS\Data Services\SQL Server\Scripts\mbrown\DMV\sql_Scripts\' + subdirectory  + '.csv' + '"'
from #dirtree
where SubDirectory like '%.sql'

drop table #dirtree