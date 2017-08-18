

--Use this sql to identify which tables have ghost records
--Most commonly used when a data file will not shrink


--sql 2005 and above
SELECT	ghost_record_count ,
        version_ghost_record_count , 
        *
FROM	sys.dm_db_index_physical_stats(DB_ID('rmprod'),
        OBJECT_ID('CandidatesW5'), NULL, NULL, 'DETAILED')

--DBCC method
DBCC TRACEON (2514,-1) 

DECLARE @table_name varchar(1000),@sql nvarchar(4000), 
  @filegroupid int

set @filegroupid = 1 --primary

declare c1 cursor for select name from sysobjects where name in
(
select distinct object_name(id) as Table_name from sysindexes  where groupid = @filegroupid
) and xtype = 'U'

open c1

                fetch next from c1 into @table_name
                while @@Fetch_Status = 0

        begin

                 Select @sql = 'DBCC CHECKTABLE ('+ @table_name +')'

         print @sql

         exec sp_executesql @sql

                 fetch next from c1 into @table_name

        end

close c1

deallocate c1

GO

DBCC TRACEOFF(2514,-1)