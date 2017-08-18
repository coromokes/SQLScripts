select
    sys.objects.name,
    sys.indexes.name
	,'alter index ' + sys.indexes.name + ' on ' + sys.objects.name +  ' rebuild with (online=on)'
from sys.indexes
    inner join sys.objects on sys.objects.object_id = sys.indexes.object_id
where sys.indexes.is_disabled = 1
order by
    sys.objects.name,
    sys.indexes.name