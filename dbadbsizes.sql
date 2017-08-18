with fs
as
(
    select database_id, name, type, size * 8.0 / 1024 size, physical_name
    from sys.master_files
)
select 
    name,
    (select sum(size) from fs where type = 0 and fs.database_id = db.database_id) DataFileSizeMB,
    (select sum(size) from fs where type = 1 and fs.database_id = db.database_id) LogFileSizeMB
	,(select max(physical_name) from fs where type = 1 and fs.database_id = db.database_id) physical_name
from sys.databases db
--where name like '%SPContentKNETQA%'
  order by 2 desc 