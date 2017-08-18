--Used to see if there are duplicate indexes
--drop table #temp
create table #temp
(
  index_name varchar(1000),
  index_description varchar(100),
  index_keys varchar(6000),
  table_name varchar(255)
)

  
declare @table varchar(100)
declare c cursor for
select name 
  from sysobjects o
  where type = 'u'
    and name not like 'dt_%'

open c 
fetch c into @table

while @@fetch_status = 0
  begin
    insert into #temp (index_name, index_description, index_keys)
    exec sp_helpindex @table
    
    update #temp
        set table_name = @table
      where table_name is null

    fetch c into @table
  end

close c
deallocate c


select cast(index_keys as char(50)), table_name, count(*)
  from #temp a
  group by index_keys, table_name
  having count(*) > 1

--drop table #temp

select *
  from #temp
  where index_keys = 'UserName'
  
drop index timecard.Timecard_Queue_IDX
go

  LoweredApplicationName                            
OrderCandidateIdAltKey                            
MessageID                                         
TimecardID, CompleteDate                          
RejectReasonID                                    
QueueItemID                                       
UserName                                          

