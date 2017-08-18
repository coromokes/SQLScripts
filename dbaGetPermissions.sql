select 'grant ' + case p.action
                 when 193 then 'SELECT'
                 when 195 then 'INSERT'
                 when 196 then 'DELETE'
                 when 197 then 'UPDATE'
                 when 26 then 'REFERENCES'
                 when 224 then 'EXECUTE'
                 else 'ERROR'
               end +
       ' on ' + o.name + ' to ' + u.name + '
go'
  from sysusers u
    inner join sysprotects p on u.uid = p.uid
    inner join sysobjects o on o.id = p.id
  where u.name = 'kforce\ttate'




