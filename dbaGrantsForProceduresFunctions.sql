select 'grant execute on ' + name + ' to [KFORCE\cfas developers]
go'
  from sysobjects
  where type in ('P')

select 'grant execute on ' + name + ' to [KFORCE\cfas developers]
go'
  from sysobjects
  where type in ('FN')

select 'grant select on ' + name + ' to [KFORCE\cfas developers]
go'
  from sysobjects
  where type in ('IF','TF')
  
select distinct type
  from sysobjects
  where type in ('P')