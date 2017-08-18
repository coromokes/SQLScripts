-- Checks trigger status for tablename below
select
	name,
	status = case when objectproperty (id, 'execistriggerdisabled') = 0
		then 'enabled' else 'disabled' end,
	owner = object_name (parent_obj)
from
	sysobjects
where
	type = 'tr' and
	parent_obj = object_id ('billable_placement')