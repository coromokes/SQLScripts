-- Script generated on 2/9/2001 12:02 PM
BEGIN TRANSACTION
  DECLARE @JobID BINARY(16)  
  DECLARE @ReturnCode INT
  SELECT @ReturnCode = 0
IF (SELECT COUNT(*) FROM msdb.dbo.syscategories WHERE name = N'[Uncategorized (Local)]') < 1 
  EXECUTE msdb.dbo.sp_add_category @name = N'[Uncategorized (Local)]'
IF (SELECT COUNT(*) FROM msdb.dbo.sysjobs WHERE name = N'ActivityTrace') > 0 
  PRINT N'The job "ActivityTrace" already exists so will not be replaced.'
ELSE
BEGIN 

  -- Add the job.
  EXECUTE @ReturnCode = msdb.dbo.sp_add_job @job_id = @JobID OUTPUT , @job_name = N'ActivityTrace', @owner_login_name = N'sa', @description = N'Trace performance and blocking.', @category_name = N'[Uncategorized (Local)]', @enabled = 1, @notify_level_email = 0, @notify_level_page = 0, @notify_level_netsend = 0, @notify_level_eventlog = 2, @delete_level= 0
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job steps.
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 1, @step_name = N'CreateIniFile', @command = N'-- create C:\ActivityTrace.ini file
declare @c nvarchar(256), @rc int, @i char(20)
set @i = ''C:\ActivityTrace.ini''
set @c = ''copy C:\ActivityTrace.ini C:\ActivityTrace.bak'' 
exec @rc = master.dbo.xp_cmdshell @c, no_output
if (@rc = 0) goto finish
set @c = ''echo @blockingcheck     = no > ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @performancecheck  = no >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @tracefile         = C:\ActivityTrace >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @maxfilesize       = 50 >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @minMBfree         = 200 >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @stoptime          = 2010-12-31 12:00:00.000 >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @options           = 2 >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @events            = 10,11,12,13,16,17,19,33,42,43,55,82,83 >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @columns           = 1,2,3,6,9,10,11,12,13,14,15,16,17,18,25 >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @filter1           = 10, 0, 7, N''''SQL Profiler'''' >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @filter2           = 10, 0, 7, N''''SQLAgent - Job Manager'''' >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @filter3           = 10, 0, 7, N''''SQLAgent - Alert Engine'''' >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @filter4           = 10, 0, 7, N''''SQLAgent - Generic Refresher'''' >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @filter5           = 3, 0, 1, 4 >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @job_name          = ActivityTrace >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @schedule00seconds = yes >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @schedule15seconds = no >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @schedule30seconds = no >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
set @c = ''echo @schedule45seconds = no >> ''+@i
exec master.dbo.xp_cmdshell @c, no_output
finish:
if exists (select * from dbo.sysobjects where id = object_id(N''[_t1]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
drop table [_t1]
create table _t1 ([c1] nvarchar(512))
exec (''bulk insert _t1 FROM ''''''+@i + '''''''')
', @database_name = N'master', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 2, @step_name = N'CreateTrace', @command = N'-- create trace
declare @p varchar(3), @b varchar(3), @traceid int, @options int, @tracefile nvarchar (245)
, @maxfilesize bigint, @stoptime datetime, @minMBfree bigint, @rc int, @on bit
, @cmd1 nvarchar(128), @mbfree bigint, @job_name sysname, @s sysname
select @p = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (3)) from _t1 where left(c1,3) =  ''@pe''
select @b = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (3)) from _t1 where left(c1,3) = ''@bl''
select @tracefile = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (245)) from _t1 where left(c1,3) = ''@tr''
select @maxfilesize = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as bigint) from _t1 where left(c1,3) = ''@ma''
select @minMBfree = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as bigint) from _t1 where left(c1,3) = ''@mi''
select @stoptime = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as datetime) from _t1 where left(c1,3) = ''@st''
select @options = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as int) from _t1 where left(c1,3) = ''@op''
select @job_name = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as sysname) from _t1 where left(c1,3) = ''@jo''
while (select count(*) from _t1 where left(c1,3) = ''@sc'') > 0
 begin
 select top 1 @s = cast(rtrim(ltrim(substring(c1,2,charindex(''='',c1,1)-2))) as sysname) 
 , @on = case upper(cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as varchar(3)))
 when ''YES'' then 1 else 0 end from _t1 where left(c1,3) = ''@sc''
 EXEC msdb.dbo.sp_update_jobschedule @job_name=@job_name, @name = @s, @enabled = @on
 delete _t1 where cast(rtrim(ltrim(substring(c1,2,charindex(''='',c1,1)-2))) as sysname)  = @s
 end
