
select object_name(c.id)
  from syscolumns c
    inner join sysobjects o on o.id = c.id
  where c.name like '%DivCMContactNum%'
    and o.type = 'u'


