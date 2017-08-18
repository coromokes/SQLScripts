select ':connect ' + instance + '
use ' + dbname + ';
grant select on users to webgroup;'
  from dbadatabase d
    inner join dbainstance i on i.instanceid = d.instanceid
  where dbname like 'rm%'
and enabled = 'y'
  and instance not like '%biz%'
  and port != 1433
  and i.purposeid != 4
  and dbname not in ('RmBGEval','RMFunctionFLSARules')


