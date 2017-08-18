insert into msdb.dbo.sysssispackagefolders
select a.folderid, a.parentfolderid, foldername
  from [pivssq11\pivssq11].msdb.dbo.sysssispackagefolders a
  where not exists (select 1 from msdb.dbo.sysssispackagefolders b where a.foldername = b.foldername)


--select *
--  from [pivssq11\pivssq11].msdb.dbo.sysssispackagefolders a
--  where not exists (select 1 from msdb.dbo.sysssispackagefolders b where a.foldername = b.foldername)
--    and parentfolderid = '00000000-0000-0000-0000-000000000000'
    
insert into msdb.dbo.sysssispackages
select *
  from [pivssq11\pivssq11].msdb.dbo.sysssispackages a
  where not exists (select 1 from msdb.dbo.sysssispackages b where a.name = b.name)
