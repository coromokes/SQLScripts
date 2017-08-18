
  open symmetric key keyconnectionstring
  decryption by certificate crtconnectionstring;

  insert into dbainstance
  (InstanceID,instance, audited, description,
   purposeid, bumethodid, locationid,enabled,
    connectionstring, 
   servername,port, notnsfile, version, KnocMonitored,ChangeRecoveryModel)
  select
   '234','STA2NIW-SQLX07\DBAi', 'N', 'DBAI Test Instance',
   1, 2, null,'Y', 
   ENCRYPTBYKEY(KEY_GUID('keyconnectionstring'),cast('Data Source=STA0PIW-SQCN25\POWERPIVOT;Provider=SQLNCLI10.1;Integrated Security=SSPI;Auto Translate=False;' as varbinary(2000))),
   '\\STA2NIW-SQLX07\', 40517, 0, 2014, 'n',0

  close symmetric key keyconnectionstring

--update 
  open symmetric key keyconnectionstring
  decryption by certificate crtconnectionstring;

update dbainstance
  set ConnectionString = ENCRYPTBYKEY(KEY_GUID('keyconnectionstring'),cast('Data Source=pivssq26\pivssq26;Provider=SQLNCLI10.1;Integrated Security=SSPI;Auto Translate=False;' as varbinary(2000)))
  where instance = 'pivssq26\pivssq26'

  close symmetric key keyconnectionstring

--verify
select * from dbainstance
where InstanceID = 234

  open symmetric key keyconnectionstring
  decryption by certificate crtconnectionstring;

update dbainstance
  set ConnectionString = ENCRYPTBYKEY(KEY_GUID('keyconnectionstring'),cast('Data Source=STA2NIW-SQLX07\DBAi;Provider=SQLNCLI10.1;Integrated Security=SSPI;Auto Translate=False;' as varbinary(2000)))
  where InstanceID = 234
--instance = 'STA0PIW-SQCN25\POWERPIVOT'
  close symmetric key keyconnectionstring


update dbainstance
  set enabled = 'N'
where InstanceID = 234

