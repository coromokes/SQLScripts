-- Script to update oncall schedule

select *
  from dbaoncallschedule
  where todate >= '2006-01-08'
  order by todate
-- 2006-01-08 --3
-- 2006-01-15 --2
-- 2006-01-22 --1
-- 2006-01-29 --5

declare @mydate datetime
set @mydate = '2006-01-29'

while @mydate < '2007-01-01'
begin
  update dbaoncallschedule
      set adminid = 5
    where todate = @mydate

  select @mydate = dateadd(d, 28, @mydate)

end



