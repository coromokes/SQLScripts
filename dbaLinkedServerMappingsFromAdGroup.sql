create table #temp
(
  [account name] varchar(100),
    [type] varchar(100),
	  [privilege] varchar(100),
	    [mapped login name] varchar(100),
		  [permission path] varchar(100)
		  )'
insert into #temp
exec xp_logininfo 'KFORCE\fpm project', 'members'

select 'EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname= ' + '''' + 'PIVSSQ19\PIVSSQ19' + '''' + ',@useself= ' + '''' + 'False' + '''' + ',@locallogin='  + '''' + [account name] + '''' + ' ,@rmtuser=N''read'',@rmtpassword=''Cuh4scxz''',
* 
from #temp

