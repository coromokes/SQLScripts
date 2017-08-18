select t.name, t.length, t.xprec, t.xscale as [Precision/Scale], tt.name
  from systypes t
    inner join master.dbo.systypes tt on t.xtype = tt.xtype
  where not exists (select 1
                      from master.dbo.systypes x 
                      where x.name = t.name)
  order by t.name

