select 'grant select on [' +
    o.name + 
    '] to Integration
go'
  from sysobjects o
  where xtype in ('u')
    and name not like 'dt%'