/* msb

Note	creates a list of columns for the specified table

Useful for creating insert statemnts

*/
declare @temp varchar(8000)

select @temp = COALESCE(@temp + '','') + 
    case 
      when c.colid % 3 = 0 then
        rtrim(c.name) + ', ' + char(13)
      else 
        rtrim(c.name) + ', '
      end
  from syscolumns c with (nolock)
    inner join sysobjects o with (nolock) on o.id = c.id
  where o.type = 'u'
    and o.name = 'PS_RI_REV_FACT_TBL'
  order by c.colid

select isnull(@temp,'')
