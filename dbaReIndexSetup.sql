/* msb

sets up reindexing for dbaReindexlog table

*/

use dataservices
go 
create table dbaReIndexLog
(
  ReIndexID int identity(1,1),
  TableName varchar(255),
  Records int,
  RebuildOn int,
  RebuildStart datetime,
  RebuildEnd datetime
) on dba


insert into dataservices.dbo.dbaReIndexLog(tablename,records)
select name = convert(char(30), o.name), rows
  from rmprod.dbo.sysindexes i
    inner join rmprod.dbo.sysobjects o on o.id = i.id
  where o.type = 'u'  
    and (indid = 0 or indid = 1)
    and o.name not like 'dt%'
    and o.name not like '%trace%'
    and o.name not like 'sys%'
    and o.name not like 'ms%'
  order by rows desc


declare @max int
declare @min int
declare @i int
declare @day char(3)

set @day = 1

select
    @max=max(reindexid),
    @min=min(reindexid)
  from dbaReIndexLog

set @i = @min

while @i <= @max
  begin
    
    update dbareindexlog
        set rebuildon = @day
      where reindexid = @i

    if @day < 7 
      begin
        select @day = @day + 1    
      end
    else if @day = 7
      begin
        select @day = 1
      end
    
    select @i = @i + 1

  end

select *
  from dbaReindexlog

update dbaReindexlog
  set RebuildStart = null,
  RebuildEnd = null

-- set smaller tables fillfactor to 100
update r
    set [fillfactor] = 100
  from dbaReindexlog r
  where exists (select convert(char(30), o.name) as namex, rows, PseudoTable = o.sysstat & 1024 , o.type
                  from rmprod.dbo.sysindexes i
                    inner join rmprod.dbo.sysobjects o on o.id = i.id
                  where o.type = 'u' --o.id < 100 
                    and (indid = 0 or indid = 1)
                    and o.name = r.TableName)
    and Records < 200
