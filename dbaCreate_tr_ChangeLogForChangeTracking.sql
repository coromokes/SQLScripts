use dataservices
go
CREATE TABLE [dbo].[ChangeLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[DatabaseName] [varchar] (256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EventType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ObjectName] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ObjectType] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SqlCommand] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EventDate] [datetime] NOT NULL CONSTRAINT [DF_EventsLog_EventDate]  DEFAULT (getdate()),
	[LoginName] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON DEF

alter table changelog add AlertSent char(1) constraint df_changelog_alertsent default('N')
go

use rmdev
go
create trigger tr_ChangeLog
on database
for create_procedure, alter_procedure, drop_procedure,
create_table, alter_table, drop_table,
create_function, alter_function, drop_function
as

set nocount on

declare @data xml
set @data = EVENTDATA()

insert into dataservices.dbo.changelog(databasename, eventtype, 
    objectname, objecttype, sqlcommand, loginname)
values(
@data.value('(/EVENT_INSTANCE/DatabaseName)[1]', 'varchar(256)'),
@data.value('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)'), 
@data.value('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(256)'), 
@data.value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(25)'), 
@data.value('(/EVENT_INSTANCE/TSQLCommand)[1]', 'varchar(max)'), 
@data.value('(/EVENT_INSTANCE/LoginName)[1]', 'varchar(256)')
)

go

alter trigger tr_changelog_i on changelog
for insert
as
begin
 /* desc: alerts the dba's when an object change has occurred
  *
  * mods:
  * 2009-01-07  msb  Initial coding
  */
  set nocount on 
  
  exec msdb.dbo.sp_send_dbmail
    @recipients = 'mbrown2@kforce.com',
    @subject = 'The below database change has occurred, please review and contact the user with any questions/concerns',
    @query = 'select ''
      Database: '' + DatabaseName + ''
      Object: '' + ObjectName + ''
      Object Type: '' + ObjectType + ''
      SqlCommand: '' + SqlCommand + ''
      Login: '' + LoginName 
  from dataservices.dbo.changelog (nolock)
  where alertsent = ''N'''

  update changelog
      set alertsent = 'Y'
    where alertsent = 'N'
      
end
go





