select 'dbcc shrinkfile (''' + rtrim(name) + ''', ' 
    + cast(round((cast(FILEPROPERTY( rtrim(name) ,'SpaceUsed') as float)/128),0) as varchar)
--    + cast(cast((cast(FILEPROPERTY( rtrim(name) ,'SpaceUsed') as float)/128) + ((cast(FILEPROPERTY( rtrim(name) ,'SpaceUsed') as float)/128) * .1) as int) as varchar) 
    + ')
go'
  from sysfiles with (nolock)
  where groupid != 0
  order by name



