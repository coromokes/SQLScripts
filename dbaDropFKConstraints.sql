/* msb

Note	Creates script to drop all fk constraints

*/

select 'alter table ' + table_name + ' drop constraint ' + CONSTRAINT_NAME + '
go'
  from  INFORMATION_SCHEMA.TABLE_CONSTRAINTS
  where CONSTRAINT_TYPE = 'FOREIGN KEY'
