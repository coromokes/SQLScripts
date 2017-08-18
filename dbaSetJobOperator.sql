/* msb

Note	Script to update all job operators for current server

*/

declare @jobid uniqueidentifier, @cnt int

set @cnt = 0

declare c cursor for
select job_id
  from msdb.dbo.sysjobs with (nolock)

open c 
fetch next from c into @jobid

while @@fetch_status = 0
  begin
    exec msdb.dbo.sp_update_job @job_id = @jobid, 
      @notify_email_operator_name = 'Mike Brown', 
      @notify_level_email = 2 -- Failure

    fetch next from c into @jobid
  end

close c
deallocate c


  


