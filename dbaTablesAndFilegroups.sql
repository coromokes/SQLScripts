/* msb

Note	Returns active objects and associated filegroups they are located on

*/

select o.name, f.groupname, i.name
  from sysindexes i with (nolock)
    inner join sysfilegroups f with (nolock) on i.groupid = f.groupid
    inner join sysobjects o with (nolock) on o.id = i.id
  where reserved > 0
--    and groupname = 'primary'
  group by o.name, f.groupname, i.name
  order by f.groupname

 