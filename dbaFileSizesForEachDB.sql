sp_msforeachdb 'use [?]; select name,round((cast(FILEPROPERTY( rtrim(name) ,''SpaceUsed'') as float)/128),0) SpaceUsed,

    round((cast((size) as float)/128),0) Allocated, 

    round((cast((size) as float)/128)
,0) -

    round((cast(FILEPROPERTY( rtrim(name) ,''SpaceUsed'') as float)/128),0) Unused,

    cast(round((cast(FILEPROPERTY( rtrim(name) ,''SpaceUsed'') as float)/128),0) /

    round((cast((size) as float)/128),0) as numeric(5,2)) * 100 ''% Used'',

    filename, groupname

  from dbo.sysfiles f

    left join dbo.sysfilegroups g on g.groupid = f.groupid'