set @on = 1
set @traceid = 0
if @stoptime < getdate() goto stoptrace
set @cmd1 = ''dir '' + left(@tracefile,2) + '' | find "bytes free"''
insert into _t1 exec master.dbo.xp_cmdshell @cmd1
select @mbfree = cast(replace(substring(c1,charindex(''Dir'',c1)+6,charindex(''bytes free'',c1)
       -(charindex(''Dir'',c1)+6)),'','','''') as bigint)/1024/1024
  from _t1 where charindex(''bytes free'',c1) > 0
delete _t1 where left([c1],1) != ''@''
SELECT @traceid = traceid FROM :: fn_trace_getinfo(0) where property = 2 and value = @tracefile
if upper(@p) != ''YES'' and upper(@b) != ''YES'' goto stoptrace
if @traceid != 0 and @mbfree > @minMBfree goto finish
if @mbfree <= @minMBfree goto disable
if @traceid != 0 goto finish
set @cmd1 = ''if exist '' + @tracefile + ''.trc '' + ''del '' + @tracefile + ''*.trc''
exec @rc = master.dbo.xp_cmdshell @cmd1, no_output
if (@rc != 0) goto disable
exec @rc = sp_trace_create @traceid output, @options, @tracefile, @maxfilesize, @stoptime
if (@rc != 0) goto disable
goto finish
disable:
exec msdb.dbo.sp_update_job @job_name = @job_name, @enabled = 0
stoptrace:
exec sp_trace_setstatus @traceid, 0
exec sp_trace_setstatus @traceid, 2
finish:', @database_name = N'master', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 3, @step_name = N'SetEvents', @command = N'-- set trace events and filters
declare @traceid int, @tracefile  nvarchar (245), @rc int, @on bit, @cmd1 nvarchar(256)
, @events varchar(512), @columns varchar(512), @event int, @column int, @estart int, @enext int
, @cstart int, @cnext int, @le int, @lc int, @filter nvarchar(245), @filter_num int
set @on = 1
set @traceid = 0
select @tracefile = cast(ltrim(rtrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (245)) from _t1 where left(c1,3) = N''@tr''
select @events=cast(ltrim(rtrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (512)) from _t1 where left(c1,3) = N''@ev''
select @columns=cast(ltrim(rtrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (512)) from _t1 where left(c1,3) = N''@co''
SELECT @traceid = traceid FROM :: fn_trace_getinfo(0) where property = 2 and value = @tracefile
if @traceid = 0 goto finish
if (SELECT count(*) FROM ::fn_trace_geteventinfo(@traceid)) > 0 goto finish
select @estart = 1
select @enext = charindex('','',@events,@estart)
select @cstart = 1
select @cnext = charindex('','',@columns,@cstart)
set @le = len(@events)
set @lc = len(@columns)
while @enext > 0
 begin
 select @event = cast(substring(@events,@estart,@enext-@estart) as int)
 while @cnext > 0
  begin
  select @column = cast(substring(@columns,@cstart,@cnext-@cstart) as int)
  exec sp_trace_setevent @traceid, @event, @column, @on
  select @cstart = @cnext + 1
  select @cnext = charindex('','',@columns,@cstart)
  if @cnext = 0 set @cnext = @lc + 1
  if @cstart >@lc set @cnext = 0
  end
 select @cstart = 1
 select @cnext = charindex('','',@columns,@cstart)
 select @estart = @enext + 1
 select @enext = charindex('','',@events,@estart)
 if @enext = 0 set @enext = @le + 1
 if @estart > @le set @enext = 0
 end
set @cmd1 = ''exec sp_trace_setfilter '' 
set @filter = N''none''
select @filter = cast(ltrim(rtrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (245))
 from _t1
 where cast(ltrim(rtrim(substring(c1,1,charindex(''='',c1,1)-1))) as nvarchar (245)) = N''@filter1''
set @filter_num = 2
while @filter != N''none''
 begin
 exec (@cmd1 + @traceid + '',''+@filter)
 set @filter_num = @filter_num + 1
 set @filter = N''none''
 select @filter = cast(ltrim(rtrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (245)) from _t1
 where cast(ltrim(rtrim(substring(c1,1,charindex(''='',c1,1)-1))) as nvarchar (245)) = N''@filter'' + cast(@filter_num as nvarchar(3))
 select @filter
 end
finish:
exec sp_trace_setstatus @traceid, 1', @database_name = N'master', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 4, @step_name = N'blocking', @command = N'-- blocking check
declare @s table(id1 int identity, spid smallint, b smallint, d1 bit, ud binary(2540))
declare @ud binary(2540), @id int, @spid smallint, @c nvarchar(128), @b varchar(3), @rc int,@ui nvarchar(128)
select @b = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (3))
  from _t1 where left(c1,3) =  ''@bl''
if upper(@b) != ''YES'' goto finish
insert into @s select spid, blocked, 0
,cast(spid as binary(2))+cast(kpid as binary(2))+cast(blocked as binary(2))+waittype
+cast(waittime as binary(4))+cast(lastwaittype as binary(64))+cast(waitresource as binary(512))
+cast(dbid as binary(2))+cast(uid as binary(2))+cast(cpu as binary(4))
+cast(physical_io as binary(8))+cast([memusage] as binary(4))+cast(login_time as binary(8))
+cast(last_batch as binary(8)) +cast(ecid as binary(2))+cast(open_tran as binary(2))
+cast(status as binary(60))+cast(sid as binary(86))+cast(hostname as binary(256))
+cast(program_name as binary(256))+cast(hostprocess as binary(16))+cast(cmd as binary(32))
+cast(nt_domain as binary(256))+cast(nt_username as binary(256))+cast(net_address as binary(24))
+cast(net_library as binary(24))+cast(loginame as binary(256))+cast([context_info] as binary(128))
+cast(l.rsc_text as binary(64))+cast(rsc_bin as binary(16))+cast(rsc_valblk as binary(16))
+cast(rsc_dbid as binary(2))+cast(rsc_indid as binary(2))+cast(rsc_objid as binary(4))
+cast(rsc_type as binary(1))+cast(rsc_flag as binary(1)) +cast(req_mode as binary(1))
+cast(req_status as binary(1))+cast(req_refcnt as binary(2))+cast(req_cryrefcnt as binary(2))
+cast(req_lifetime as binary(4))+cast(req_spid as binary(4))+cast(req_ecid as binary(4))
+cast(req_ownertype as binary(2))+cast(req_transactionID as binary(8))
+cast(req_transactionUOW as binary(16))
 from master.dbo.sysprocesses p join master.dbo.syslockinfo l on p.spid = l.req_spid
 where (blocked != 0 or waittype != 0x0000) or (blocked = 0 and spid in
 (select blocked from master.dbo.sysprocesses where blocked != 0))
if (select top 1 count(*) from @s) < 1 exec sp_trace_generateevent  82,  N''no block''
else
begin
 update @s set d1 = 1 where b = 0 and spid in (select b from @s where b != 0)
 while (select top 1 count(*) from @s where d1 = 1) > 0
  begin
  select top 1 @spid = spid from @s where d1 = 1
  set @c = ''osql -S''+@@servername+'' -Q"dbcc traceon(3604) dbcc pss(0,''
         + cast(@spid as nvarchar(3))+ '')" -o C:\pss.txt -w128''
  exec @rc = master.dbo.xp_cmdshell @c, no_output
  if (@rc = 0) bulk insert _t1 FROM ''C:\pss.txt''
  delete _t1 where left([c1],2) = ''00''
  update @s set d1 = 0 where spid = @spid
  while (select top 1 count(*) from _t1 where left([c1],1) != ''@'') > 0
   begin
   select top 1 @ui = c1 from _t1 where left([c1],1) != ''@''
   exec sp_trace_generateevent 82, @ui
   delete _t1 where left(c1,5) = left(@ui,5)
   end
  set @c = ''del C:\pss.txt''
  exec master.dbo.xp_cmdshell @c, no_output
  end
 while (select top 1 count(*) from @s where d1 = 0) > 0
  begin
  select top 1 @id = id1, @ud = ud from @s where d1 = 0
  exec sp_trace_generateevent 82, N''blocking'', @ud
  delete @s where id1 = @id
  end
end
finish:', @database_name = N'master', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 3, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobstep @job_id = @JobID, @step_id = 5, @step_name = N'performance', @command = N'-- performance check
declare @s table (id1 int IDENTITY, UserData nvarchar(128))
declare @UserData nvarchar(128), @id1 int, @p varchar(3), @b varchar(3), @rc int
, @cmd nvarchar(80),@userinfo nvarchar(128), @row int, @lastrow int
select @p = cast(rtrim(ltrim(substring(c1,charindex(''='',c1,1)+1,len(c1)))) as nvarchar (3))
  from _t1 where left(c1,3) =  ''@pe''
if upper(@p) != ''YES'' goto finish
insert into @s 
select
  left([object_name],40)
+ left([counter_name],40)
+ left([instance_name],35)
+ cast([cntr_value] as nchar(11))
  from master.dbo.sysperfinfo where cntr_value > 0
while (select top 1 [id1] from @s) > 0
 begin
 select top 1 @id1 = [id1], @UserData = [UserData] from @s
 exec sp_trace_generateevent @eventid = 83,  @userinfo = @UserData
 delete @s where [id1] = @id1
 end
finish:
if exists (select * from dbo.sysobjects where id = object_id(N''[_t1]'') and OBJECTPROPERTY(id, N''IsUserTable'') = 1)
drop table [_t1]', @database_name = N'master', @server = N'', @database_user_name = N'', @subsystem = N'TSQL', @cmdexec_success_code = 0, @flags = 0, @retry_attempts = 0, @retry_interval = 1, @output_file_name = N'', @on_success_step_id = 0, @on_success_action = 1, @on_fail_step_id = 0, @on_fail_action = 2
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_update_job @job_id = @JobID, @start_step_id = 1 

  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the job schedules.
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'schedule00seconds', @enabled = 1, @freq_type = 4, @active_start_date = 20001220, @active_start_time = 0, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 1, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'schedule30seconds', @enabled = 1, @freq_type = 4, @active_start_date = 20001227, @active_start_time = 30, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 1, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'schedule15seconds', @enabled = 1, @freq_type = 4, @active_start_date = 20001227, @active_start_time = 15, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 1, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id = @JobID, @name = N'schedule45seconds', @enabled = 1, @freq_type = 4, @active_start_date = 20001227, @active_start_time = 45, @freq_interval = 1, @freq_subday_type = 4, @freq_subday_interval = 1, @freq_relative_interval = 0, @freq_recurrence_factor = 0, @active_end_date = 99991231, @active_end_time = 235959
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

  -- Add the Target Servers.
  EXECUTE @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @JobID, @server_name = N'(local)' 
  IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback 

END
COMMIT TRANSACTION
GOTO   EndSave
QuitWithRollback:
  IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION 
EndSave: 