/* msb 

Note	Script returns current process that is being executed and the curent statement with that batch


*/
declare @handle binary(20),
        @start int, 
        @end int,
        @spid int


--Find spid to research
select @spid=spid
  from master..sysprocesses with (nolock)
  where blocked = 0

--Manually set spid if necessary
set @spid = 56

select 
    @handle = sql_handle 
  from master.dbo.sysprocesses with (nolock)
  where spid = @spid

select * 
  from ::fn_get_sql(@handle) 

--Get the current statment that is executing with the procedure or statement
select
    @handle=sql_handle,
    @start=stmt_start,
    @end=stmt_end
  from master..sysprocesses with (nolock)
  where spid = @spid
    

if not exists(select 1 from ::fn_get_sql(@handle))
  begin
    print('Handle not found in cache')
  end

select
    'Current Statement'=substring(text,(@start + 2)/2,
    case @end
      when -1 then (datalength(text))
      else (@end - @start + 2)/2
      end)
  from ::fn_get_sql(@handle)

