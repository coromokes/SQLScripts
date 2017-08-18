--resturns all fields that are part of the cuselect * 
from sys.columns c 
inner join sys.fulltext_index_columns fic on c.object_id = fic.object_id 
  and c.column_id = fic.column_id
where c.object_id = object_id('candidates')