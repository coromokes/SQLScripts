/* msb

Note	This script creates a log table and records the tablename and record count

Used this for determining fill factor and growth on all wizard tables

!!!! ***** Look at research section for queries **** !!!!!

*/

use dataservices
go
create table dbaTableLog
(
  TableName varchar(255),
  RecordCount int,
  DateCreated datetime default(getdate())
) on DBA

insert into dataservices.dbo.dbaTableLog ( TableName, RecordCount)
select name = convert(char(30), o.name), rows
  from wizard.dbo.sysindexes i
    inner join wizard.dbo.sysobjects o on o.id = i.id
  where o.type = 'u'  
    and (indid = 0 or indid = 1)
    and o.name not like 'dt%'
    and o.name not like '%trace%'
    and o.name not like 'sys%'
    and o.name not like 'ms%'
  order by rows desc


--Research:

select *
from dataservices.dbo.dbaTableLog a
where tablename = 'EMP_BENEFIT'
order by datecreated 

--Static tables
select a.tablename, max(recordcount)-min(recordcount)
  from dataservices.dbo.dbaTableLog a
  group by a.tablename
  having (max(recordcount)-min(recordcount)) = 0
  order by a.tablename

--Growing tables
select a.tablename, max(recordcount)-min(recordcount)
  from dataservices.dbo.dbaTableLog a
  group by a.tablename
  having max(recordcount)-min(recordcount) > 0
  order by 2 desc

--After gathering growth statistics I used the following to update the fillfactor accordingly
  select *
    from dataservices.dbo.dbaReIndexLog r
    where exists  (select t.tablename--, max(recordcount)-min(recordcount)
                    from dataservices.dbo.dbaTableLog t
                    where t.tablename = r.tablename
                    group by t.tablename
                    having (max(recordcount)-min(recordcount)) = 0)


--Update fillfactor to 100 for static tables
begin tran

  update r
      set [fillfactor] = 100
    from dataservices.dbo.dbaReIndexLog r
    where exists  (select t.tablename--, max(recordcount)-min(recordcount)
                    from dataservices.dbo.dbaTableLog t
                    where t.tablename = r.tablename
                    group by t.tablename
                    having (max(recordcount)-min(recordcount)) = 0)


commit

--Update fillfactor to 90 for growing tables (will be revisiting for correct fillfactor setting based on rowsize)
begin tran

  update dataservices.dbo.dbaReIndexLog 
      set [fillfactor] = 90
    where [fillfactor] is null

commit

