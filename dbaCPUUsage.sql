/* msb

Note	Determines most cpu intensive processes

*/


drop table cpu_usage
go
select 
    cpu, spid into cpu_usage
  from master..sysprocesses 
go
select 
    difference = p.cpu - u.cpu,
    cast(p.cpu as int), p.program_name, p.loginame,
    p.spid, p.hostname, p.last_batch
  from master..sysprocesses p 
    inner join cpu_usage u on p.spid = u.spid
  order by 2 desc

  
  