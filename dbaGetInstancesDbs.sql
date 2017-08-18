declare @instance varchar(100)

select Instance, dbname
, case 
  when ClusterNodes is null then replace(servername,'\','') else clusternodes end as 'Server(s)'
--, ActiveNode
--,lastrestartdate
,i.Description
,case 
  when Instance like 'nz%' then
    left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + '.KFORCENZ.LOCAL\' + left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + ', ' + CAST(PORT AS VARCHAR)
  when Instance like 'pz%' then    
    left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + '.KFORCEPZ.LOCAL\' + left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + ', ' + CAST(PORT AS VARCHAR)
  else '' 
 end as AltInstanceName
 from dbaInstance i
    inner   join dbaPurpose p on p.purposeid  = i.purposeid  
	inner join dbadatabase d on i.instanceid = d.instanceid
 where Enabled in ('Y','A')
   --and ClusterNodes is not null
   and p.Purpose = 'production'
   and (isnull(@instance, '') = '' and 1=1
     or isnull(@instance,'') <> '' and i.instance like @instance)

union
select Instance,  dbname, 
case 
  when ClusterNodes is null then replace(servername,'\','') else clusternodes end as 'Server(s)'
--, ActiveNode
--,lastrestartdate
,i.Description
,case 
  when Instance like 'nz%' then
    left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + '.KFORCENZ.LOCAL\' + left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + ', ' + CAST(PORT AS VARCHAR)
  when Instance like 'pz%' then    
    left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + '.KFORCEPZ.LOCAL\' + left(i.Instance,len(i.Instance)-charindex('\',i.Instance)) + ', ' + CAST(PORT AS VARCHAR)
  else '' 
 end as AltInstanceName
 from [nivssq08\nivssq08].dataservices.dbo.dbaInstance i
    left join dbaPurpose p on p.purposeid  = i.purposeid  
inner join [nivssq08\nivssq08].dataservices.dbo.dbadatabase d on i.instanceid = d.instanceid
 where Enabled in ('Y','A')
   --and ClusterNodes is not null
   and p.Purpose = 'Non-Production'

   order by Instance, dbname   

