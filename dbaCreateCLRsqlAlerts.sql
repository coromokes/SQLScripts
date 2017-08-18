select 'EXEC msdb.dbo.sp_add_alert @name=N''CLR Monitoring - ' + cast(error as varchar) + ''' , 
		@message_id=' + cast(error as varchar) + ', 
		@severity=0, 
		@enabled=1, 
		@delay_between_responses=300, 
		@include_event_description_in=3, 
		@category_name=N''[Uncategorized]'',
		@job_id=N''00000000-0000-0000-0000-000000000000''
go'
 from sys.sysmessages
where description like '%.net%'
  and msglangid = 1033
order by error