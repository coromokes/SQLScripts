select o.id, o.name, f.name, fg.groupname, f.size
  from sysfiles f with (nolock)
    inner join sysfilegroups fg with (nolock) on f.groupid = fg.groupid
    inner join sysindexes i with (nolock) on i.groupid = fg.groupid
    inner join sysobjects o with (nolock) on o.id = i.id
      and i.indid < 2
  where fg.groupname = 'data_d'
    and o.name not like 'sys%'
    and o.name not like 'ms%'
    and o.name not like 'dtprop%'
  order by o.name


