/* msb

Note	Script for transferring logins from one server to another

*/

set nocount on
select 
    'exec sp_addlogin @loginame = ''' + loginname + ''''
    ,', @defdb = ''' + dbname + ''''
    ,', @deflanguage = ''' + language + ''''
    ,', @encryptopt = ''skip_encryption'''
    ,', @passwd ='
    , cast(password as varbinary(256))
    ,', @sid ='
    , sid 
  from syslogins
  where name not in ('sa')
    and isntname = 0
