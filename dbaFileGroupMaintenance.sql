
with FileSizes 
as
(
select
[FileSizeMB] =
convert(numeric(10,2),round(a.size/128.,2)),
[UsedSpaceMB] =
convert(numeric(10,2),round(fileproperty( a.name,'SpaceUsed')/128.,2)) ,
[UnusedSpaceMB] =
convert(numeric(10,2),round((a.size-fileproperty( a.name,'SpaceUsed'))/128.,2)) ,
[DBFileName] = a.name
--into #temp
from
sysfiles a
)


select  'dbcc shrinkfile (' 
		+ dbfilename
		+ ','
		+ cast(cast(UsedSpaceMB as int) as varchar(100)) 
		+ ')' 
from	filesizes 

where	(UnusedSpaceMB / FileSizeMB) * 100 > 9.0
and		usedspacemb > 1.0



 