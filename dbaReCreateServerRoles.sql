select * from sys.server_principals as l
  join sys.server_role_members as rm
    on l.principal_id = rm.member_principal_id
  join sys.server_principals as r
    on rm.role_principal_id = r.principal_id
where l.principal_id <> 1
  and l.name not like 'NT%';