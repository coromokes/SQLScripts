/* msb

Note	creates a list of columns for the specified table

Useful for creating update statemnts

*/


select space(6) + rtrim(c.name) + ' = i.' + c.name + ','
  from syscolumns c with (nolock)
    inner join sysobjects o with (nolock) on o.id = c.id
  where o.type = 'u'
    and o.name = 'activity'




