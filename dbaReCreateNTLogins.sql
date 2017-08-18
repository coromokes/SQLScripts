/* msb

Note	Script for recreating NT logins

*/
select 
    'exec sp_grantlogin @loginame = ''' + loginname + '''',
    ' exec sp_defaultdb @loginame = ''' + loginname + '''',
    ', @defdb = ''' + dbname + '''' + char(13)
  from master.dbo.syslogins with (nolock)
  where loginname not in ('builtin\administrators')
    and isntname = 1