select 'create database ' + db_name() + '_snap_' + convert(varchar,getdate(),112) + ' ON', 1 as ord
union
select 'AS SNAPSHOT OF ' + db_name(), 3
union
select '( name= ' + '''' + rtrim(name) + '''' + ', filename= ' + '''' + 
    replace(replace(rtrim(filename) + '''' + '),','ndf','ss'),'mdf','ss'), 2 as ord
   from sysfiles with (nolock)
   where groupid <> 0
   order by ord 





