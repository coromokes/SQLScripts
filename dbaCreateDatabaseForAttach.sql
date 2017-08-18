-- CREATE DATABASE [RmDev] 
-- ON (FILENAME ='c:\test.mdf' ), 
-- (FILENAME= 'c:\test.ldf' ), (FILENAME= 'c:\test3.ndf' ), 
-- (FILENAME= 'c:\test2.ndf' ) 
-- FOR ATTACH

select 'create database ' + db_name() + '
on', 1
union
select '(FILENAME = ' + '''' + 
    rtrim(filename) + '''' + '),', 2
  from sysfiles with(nolock)
union
select 'FOR ATTACH', 3
order by 2

