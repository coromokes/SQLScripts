--Use this script to identify constraints to drop 

--1) Modify where clause based on the field you need to remove
use rmqa
go
select o.id, o.name into #temp
  from dbo.syscolumns c
    inner join dbo.sysobjects o on o.id = c.id
  where c.name like '%fulldata%'

--2) Uses results from step 1 to limit result set
select 'alter table ' + (select oo.name from sysobjects oo where o.parent_obj = oo.id) + ' 
  drop constraint ' + o.name + '
go'
  from sysobjects o
  where name like 'df%'
    and exists (select 1
                  from #temp t
                  where t.id = o.parent_obj)
    and name like '%fulld%'