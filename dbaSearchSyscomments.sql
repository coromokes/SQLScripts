select name
  from syscomments c with (nolock)
    inner join sysobjects o with (nolock) on c.id = o.id
  where text like '%xp_sendmail%'


