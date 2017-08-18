/* Use first section to move variables from non-prod to prod if necessary 
  Otherwise you can create from existing in prod server and/or add new as defined

set identity_insert internal.environment_variables on
go
insert into internal.environment_variables
(variable_id, environment_id, name,  description, type, sensitive,  value, sensitive_value, base_data_type)
 select variable_id, environment_id, name,  description, type, sensitive,  value, sensitive_value, base_data_type
   from [nivssq21\nivssq21].ssisdb.internal.environment_variables
   where environment_id = 1
set identity_insert internal.environment_variables off
go
*/


--Use this to update existing changing the @enviro as needed
use ssisdb;

declare @enviro varchar(100)
set @enviro = 'uat'

select *
  from internal.environment_variables v
    inner join internal.environments e on e.environment_id = v.environment_id
    where environment_name = @enviro
	and name in('EV_DBProxy_URI','EV_DQS_ConnectionString')

update internal.environment_variables
  set value = 'https://eisaccountbureauuat.azurewebsites.net/api/account/creditcheck/v1'
  where environment_id = (select environment_id from internal.environments where environment_name = @enviro)
  and name = 'EV_DBProxy_URI'



--select * from internal.environments
--update   internal.environment_variables
--  set environment_id =2

--select * from internal.environment_variables

--update internal.environment_variables
--  set value = 'crm-kfrc-account-dev'
--  where environment_id = 2
--  and name = 'EV_DBProxy_User'



