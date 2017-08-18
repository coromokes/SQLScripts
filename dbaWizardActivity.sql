select numusers, lastbatch, datecreated, datediff(mi, LastBatch, datecreated)
  from dataservices.dbo.dbaActivity with (nolock)
  order by datecreated desc

--Active connnections in the last 6 mins
select *
  from dataservices.dbo.dbaActivity with (nolock)
  where datecreated > getdate() - 1
    and datediff(mi, LastBatch, datecreated) < 6
  order by datecreated desc

--Active connnections in the last 12 mins
select *
  from dataservices.dbo.dbaActivity with (nolock)
  where datecreated > getdate() - 1
    and datediff(mi, LastBatch, datecreated) < 11
    and datediff(mi, LastBatch, datecreated) > 6
  order by datecreated desc

--Active connnections in the last 12-20 mins
select *
  from dataservices.dbo.dbaActivity with (nolock)
  where datecreated > getdate() - 1
    and datediff(mi, LastBatch, datecreated) < 16
    and datediff(mi, LastBatch, datecreated) > 11
  order by datecreated desc

--Total active users over the last 15 mins
select sum(numusers), datecreated
  from dataservices.dbo.dbaActivity with (nolock)
  where datediff(mi, LastBatch, datecreated) <= 16
    and datecreated > getdate() - 1
  group by datecreated
  order by datecreated desc




--Reporting user activity last 5 mins
set nocount on 

select numusers ActiveUsers, DateCreated
  from dataservices.dbo.dbaActivity with (nolock)
  where (datecreated > '2004-05-04 23:59:59' and datecreated < '2004-05-06')
    and datediff(mi, LastBatch, datecreated) < 6
  order by datecreated desc

--Reporting user activity last 15 mins
select sum(numusers) ActiveUsers, datecreated
  from dataservices.dbo.dbaActivity with (nolock)
  where (datecreated > '2004-05-04 23:59:59' and datecreated < '2004-05-06')
    and datediff(mi, LastBatch, datecreated) <= 16
  group by datecreated
  order by datecreated desc
