select ''alter database '' + DB_NAME(database_id) + '' modify file (name='' + name + '', filegrowth=256MB);''
from sys.master_files

