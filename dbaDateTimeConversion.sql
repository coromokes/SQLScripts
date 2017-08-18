declare @today char(8)
declare @date datetime
declare @time char(6)
set @date = getdate()

select @today = cast(year(@date) as varchar)
  + right('00' + cast(month(@date) as varchar),2)
  + right('00' + cast(day(@date) as varchar),2),
  @time = cast(datepart(hh,@date) as varchar)
  + right('00' + cast(datepart(mi,@date) as varchar),2)
  + right('00' + cast(datepart(s,@date) as varchar),2)
select @today, @time