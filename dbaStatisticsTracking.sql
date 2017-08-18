select *
  from sysindexes with (nolock)
  where id = object_id('activity')
    and indexproperty(id,name,'isstatistics') = 1