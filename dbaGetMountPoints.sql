;with c
as
(
SELECT db_name(vs.database_id) AS DatabaseName, vs.file_id, vs.volume_mount_point, vs.volume_id, vs.logical_volume_name, 
       vs.file_system_type, (vs.total_bytes/1024/1024/1024) AS [TotalSize(GB)], (vs.available_bytes/1024/1024/1024) AS [AvailableSize(GB)], 
       vs.supports_compression, vs.supports_alternate_streams, vs.supports_sparse_files, vs.is_read_only, vs.is_compressed 
FROM sys.master_files mf 
CROSS APPLY sys.dm_os_volume_stats(mf.database_id, mf.file_id) vs 
--WHERE db_name(vs.database_id) like 'Adventure%'
)
select volume_mount_point, [totalsize(GB)], [availablesize(GB)]
  from c
  group by volume_mount_point, [totalsize(GB)], [availablesize(GB)]
