set nocount on 
declare @hour char(2), @cnt int
set @cnt = 6

while @cnt <= 24 
begin
  select @hour = right('0' + cast(@cnt as varchar),2)

  select 'restore log rmread 
    from disk = ''\\sta0ms72\i$\RMMAINVS\Logs\rmprod_backup_20070815' + @hour + '00.trn''' + ' with norecovery
  go'
  union
  select 'restore log rmread 
    from disk = ''\\sta0ms72\i$\RMMAINVS\Logs\rmprod_backup_20070815' + @hour + '10.trn''' + ' with norecovery
  go'
  union
  select 'restore log rmread 
    from disk = ''\\sta0ms72\i$\RMMAINVS\Logs\rmprod_backup_20070815' + @hour + '20.trn''' + ' with norecovery
  go'
  union
  select 'restore log rmread 
    from disk = ''\\sta0ms72\i$\RMMAINVS\Logs\rmprod_backup_20070815' + @hour + '30.trn''' + ' with norecovery
  go'
  union
  select 'restore log rmread 
    from disk = ''\\sta0ms72\i$\RMMAINVS\Logs\rmprod_backup_20070815' + @hour + '40.trn''' + ' with norecovery
  go'
  union
  select 'restore log rmread 
    from disk = ''\\sta0ms72\i$\RMMAINVS\Logs\rmprod_backup_20070815' + @hour + '50.trn''' + ' with norecovery
  go'

  set @cnt = @cnt + 1
end
