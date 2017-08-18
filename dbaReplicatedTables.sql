select 'exec sp_addarticle @publication = N''RMQA2'', @article = N''' + source_object + ''', @source_owner = N''dbo'', @source_object = N'
  + '''' + source_object + ''', @type = N''logbased'', @description = N'''', @creation_script = N'''', @pre_creation_cmd = N''drop'', @schema_option = 0x000000000803509F, @identityrangemanagementoption = N''manual'', 
  @destination_table = N' + '''' + source_object + ''', @destination_owner = N''dbo'', @status = 24, @vertical_partition = N''false'', @ins_cmd = N''CALL [sp_MSins_dbo'
  + source_object + ''', @del_cmd = N''CALL [sp_MSdel_dbo' + source_object + ''', @upd_cmd = N''SCALL [sp_MSupd_dbo' + source_object + ''', @force_invalidate_snapshot = 1' + '
GO'
  from distribution.dbo.MSarticles a with (nolock)
  where a.publisher_db = 'rmprod'
  order by source_object

