EXEC [msdb].[dbo].[sp_syscollector_start_collection_set] @collection_set_id=1
EXEC [msdb].[dbo].[sp_syscollector_start_collection_set] @collection_set_id=2
EXEC [msdb].[dbo].[sp_syscollector_start_collection_set] @collection_set_id=3

exec [msdb].[dbo].sp_syscollector_update_collection_set @collection_set_id=6,  @schedule_name = 'CollectorSchedule_Every_60min'

EXEC [msdb].[dbo].[sp_syscollector_start_collection_set] @collection_set_id=6