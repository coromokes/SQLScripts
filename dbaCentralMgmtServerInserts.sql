--USE [msdb]
--GO
--SELECT	g.[name] AS [Group],
--		s.[name] AS [SQLAlias],
--		s.[server_name] AS [SQLInstance],
--		s.[description] AS [Description]
--FROM    [dbo].[sysmanagement_shared_server_groups_internal] g
----use INNER JOIN to not show empty folders
--LEFT JOIN [dbo].[sysmanagement_shared_registered_servers_internal] s
--	ON	g.[server_group_id] = s.[server_group_id]
--WHERE	g.[server_type] = 0 --dbengine group
--	AND	g.[is_system_object] = 0 --user added only
--ORDER BY [Group], [SQLAlias] --alpha sort
--GO
--select * from [dbo].[sysmanagement_shared_server_groups_internal]
--select * from [sysmanagement_shared_registered_servers_internal]

insert into sysmanagement_shared_registered_servers_internal
 (server_group_id,name,server_name,description, server_type)
select 18,  instance, instance, i.Description,0 from [pivssq08\pivssq08].dataservices.dbo.dbainstance i 
  inner join [pivssq08\pivssq08].dataservices.dbo.dbadrsite d on d.instanceid = i.instanceid
inner join (
select 'STA0PIW-SCSQ01' as ServerName
union
select 'STA0PIW-SCSQ02'
union
select 'STA0PIW-SQCN05'
union
select 'STA0PIW-SQCN06'
union
select 'STA0PIW-SQCN07'
union
select 'STA0PIW-SQCN08'
union select'STA0PIW-SQCN21'
union select'STA0PIW-SQCN22'
union select'STA0PIW-SQCN23'
union select'STA0PIW-SQCN24'
union select'STA0PIW-SQCN25'
union select'STA0PZW-SQCN03'
union select'STA0PZW-SQCN04') x on x.servername = i.activenode
group by i.instance,i.Description