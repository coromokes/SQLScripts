-- Kills all users in specified database
declare @spid int
declare @sql nvarchar(50)

declare cr_procs cursor 
for 
  select spid
    from master.dbo.sysprocesses a with (nolock)
      inner join master.dbo.sysdatabases d with (nolock) on a.dbid = d.dbid
  where loginame = 'rmuser'
    
open cr_procs
fetch   cr_procs into @spid

while (@@fetch_status=0)
  begin
    select @sql = 'kill ' + convert(varchar, @spid)

	exec sp_executesql @sql

	fetch cr_procs into @spid
  end

close cr_procs
deallocate cr_procs

