IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Notify Data Services'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Notify Data Services' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Notify Data Services', @enabled = 1, @email_address = N'Notify Data Services', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 80000, @weekday_pager_end_time = 180000, @saturday_pager_start_time = 80000, @saturday_pager_end_time = 180000, @sunday_pager_start_time = 80000, @sunday_pager_end_time = 180000, @pager_days = 62
END
go

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Notify Front Office'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Notify Front Office' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Notify Front Office', @enabled = 1, @email_address = N'Notify Front Office', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 80000, @weekday_pager_end_time = 180000, @saturday_pager_start_time = 80000, @saturday_pager_end_time = 180000, @sunday_pager_start_time = 80000, @sunday_pager_end_time = 180000, @pager_days = 62
END
go

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Notify Operations'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Notify Operations' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Notify Operations', @enabled = 1, @email_address = N'Notify Operations', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 80000, @weekday_pager_end_time = 180000, @saturday_pager_start_time = 80000, @saturday_pager_end_time = 180000, @sunday_pager_start_time = 80000, @sunday_pager_end_time = 180000, @pager_days = 62
END
go

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Notify System Services NT'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Notify System Services NT' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Notify System Services NT', @enabled = 1, @email_address = N'Notify System Services NT', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 80000, @weekday_pager_end_time = 180000, @saturday_pager_start_time = 80000, @saturday_pager_end_time = 180000, @sunday_pager_start_time = 80000, @sunday_pager_end_time = 180000, @pager_days = 62
END
go

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Notify All'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Notify All' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Notify All', @enabled = 1, @email_address = N'Notify Data Services; Notify Front Office; Notify Operations; Notify System Services NT', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 80000, @weekday_pager_end_time = 180000, @saturday_pager_start_time = 80000, @saturday_pager_end_time = 180000, @sunday_pager_start_time = 80000, @sunday_pager_end_time = 180000, @pager_days = 62
END
go

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Notify DSFO'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Notify DSFO' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Notify DSFO', @enabled = 1, @email_address = N'Notify Data Services; Notify Front Office', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 80000, @weekday_pager_end_time = 180000, @saturday_pager_start_time = 80000, @saturday_pager_end_time = 180000, @sunday_pager_start_time = 80000, @sunday_pager_end_time = 180000, @pager_days = 62
END
go

IF (EXISTS (SELECT name FROM msdb.dbo.sysoperators WHERE name = N'Notify DSOFO'))
 ---- Delete operator with the same name.
  EXECUTE msdb.dbo.sp_delete_operator @name = N'Notify DSOFO' 
BEGIN 
EXECUTE msdb.dbo.sp_add_operator @name = N'Notify DSOFO', @enabled = 1, @email_address = N'Notify Data Services; Notify Operations; Notify Front Office', @category_name = N'[Uncategorized]', @weekday_pager_start_time = 80000, @weekday_pager_end_time = 180000, @saturday_pager_start_time = 80000, @saturday_pager_end_time = 180000, @sunday_pager_start_time = 80000, @sunday_pager_end_time = 180000, @pager_days = 62
END
go